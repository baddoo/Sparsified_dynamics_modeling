%% A. G. Nair & K. Taira, ?Network-theoretic approach to sparsified 
%% discrete vortex dynamics, J. Fluid Mech. 768, 549-571, 2015
%% Vortical graph sparsification
                  
nvc = 10; % Number of vortices per cluster
nc = 5; % Number of clusters
%% Initial Setup 
figure(1);
[X,Y]  = vortex_setup(nc,nvc); % setup vortex clusters (positions)
drawnow
K      = 0.1 + 0.01*randn(size(X)); % setup vortex strengths
dt     = 0.01;                 % time step 
nt     = 500;                 % number of time stamps

%% Run original dynamics
tic
[X_org,Y_org] = original_dynamics(X,Y,K,dt,nt);
disp(['Full dynamics took ' num2str(toc)]);
%% Run sparficied dynamics
epsilon = 1;
tic
[X_sparse,Y_sparse, A_sparse] = sparsified_dynamics(X,Y,K,epsilon,dt,nt);
disp(['Sparsified dynamics took ' num2str(toc)])
%% Plotting
figure(2)
dynamics_plot(X,Y,X_org,Y_org,X_sparse,Y_sparse,nt,nvc,nc);