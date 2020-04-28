%% A. G. Nair & K. Taira, ?Network-theoretic approach to sparsified 
%% discrete vortex dynamics, J. Fluid Mech. 768, 549-571, 2015
%% Vortical graph sparsification
                  
nvc = 10; % Number of vortices per cluster
nc = 5; % Number of clusters
spread = .1; % Spread of vortices around cluster center
dim = 2; % Set dimension of problem, 2 for plane or 3 for sphere
%% Initial Setup 
figure(1);
[X,Y,K]  = vortex_setup(nc,nvc,spread,dim); % Set up cluster centers, vortex positions, and strengths
drawnow;
tend = 5; % Final time
profile on
%% Run full dynamics
tic
[X_org,Y_org] = original_dynamics(X,Y,K,tend,dim);
disp(['Full dynamics took ' num2str(toc)]);
%% Run sparsified dynamics
epsilon = .5;
figure(2)
[X_sparse,Y_sparse, A_sparse] = sparsified_dynamics(X,Y,K,tend,dim,epsilon);
profile off
%% Plotting
figure(3)
dynamics_plot(X_org,Y_org,X_sparse,Y_sparse,nvc,nc,dim);