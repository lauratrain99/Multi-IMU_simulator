clear;clc;

tsim = 10;
fs = 200; 
t = 0:(1/fs):tsim;
w = 2*pi * 2 / 10;

motion = "constantY";
 
if motion == "constantZ"
    simulation.omega_V = timeseries([zeros(length(t), 1), zeros(length(t), 1), w*ones(length(t),1)],t);
elseif motion == "constantX"
    simulation.omega_V = timeseries([w*ones(length(t),1), zeros(length(t), 1), zeros(length(t), 1)],t);
elseif motion == "constantY"
    simulation.omega_V = timeseries([zeros(length(t), 1), w*ones(length(t),1), zeros(length(t), 1)],t);
end

save('../simulation.mat','simulation','-v7.3');
