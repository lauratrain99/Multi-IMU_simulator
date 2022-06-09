clear;clc;

tsim = 100;
fs = 200; 
t = 0:(1/fs):tsim;

mov = 1;

test = csvread('gyrotable2.csv');

switch mov
    case 1
        roll = deg2rad(20)*cos(pi/2.3*t);
        pitch = deg2rad(2.3)*cos(pi/2.3*t);
        yaw = deg2rad(0.25)*cos(pi/1.15*t) + deg2rad(3);
    case 2
        roll = -deg2rad(2.3)*cos(pi/2.3*t);
        pitch = deg2rad(20)*cos(pi/2.3*t);
        yaw = -deg2rad(0.5)*cos(pi/1.15*t) + deg2rad(5);
    case 3
        roll = -deg2rad(0.1)*cos(pi/2.3*t);
        pitch = deg2rad(0.1)*cos(pi/1.15*t);
        yaw = deg2rad(20)*cos(pi/2.3*t);
    case 4
        roll = deg2rad(20)*cos(pi/2.3*t );
        pitch = deg2rad(6)*cos(pi/2.3*t - 2.3/2);
        yaw = deg2rad(5)*cos(pi/2.3*t) + deg2rad(15);
    case 5 
        roll = deg2rad(20)*cos(pi/2.3*t );
        pitch = deg2rad(6)*cos(pi/2.3*t - 2.3/2);
        yaw = deg2rad(5)*cos(pi/2.3*t) + deg2rad(15);
    otherwise
        disp('Select a number from 1 to 5')
end

wx(1) = 0;
wy(1) = 0;
wz(1) = 0;
dt = diff(t);

for i = 2:length(t)
    wx(i) = (roll(i) - roll(i-1))/dt(i-1);
    wy(i) = (pitch(i) - pitch(i-1))/dt(i-1);
    wz(i) = (yaw(i) - yaw(i-1))/dt(i-1);
end


simulation.omega_V = timeseries([wx', wy', wz'],t);


save('../simulation.mat','simulation','-v7.3');
