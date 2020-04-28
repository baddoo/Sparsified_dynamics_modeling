%% A. G. Nair & K. Taira, ?Network-theoretic approach to sparsified 
%% discrete vortex dynamics, J. Fluid Mech. 768, 549-571, 2015
%% Vortical graph sparsification
                  
nvc = 20; % Number of vortices per cluster
nc = 3; % Number of clusters
spread = .1; % Spread of vortices around cluster center
%% Initial Setup 
figure(1);
[X,Y]  = vortex_setup(nc,nvc,spread); % setup vortex clusters (positions)
drawnow
K      = 0.5 + 0.00*randn(size(X)); % setup vortex strengths
dt     = 0.005;                 % time step 
nt     = 50;                 % number of time stamps

%% Run full dynamics
tic
[X_org,Y_org] = original_dynamics(X,Y,K,dt,nt);
disp(['Full dynamics took ' num2str(toc)]);
%% Run sparsified dynamics
epsilon = 1;
figure(2)
[X_sparse,Y_sparse, A_sparse] = sparsified_dynamics(X,Y,K,epsilon,dt,nt);
%% Plotting
figure(3)
dynamics_plot(X,Y,X_org,Y_org,X_sparse,Y_sparse,nt,nvc,nc);