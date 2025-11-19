clear
close all
run setup.m

import casadi.*

model = makeModel(0);
time = 2; %s
n = 100;
mpc_n = 500;

dt = time / n;
weights = [1, 1];
t_span = linspace(0, time, n);
Nhor = 50;

AG_fun = Function.load('AG_fun.casadi');

uweights_TO = ones(8,1) * .01;
             %h weights  xyz weights  orientation weights, q, dq weights
errweights_TO = [zeros(3,1); 1; 1; 1; zeros(8, 1) * .1; zeros(14,1)];
uweights = ones(8,1) * .001;
             %h weights  xyz weights  orientation weights, q, dq weights
errweights = [zeros(6,1); zeros(3,1); 10; 10; 10; ones(8, 1) * 1; ones(8,1) * 0.01];
MPC = myMPC(Nhor, time/mpc_n, uweights, errweights);
% sound(sin(linspace(0, 1, 8912) * 100 * pi) * 10000)

%%
q_hist = zeros(14,1);
dq_hist = zeros(14,1);
t_hist = zeros(1);
tau_hist = zeros(8, 1);
h = zeros(6,1);

x_des = [zeros(3,n); zeros(2,n); t_span / time * pi; zeros(8, n); zeros(14,n)]; %normal

load("TO_results.mat")

if false
    if false
        TO = myTO(model, n, uweights_TO, errweights_TO);
        % TO.save('TO_fun.casadi');
        gong()
    else
        TO = Function.load('TO_fun.casadi');
    end
    Xii = zeros(28, 1); %normal
    [x_des_TO, u_des_TO, obj_TO] = TO(Xii, x_des, dt);
    x_des_TO = full(x_des_TO);
    u_des_TO = full(u_des_TO);
    save("TO_results", "u_des_TO", "x_des_TO");
    sound(sin(linspace(0, 1, 8912) * 100 * pi) * 10000)
    gong()
end
showmotion(model, t_span(1:n), x_des_TO(1:14, :));


x_des_TO = [zeros(3, n);full(x_des_TO(4:end, :))]; % take out COM drift

F = griddedInterpolant(t_span(1:100)', x_des_TO');
t_span = linspace(0, time, mpc_n);
x_des_TO_interp = F(linspace(0, time, mpc_n)')';


% x_aug_des_TO = zeros(34, n);
% sound(sin(linspace(0, 1, 8912) * 100 * pi) * 10000)

% calculate augmented state

% for ii = 1:size(t_span,2)
%     qii = x_des_TO(1:14,ii);
%     dqii = x_des_TO(15:28, ii);
%     hii = full(AG_fun(qii)) *dqii;
%     x_aug_des_TO(:, ii) = [hii; qii; dqii];
% end
x_aug_des_TO = [zeros(6, mpc_n); x_des_TO_interp(1:14, :); x_des_TO_interp(21:28, :)];
x_aug_des_TO = [x_aug_des_TO, x_aug_des_TO(:,end) * ones(1, Nhor)];
t_span = [t_span, t_span(end) + time/mpc_n];
% x_aug_des_TO = [zeros(6,mpc_n);zeros(3,mpc_n); zeros(2,mpc_n); t_span / time * pi; zeros(8, mpc_n); zeros(8,mpc_n)]; %normal

Xii_simple = zeros(28, 1);
Xii = zeros(28, 1);     %augmented
X_mpc = zeros(28, Nhor);  %augmented
u = zeros(8, Nhor-1);
% main loop
for ii = 1:size(t_span,2)-1
    tii = t_span(ii);
    x_desii = x_aug_des_TO(:, ii:ii+Nhor-2);
    [X_mpc, u, obj] = MPC(Xii, x_desii, X_mpc, u);
    tau = TaufromU(model, full(u(:, 1)), Xii);
    tau = clip(tau, -10, 10);
    [tii_sim, xii_sim] = ode45(@(t, x) aerialDynamics(model, x, tau), t_span(ii:ii+1), Xii_simple(1:end));
    Xii_simple = xii_sim(end,:)';
    Xii = full(makeAugState(AG_fun, Xii_simple));
    t_hist = [t_hist, tii_sim'];
    q_hist = [q_hist, xii_sim(:,1:14)'];
    dq_hist = [dq_hist, xii_sim(:, 15:28)'];
    tau_hist = [tau_hist, tau(7:14) * ones(size(tii_sim))'];
end

%%
figure
subplot(3, 1, 1)
plot(t_hist, tau_hist);
% ylim([-2, 2])
subplot(3, 1, 2)
plot(t_hist, q_hist);
% ylim([-pi, pi])
subplot(3, 1, 3)
plot(t_hist, dq_hist);
% ylim([-pi, pi])
showmotion(model, t_hist, q_hist)
h_hist = zeros(6, size(t_hist,2));
% parfor ii = 1:size(t_hist,2)
%     qii = q_hist(:,ii);
%     dqii = dq_hist(:, ii);
%     hii = full(AG_fun(qii)) *dqii;
%     h_hist(:,ii) = hii;
% end
% subplot(4, 1, 4)
% plot(t_hist, h_hist);
% ylim([-5, 5])
gong()


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
    qb = x(1:6);
    qj = x(7:14);
    dqb = x(15:20);
    dqj = x(21:28);
    h = AG_fun([qb; qj]) * [dqb; dqj];
    x_aug = [h; qb; qj; dqj];
end

% function x_simple = makeSimpleState(x_aug)
% 
% end


function tau = TaufromU(model, u, x)
    % from enhanced state, u = qdd;
    [H, C] = HandC(model, x(7:20), [zeros(6,1);x(end-7:end)]);
    tau = H * [zeros(6, 1); u] + C;
    tau(1:6) = zeros(6,1);
end

function gong()
gong = load("gong.mat");
sound(gong.y, gong.Fs);
end