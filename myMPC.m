clear
close all force

run setup.m
import casadi.*

AG_fun = Function.load('AG_fun.casadi');
model = makeModel(0);

q = MX.sym('q', 14);     % [torso position; torso orientation (euler); joint angles];
dq = MX.sym('dq', 14);   % joint velocities

R = rotx(q(4)) * roty(q(5)) * rotz(q(6));
dRx = jacobian(R, q(4));