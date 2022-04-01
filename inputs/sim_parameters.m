clear;clc;

addpath ../kernel
addpath ../kernel/libraries
addpath ../kernel/dynamics
addpath ../kernel/sensors
addpath ../kernel/navigation

buses = Simulink.data.dictionary.open('bus_definition.sldd');

tsim = 10;
config.CoM_alignment = [0, 0, 0];
config.Larm = 0.065;
config.geometry = 0;
config.euler0 = deg2rad([0;0;0]);

save('config.mat','config','-v7.3');
freq = 200;
Ts = 1/freq;

imu1.gyro.bias = ([6.1, 9.22, 2.89]*1e-5)*180/pi; %deg/s
imu1.gyro.noisepower = [0.01, 0.01, 0.01].^2; %(deg/s)^2/Hz
imu1.alignment = [0; 0; 0];
imu1.gyro.fullrange = 2000;
imu1.gyro.quantization = 2*imu1.gyro.fullrange/2^16;
imu1.gyro.std = sqrt(imu1.gyro.noisepower*freq);
imu1.acc.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz
imu1.acc.fullrange = 16*9.8; %m/s^2
imu1.acc.quantization = 2*imu1.acc.fullrange/2^16;
imu1.acc.std = sqrt(imu1.acc.noisepower*freq);
imu1.mag.fullrange = 4800; %microT
imu1.mag.quantization = 2*imu1.mag.fullrange/2^14;
imu1.mag.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz
imu1.mag.std = sqrt(imu1.mag.noisepower*freq);

imu2.gyro.bias = (([6.1, 9.22, 2.89]*1e-5)*180/pi).^2/(2*pi); %(deg/s)^2
imu2.gyro.noisepower = [0.01, 0.01, 0.01].^2; %(deg/s)^2/Hz
imu2.alignment = [0; 0; 0];
imu2.gyro.fullrange = 2000;
imu2.gyro.quantization = 2*imu2.gyro.fullrange/2^16;
imu2.acc.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz
imu2.acc.fullrange = 16*9.8; %m/s^2
imu2.acc.quantization = 2*imu2.acc.fullrange/2^16;
imu2.mag.fullrange = 4800; %microT
imu2.mag.quantization = 2*imu2.mag.fullrange/2^14;
imu2.mag.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz

imu3.gyro.bias = (([6.1, 9.22, 2.89]*1e-5)*180/pi).^2/(2*pi); %(deg/s)^2
imu3.gyro.noisepower = [0.01, 0.01, 0.01].^2; %(deg/s)^2/Hz
imu3.alignment = [0; 0; 0];
imu3.gyro.fullrange = 2000;
imu3.gyro.quantization = 2*imu3.gyro.fullrange/2^16;
imu3.acc.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz
imu3.acc.fullrange = 16*9.8; %m/s^2
imu3.acc.quantization = 2*imu3.acc.fullrange/2^16;
imu3.mag.fullrange = 4800; %microT
imu3.mag.quantization = 2*imu3.mag.fullrange/2^14;
imu3.mag.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz

imu4.gyro.bias = (([6.1, 9.22, 2.89]*1e-5)*180/pi).^2/(2*pi); %(deg/s)^2
imu4.gyro.noisepower = [0.01, 0.01, 0.01].^2; %(deg/s)^2/Hz
imu4.alignment = [0; 0; 0];
imu4.gyro.fullrange = 2000;
imu4.gyro.quantization = 2*imu4.gyro.fullrange/2^16;
imu4.acc.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz
imu4.acc.fullrange = 16*9.8; %m/s^2
imu4.acc.quantization = 2*imu4.acc.fullrange/2^16;
imu4.mag.fullrange = 4800; %microT
imu4.mag.quantization = 2*imu4.mag.fullrange/2^14;
imu4.mag.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz

%Kalman initialization

% gyro_bias_init = [sqrt(biasAng);sqrt(biasAng);sqrt(biasAng) ]*100;

% set_param(gcs,'EnableLBRepository','on');