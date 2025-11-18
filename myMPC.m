function MPC = myMPC(DT, weights)

import casadi.*


AG_fun = Function.load('AG_fun.casadi');
W_fun = Function.load('W_fun.casadi');
model = makeModel(0);


q = MX.sym('q', 14);     % [torso position; torso orientation (euler); joint angles];
dq = MX.sym('dq', 14);   % joint velocities
freq = 100;
dt = MX.sym('dt');


% Tb = [eye(3), zeros(3,3); zeros(3,3), inv(W_fun(q(4:6)))];

Tb = eye(6);

AG = AG_fun(q);
Ab = AG(:, 1:6);
Aj = AG(:, 7:end);

Ah_tilde = Tb * inv(Ab);
Aj_tilde = Tb * inv(Ab) *Aj;

% make augmented state x = [h, q, dq] (6, 14, 14)
% u = [ddq] (joint acceleration)
% use H and C to get tau from u (ddq)

H = [zeros(6, 34);
     Ah_tilde, zeros(6, 20), Aj_tilde;
     zeros(8, 26), eye(8);
     zeros(14, 34)];
G = [zeros(26, 8);
     eye(8)];

H_d = eye(34) + H * dt;
G_d = G * dt;

HandG = Function('HandG', {q, dt}, {H, G});
HandG.save('HandG.casadi');

opti = casadi.Opti();

Nhor = 10;
x = opti.variable(34, Nhor); % augmented state
% dx = opti.variable(34, Nhor);
u = opti.variable(8, Nhor-1);

X_init = opti.parameter(34);
XDes = opti.parameter(34,Nhor-1);
% DT = opti.parameter(1);
% weights = opti.parameter(2);
input = {X_init, XDes};

opti.subject_to(x(:, 1) == X_init);

obj = MX(0);

for ii = 1:Nhor-1
    Xii = x(:, ii);
    Uii = u(:, ii);
    [Hii, Gii] = HandG(Xii(7:20), DT);
    opti.subject_to(x(:, ii+1)== Hii * Xii + Gii * Uii)
    err = Xii - XDes(:, ii);
    obj = obj + Uii' * Uii * weights(1) + err' * err * weights(2);
end

opti.minimize(obj);

p_opts.print_time = false;
p_opts.verbose = false;
s_opts.print_level = 0;
s_opts.max_iter = 100;
opti.solver('ipopt', p_opts, s_opts);

MPC = opti.to_function('MPC', input, {x, u, obj});