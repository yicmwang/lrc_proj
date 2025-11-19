function TO = myTO(model, Nhor, uweights, errweights)

import casadi.*
% 
% 
% AG_fun = Function.load('AG_fun.casadi');
% W_fun = Function.load('W_fun.casadi');
% model = makeModel(0);
% 
% 
% q = MX.sym('q', 14);     % [torso position; torso orientation (euler); joint angles];
% dq = MX.sym('dq', 14);   % joint velocities
% % freq = 100;
% dt = MX.sym('dt');
% 
% 
% Tb = [zeros(3), eye(3); W_fun(q(4:6)), zeros(3)];
% 
% % Tb = eye(6);
% 
% AG = AG_fun(q);
% Ab = AG(:, 1:6);
% Aj = AG(:, 7:end);
% 
% Ah_tilde = Tb * inv(Ab);
% Aj_tilde = Tb * inv(Ab) *Aj;
% 
% % make augmented state x = [h, q, dq] (6, 14, 14)
% % u = [ddq] (joint acceleration)
% % use H and C to get tau from u (ddq)

opti = casadi.Opti();

% Nhor = length(t_span);
x = opti.variable(28, Nhor); % augmented state
% dx = opti.variable(34, Nhor);
u = opti.variable(8, Nhor-1);

X_init = opti.parameter(28);
XDes = opti.parameter(28,Nhor);
DT = opti.parameter();
% DT = opti.parameter(1);
% weights = opti.parameter(2);
input = {X_init, XDes, DT};

opti.subject_to(x(:, 1) == X_init);

obj = MX(0);

for ii = 1:Nhor-1
    qii = x(1:14, ii);
    dqii = x(15:end, ii);
    Uii = u(:, ii);
    ddqii = FDcrb(model, qii, dqii, [zeros(6,1);Uii]);
    % [Hii, Gii] = HandG(Xii(7:20), DT);
    opti.subject_to(x(1:14, ii+1)== DT * dqii + qii)
    opti.subject_to(x(15:end, ii+1)== DT * ddqii + dqii)
    err = [qii; dqii] - XDes(:, ii);
    obj = obj + Uii' * diag(uweights) * Uii  + err' * diag(errweights) * err;
    opti.subject_to(qii(7:14) < [deg2rad(75), deg2rad(75), 0, deg2rad(75), 0, deg2rad(75), deg2rad(75), 0]')
    opti.subject_to(qii(7:14) > [-deg2rad(75), -deg2rad(75), -deg2rad(75), -deg2rad(75), -deg2rad(130), 0, -deg2rad(75), -deg2rad(130)]')
    opti.subject_to(dqii(7:14) < 30 * ones(8, 1))
    opti.subject_to(dqii(7:14) > -30 * ones(8, 1))
%     opti.subject_to(dqii < 10 * ones(34, 1))
%     opti.subject_to(qii > -10 * ones(34, 1))
%     opti.subject_to(Uii < 10 * ones(8, 1))
%     opti.subject_to(Uii > -10 * ones(8, 1))
end

opti.minimize(obj);

p_opts.print_time = true;
p_opts.verbose = false;
s_opts.print_level = 5;
% s_opts.max_iter = 5;
opti.solver('ipopt', p_opts, s_opts);

TO = opti.to_function('TO', input, {x, u, obj});