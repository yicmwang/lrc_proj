clear
close all force

run setup.m
import casadi.*

q = MX.sym('q', 14);     % joint angles
dq = MX.sym('dq', 14);   % joint velocities
% p = MX.sym('p', 6);     % floatbase position/angles
% v = MX.sym('v', 6);     % floatbase velocities

model = makeModel(0);

nb = model.NB;

%% spatial v2 find spatial momentum n stuff


ret = EnerMo(model, q, dq);
PosCM = ret.cm;
Xcom = xlt(-PosCM);


%% centroidal momentum formulation

% P matrix, I matrix and Phi vector formulation
% q = zeros(nb, 1);
P = casadi.MX(nb * 6, nb * 6);
Phi = zeros(nb * 6, nb);
I = casadi.MX( nb * 6, nb * 6);

% P = cell(6,6);
% jPos = [p; q];
for ii = 1:nb
    [Xj, S] = jcalc(model.jtype{ii}, q(ii));
    Xup = Xj * model.Xtree{ii};
    Phi(ii*6-5:ii*6, ii) = S;
    I(ii*6-5:ii*6, ii*6-5:ii*6) = model.I{ii};
    for jj = 1:nb
        if ii == jj
            Pij = eye(6);
        elseif jj == model.parent(ii)
            Pij = -Xup;
        else
            Pij = zeros(6);
        end
        % P{ii, jj} = Pij;
        P(ii*6-5:ii*6, jj*6-5:jj*6) = Pij;
    end
end
% Phi = diag(Phi_vec);
XG = casadi.MX(nb*6, 6);
for ii = 1:nb
    parentii = model.parent(ii);
    [Xj, S] = jcalc(model.jtype{ii}, q(ii));
    Xup = Xj * model.Xtree{ii};
    while parentii ~= 0
        [Xj, S] = jcalc(model.jtype{parentii}, q(parentii));
        Xpar = Xj * model.Xtree{parentii};
        Xup = Xup * Xpar;
        parentii = model.parent(parentii);
    end
    XGi = Xup * Xcom;
    XG(ii*6-5:ii*6, :) = XGi;
end

J = inv(P) * Phi;
A = I * J;

AG = XG.' * A;

AG_fun = Function('AG_fun', {q}, {AG});
% htot_fun = Function('htot_fun',  {q, dq}, {ret.htot});
AG_fun.save('AG_fun.casadi');

% h = full(AG_fun(zeros(14, 1))) * [1; zeros(13, 1)];

syms x y z dx dz dy real
R = rotz(z) *  roty(y) * rotx(x);
R = R(1:3, 1:3);
dRx = diff(R, x);
dRy = diff(R, y);
dRz = diff(R, z);

w = simplify(skew(((dRx * dx + dRy *dy + dRz * dz) * R')'));
w_mat = jacobian(w, [dx, dy, dz]')

xyz = MX.sym('xyz', 3);
x = xyz(1);
y = xyz(2);
z = xyz(3);


% W_mat = [sin(y), 0, 1;
%          cos(y) * sin(z), cos(z), 0;
%          cos(y) * cos(z), -sin(z), 0];
% W_mat = [0,     - sin(z),   cos(y) * cos(z);
%          0,     cos(z),     cos(y) * sin(z);
%          1,     0,          -sin(y)];
W_mat = [cos(y)*cos(z), sin(z), 0;
         - cos(y)*sin(z), cos(z), 0;
         sin(y), 0, 1];
W_fun = Function('W_fun', {xyz}, {W_mat});
W_fun.save('W_fun.casadi');