%% A. G. Nair & K. Taira, ?Network-theoretic approach to sparsified 
%% discrete vortex dynamics, J. Fluid Mech. 768, 549-571, 2015
%% Vortical graph sparsification
                  
nvc = 5; % Number of vortices per cluster
nc = 3; % Number of clusters
spread = .1; % Spread of vortices around cluster center
dim = 2; % Set dimension of problem, 2 for plane or 3 for sphere
%% Initial Setup 
figure(1);
[X,Y,K]  = vortex_setup(nc,nvc,spread,dim); % Set up cluster centers, vortex positions, and strengths
tend = 5; % Final time

%% Run sparsified dynamics
epsilon = 1;
figure(2)
[XS,YS,AS] = sparsified_dynamics(X,Y,K,tend,dim,epsilon);

%% Run full dynamics
tic
[XF,YF] = original_dynamics(X,Y,K,tend,dim);
disp(['The full dynamics took ' num2str(toc)]);

%% Plotting
figure(3)
dynamics_plot(XF,YF,XS,YS,nvc,nc,dim);