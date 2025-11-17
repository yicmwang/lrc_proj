clear
% close all hidden

addpath(genpath('spatial_v2_extended'))
% addpath(genpath('robot_zoo'))
% addpath(genpath('examples'))
% addpath(genpath('utils'))
if ismac
    addpath(genpath('casadi-3.7.2-osx_arm64-matlab2018b'))
elseif ispc
    addpath(genpath('casadi-3.7.2-windows64-matlab2018b'))
elseif isunix 
    addpath(genpath('casadi-3.7.2-linux64-matlab2018b'))
else
    disp('Platform not supported')
end