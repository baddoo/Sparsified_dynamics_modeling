function [X_org,Y_org] = original_dynamics(X,Y,K,dt,nt)

%% Inputs
% X : initial x-cordinate of point vortices
% Y : initial x-cordinate of point vortices
% K : strength of point vortices
% dt : time step
% nt : number of time steps

%% Outputs
% X_org, Y_org: trajectories of vortices


%% Run biot-savart model
n = length(X);
W = ones(n);
biotfun = @(t,z) biot_savart(z,K,W);
sol = ode45(biotfun,[0,nt*dt],[X;Y]);
Z_new = deval(sol,0:dt:dt*nt);
X_org = Z_new(1:n,:);
Y_org = Z_new(n+1:end,:);
