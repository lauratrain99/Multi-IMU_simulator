clear;clc;

load ('traj.mat')
tsim = 100;
fs = 200; 
% t = 0:(1/fs):tsim;
t = traj.time;

roll = deg2rad(traj.roll)';
pitch = deg2rad(traj.pitch)';
yaw = deg2rad(traj.yaw)';

% roll = -pi/900*cos(pi/2.3*t);
% pitch = pi/9*cos(pi/1.15*t);
% yaw = pi/900*cos(pi/2.3*t);

wx(1) = 0;
wy(1) = 0;
wz(1) = 0;
dt = diff(t);

for i = 2:length(t)
    roll_rate(i) = (roll(i) - roll(i-1))/dt(i-1);
    pitch_rate(i) = (pitch(i) - pitch(i-1))/dt(i-1);
    yaw_rate(i) = (yaw(i) - yaw(i-1))/dt(i-1);
    
    wx(i) = -sin(pitch(i))*yaw_rate(i) + roll_rate(i);
    wy(i) = sin(roll(i))*cos(pitch(i))*yaw_rate(i) + cos(roll(i))*pitch_rate(i);
    wz(i) = cos(roll(i))*cos(pitch(i))*yaw_rate(i) - sin(roll(i))*pitch_rate(i);
end
wx(1) = wx(2);
wy(1) = wy(2);
wz(1) = wz(2);
simulation.euler = timeseries([roll', pitch', yaw'],t);
simulation.omega_V = timeseries([wx', wy', wz'],t);

save('../simulation.mat','simulation','-v7.3');
