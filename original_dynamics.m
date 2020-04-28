function [X_org,Y_org] = original_dynamics(X,Y,K,tend,dim)

%% Inputs
% X : initial x-cordinate of point vortices
% Y : initial x-cordinate of point vortices
% K : strength of point vortices
% dt : time step
% nt : number of time steps

%% Outputs
% X_org, Y_org: trajectories of vortices


%% Run full Biot–Savart model
n = length(X);
W = ones(n);

if dim == 2
biotfun = @(t,z) biot_savart_2d(z,K,W);
elseif dim ==3
biotfun = @(t,z) biot_savart_3d(z,K,W);
end

sol = ode45(biotfun,[0,tend],[X;Y]);

Z_new = deval(sol,linspace(0,tend,1e3));
X_org = Z_new(1:n,:);
Y_org = Z_new(n+1:end,:);
