clear
close all
run setup.m

import casadi.*

model = makeModel(0);
time = 5; %s
dt = 0.1;
weights = [1, 1];
t_span = 0:dt:time;

AG_fun = Function.load('AG_fun.casadi');

uweights = ones(8,1) * .01;
             %h weights  xyz weights  orientation weights, q, dq weights
errweights = [zeros(6,1); zeros(3,1); 2; 10; 2; ones(8, 1) * .1; zeros(14,1)];
MPC = myMPC(dt, uweights, errweights);

%%
q_hist = zeros(14,1);
dq_hist = zeros(14,1);
t_hist = zeros(1);
n = size(t_span,2);
tau_hist = zeros(8, 1);
h = zeros(6,1);

x_des = [zeros(6,n); zeros(3,n); zeros(2,n); sin(t_span / time * pi) * pi/2; zeros(8, n); zeros(14,n)]; %augmented
Xii = zeros(34, 1); %augmented
X_mpc = zeros(34, 10); %augmented
u = zeros(8, 9);
% main loop
for ii = 1:size(t_span,2)-9
    tic
    tii = t_span(ii);
    x_desii = x_des(:, ii:ii+8);
    [X_mpc, u, obj] = MPC(Xii, x_desii, X_mpc, u);
    tau = TaufromU(model, full(u(:, 1)), Xii);
    tau = clip(tau, -50, 50);
    [tii_sim, xii_sim] = ode45(@(t, x) aerialDynamics(model, x, tau), t_span(ii:ii+1), Xii(7:end));
    Xii = xii_sim(end,:)';
    Xii = full(makeAugState(AG_fun, Xii));
    t_hist = [t_hist, tii_sim'];
    q_hist = [q_hist, xii_sim(:,1:14)'];
    dq_hist = [dq_hist, xii_sim(:, 15:28)'];
    tau_hist = [tau_hist, tau(7:14) * ones(size(tii_sim))'];
    toc
end
figure
plot(t_hist, tau_hist);
figure
plot(t_hist, q_hist);
figure
plot(t_hist, dq_hist);
showmotion(model, t_hist, dq_hist)
for ii = 1:size(t_hist,2)
    qii = q_hist(:,ii);
    dqii = dq_hist(:, ii);
    hii = full(AG_fun(qii)) *dqii;
    h_hist(:,ii) = hii;
end


function [dx] = aerialDynamics(model, x, tau)
    %x = [q, dq] (14, 14)
    %dx = [dq, ddq] (14, 14)
    q = x(1:14);
    dq = x(15:28);
    ddq = FDcrb(model, q, dq, tau);
    dx = [x(15:28); ddq];
    
end

function x_aug = makeAugState(AG_fun, x)
    % x_aug = [h, q, dq] (6, 14, 14)
    % x = [q, dq]
    q = x(1:14);
    dq = x(15:28);
    h = AG_fun(q) * dq;
    x_aug = [h; q; dq];
end

function tau = TaufromU(model, u, x)
    % from enhanced state, u = qdd;
    [H, C] = HandC(model, x(1:14), x(15:28));
    tau = H * [zeros(6, 1); u] + C;
    tau(1:6) = zeros(6,1);
end