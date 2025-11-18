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
Xcom = xlt(PosCM);


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
    XGi = Xup * inv(Xcom);
    XG(ii*6-5:ii*6, :) = XGi;
end

J = inv(P) * Phi;
A = I * J;

AG = XG.' * A;

AG_fun = Function('AG_fun', {q}, {AG});
% htot_fun = Function('htot_fun',  {q, dq}, {ret.htot});
AG_fun.save('AG_fun.casadi');

% h = full(AG_fun(zeros(14, 1))) * [1; zeros(13, 1)];


