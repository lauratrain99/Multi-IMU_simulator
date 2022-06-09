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
config.geometry = 1;
config.euler0 = deg2rad([20,0,0]);

save('config.mat','config','-v7.3');
freq = 200;
Ts = 1/freq;

% Sensor specifications
imu1.gyro.bias = ([6.1, 9.22, 2.89]*1e-5)*180/pi; %deg/s
imu1.gyro.std = [0.0019, 0.0018, 0.0017]; %rad/s
imu1.gyro.noisepower = (imu1.gyro.std*180/pi).^2/freq;
% sqrt(imu1.gyro.noisepower*freq)*pi/180; %rad/s
% imu1.gyro.noisepower = [0.01, 0.01, 0.01].^2; %(deg/s)^2/Hz
imu1.alignment = [0; 0; 0];
imu1.gyro.fullrange = 2000; 
imu1.gyro.quantization = 2*imu1.gyro.fullrange/2^16;
imu1.acc.std = [0.0222, 0.0205, 0.0334];
imu1.acc.noisepower = imu1.acc.std.^2/freq;
% imu1.acc.std = sqrt(imu1.acc.noisepower*freq);
% imu1.acc.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz
imu1.acc.fullrange = 16*9.8; %g
imu1.acc.quantization = 2*imu1.acc.fullrange/2^16;
imu1.mag.fullrange = 4800; %microT
imu1.mag.quantization = 2*imu1.mag.fullrange/2^14;
imu1.mag.noisepower = ([50, 50, 50]*1e-3).^2; %(microT)^2/Hz
imu1.mag.std = sqrt(imu1.mag.noisepower*freq);

imu2.gyro.bias = (([8.74, 7.88, 4.43]*1e-5)*180/pi); %(deg/s)^2
imu2.gyro.std = [0.0019, 0.0018, 0.002]; %rad/s
imu2.gyro.noisepower = (imu2.gyro.std*180/pi).^2/freq;
% sqrt(imu2.gyro.noisepower*freq)*pi/180; %rad/s
% imu2.gyro.noisepower = [0.01, 0.01, 0.01].^2; %(deg/s)^2/Hz
imu2.alignment = [0; 0; 0];
imu2.gyro.fullrange = 2000; 
imu2.gyro.quantization = 2*imu2.gyro.fullrange/2^16;
imu2.acc.std = [0.0207, 0.0206, 0.0327];
imu2.acc.noisepower = imu2.acc.std.^2/freq;
% imu2.acc.std = sqrt(imu2.acc.noisepower*freq);
% imu2.acc.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz
imu2.acc.fullrange = 16*9.8; %g
imu2.acc.quantization = 2*imu2.acc.fullrange/2^16;
imu2.mag.fullrange = 4800; %microT
imu2.mag.quantization = 2*imu2.mag.fullrange/2^14;
imu2.mag.noisepower = ([50, 50, 50]*1e-3).^2; %(microT)^2/Hz
imu2.mag.std = sqrt(imu2.mag.noisepower*freq);

imu3.gyro.bias = (([9.99, 5.57, 2.22]*1e-5)*180/pi); %(deg/s)^2
imu3.gyro.std = [0.0017, 0.0018, 0.0017]; %rad/s
imu3.gyro.noisepower = (imu3.gyro.std*180/pi).^2/freq;
% sqrt(imu3.gyro.noisepower*freq)*pi/180; %rad/s
% imu3.gyro.noisepower = [0.01, 0.01, 0.01].^2; %(deg/s)^2/Hz
imu3.alignment = [0; 0; 0];
imu3.gyro.fullrange = 2000; 
imu3.gyro.quantization = 2*imu3.gyro.fullrange/2^16;
imu3.acc.std = [0.0203, 0.0207, 0.0333];
imu3.acc.noisepower = imu3.acc.std.^2/freq;
% imu3.acc.std = sqrt(imu2.acc.noisepower*freq);
% imu3.acc.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz
imu3.acc.fullrange = 16*9.8; %g
imu3.acc.quantization = 2*imu3.acc.fullrange/2^16;
imu3.mag.fullrange = 4800; %microT
imu3.mag.quantization = 2*imu3.mag.fullrange/2^14;
imu3.mag.noisepower = ([50, 50, 50]*1e-3).^2; %(microT)^2/Hz
imu3.mag.std = sqrt(imu3.mag.noisepower*freq);

imu4.gyro.bias = (([5.29, 8.49, 4.56]*1e-5)*180/pi); %(deg/s)^2
imu4.gyro.std = [0.0017, 0.0018, 0.0016]; %rad/s
imu4.gyro.noisepower = (imu4.gyro.std*180/pi).^2/freq;
% sqrt(imu4.gyro.noisepower*freq)*pi/180; %rad/s
% imu4.gyro.noisepower = [0.01, 0.01, 0.01].^2; %(deg/s)^2/Hz
imu4.alignment = [0; 0; 0];
imu4.gyro.fullrange = 2000; 
imu4.gyro.quantization = 2*imu4.gyro.fullrange/2^16;
imu4.acc.std = [0.0208, 0.0207, 0.0353];
imu4.acc.noisepower = imu4.acc.std.^2/freq;
% imu4.acc.std = sqrt(imu2.acc.noisepower*freq);
% imu4.acc.noisepower = ([300, 300, 300]*1e-6*9.8).^2; %(m/s^2)^2/Hz
imu4.acc.fullrange = 16*9.8; %g
imu4.acc.quantization = 2*imu4.acc.fullrange/2^16;
imu4.mag.fullrange = 4800; %microT
imu4.mag.quantization = 2*imu4.mag.fullrange/2^14;
imu4.mag.noisepower = ([50, 50, 50]*1e-3).^2; %(microT)^2/Hz
imu4.mag.std = sqrt(imu4.mag.noisepower*freq);


% set_param(gcs,'EnableLBRepository','on');