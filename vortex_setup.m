function [X,Y] = vortex_setup(nc,nvc)

%% Set up point vortices in clusters
Nclust = nc; % number of vortex clusters
lp = -5;up = 5; Nc = nvc; nrange = 100;

% Generate centers of clusters
Xcent = randi([lp*nrange up*nrange],Nclust,1)/nrange;
Ycent = randi([lp*nrange up*nrange],Nclust,1)/nrange;
Xvorts = zeros(Nc,Nclust); Yvorts = zeros(Nc,Nclust);

% Generate vortices around centers
for i = 1:Nclust
    Xvorts(:,i)=Xcent(i)+0.2*randn(Nc,1);
    Yvorts(:,i)=Ycent(i)+0.2*randn(Nc,1);
end

% Reshape vortex positions into a long vector 
X = reshape(Xvorts,Nclust*Nc,[]);
Y = reshape(Yvorts,Nclust*Nc,[]);

% Plot vortex centers
plot(Xcent,Ycent,'ko','MarkerFaceColor','r');hold on;
plot(X,Y,'b.');
axis equal;
hold off