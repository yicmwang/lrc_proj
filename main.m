run setup.m

clear
close all force

import casadi.*

model = makeModel();

showmotion(model);

%% MPC formulation

[H, C] = HandC(model)