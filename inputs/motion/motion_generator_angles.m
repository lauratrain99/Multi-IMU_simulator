clear;clc;

tsim = 100;
fs = 200; 
t = 0:(1/fs):tsim;

roll = deg2rad(20)*cos(pi/2*t );
pitch = 0*t;
yaw = 0*t;

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
