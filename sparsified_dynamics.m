function [X_sparse,Y_sparse,A_sparse] = sparsified_dynamics(X,Y,K,epsilon,dt,nt)

%% Inputs
% X : initial x-cordinate of point vortices
% Y : initial x-cordinate of point vortices
% K : strength of point vortices
% epsilon: sparsification order
% dt : time step
% nt : number of time steps

%% Outputs
% X_sparse, Y_sparse: sparse trajectories of vortices
% A_sparse : sparse adjacency matrix

%% Setup sparsification

%global rho;
n             = length(X);
%z0            = [X;Y;K];              % Array of co-ordinates/strengths
%A             = adj_matrix(n,K,X,Y);% Set adjacency matrix
A = sqrt(K.*K.')./abs((X-X.')+1i*(Y-Y.')); % Define adjacency matrix
A(logical(eye(n))) = 0; % Remove diagonal entries of adjacency matrix
[A_sparse,~]  = sparsify_spectral(A,epsilon); % spectral sparsification
W           = A_sparse./A;                  % sparsification ratio

%% Run sparsified-dynamics model

biotfun = @(t,z) biot_savart(z,K,W);
sol = ode45(biotfun,[0,nt*dt],[X;Y]);
Z_new = deval(sol,0:dt:dt*nt);
X_sparse = Z_new(1:n,:);
Y_sparse = Z_new(n+1:end,:);

function A = adj_matrix(N,K,x,y)
%% Adjacency Matrix - Aditya Nair, Kunihiko Taira
%Input: %N :Number of point vortices
%K      :Strength of vortices
%x,y    : Cordinates of vortices
%Output :%A :Adjacency Matrix
A = zeros(N,N);
for i = 1:N
    for j = 1:N
        if i~=j
            r  = sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2);  
            A(i,j) = 0.5*(abs(K(i))+abs(K(j)))*(1/r);
        else
            A(i,j) = 0;
        end
    end
end