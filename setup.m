clear
% close all hidden

addpath(genpath('spatial_v2_extended'))
addpath(genpath('robot_zoo'))
addpath(genpath('examples'))
addpath(genpath('utils'))
if ismac
    addpath(genpath('casadi-main-osx_arm64-matlab2018b'))
elseif ispc
    addpath(genpath('casadi-3.6.7-windows64-matlab2018b'))
elseif isunix 
    addpath(genpath('casadi-3.6.7-linux64-matlab2018b'))
else
    disp('Platform not supported')
end