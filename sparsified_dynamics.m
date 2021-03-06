function [XS,YS,AS] = sparsified_dynamics(X,Y,K,tend,dim,epsilon)

%% Setup sparsification

%global rho;
n = length(X);

% Define adjacency matrix
if dim == 2
    A = sqrt(abs(K.*K.'))./abs((X-X.')+1i*(Y-Y.'));
    %A = .5*(abs(K)+abs(K.'))./sqrt(l2); % Alternative adjacency matrix
elseif dim ==3
    thet = X; phi = Y;
    l2 = 2*(1 - cos(thet)*cos(thet') - sin(thet).*sin(thet.').*cos(phi - phi.')); % Square of chord distance between vortices
    A = sqrt(abs(K.*K.'))./sqrt(l2); 
    %A = (abs(K)+abs(K.'))./sqrt(l2); 
end
A(logical(eye(n))) = 0; % Remove diagonal entries of adjacency matrix

% Spectral sparsification of adjacency matrix
tic
[AS,~]  = sparsify_spectral(A,epsilon);
disp(['The sparsification took ', num2str(toc)])

% Define sparsification ratio
W = sparse(AS./A); 

% Plot adjacency matrix and sparsified matrix
subplot(1,2,1);
cmax = max(max(A));
imagesc(A,'AlphaData',A~=0)
title('Full adjacency matrix')
caxis([0,cmax])
subplot(1,2,2);
imagesc(AS,'AlphaData',AS~=0);
title('Sparsified adjacency matrix')
caxis([0,cmax])
colormap jet
drawnow

%% Run sparsified-dynamics model
if dim == 2
biotfun = @(t,z) biot_savart_2d(z,K,W);
elseif dim ==3
biotfun = @(t,z) biot_savart_3d(z,K,W);
end

tic
sol = ode45(biotfun,[0,tend],[X;Y]);
disp(['The sparsified dynamics took ' num2str(toc)])

Z_new = deval(sol,linspace(0,tend,1e3));
XS = Z_new(1:n,:);
YS = Z_new(n+1:end,:);
