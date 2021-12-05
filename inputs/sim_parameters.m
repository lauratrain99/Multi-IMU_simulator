
clear;clc;

addpath ../kernel
addpath ../kernel/libraries

buses = Simulink.data.dictionary.open('bus_definition.sldd');

tsim = 10;
config.CoM_alignment = [0, 0, 0];
config.Larm = 0.065;
config.geometry = 1;
config.imu1_alignment = [0; 0; 0];
config.imu2_alignment = [0; 0; 0];
config.imu3_alignment = [0; 0; 0];
config.imu3_alignment = [0; 0; 0];

save('config.mat','config','-v7.3');

set_param(gcs,'EnableLBRepository','on');
