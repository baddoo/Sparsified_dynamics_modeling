function [X,Y,K] = vortex_setup(nc,nvc,spread,dim)

MFC = 'MarkerFaceColor';

if dim ==2

%% Set up point vortices in clusters

% Generate centers of clusters
lp = -5;up = 5; nrange = 100;
Xcent = randi([lp*nrange up*nrange],1,nc)/nrange;
Ycent = randi([lp*nrange up*nrange],1,nc)/nrange;

% Generate vortices around centers
Xvorts = Xcent+spread*randn(nvc,nc);
Yvorts = Ycent+spread*randn(nvc,nc);
    
% Reshape vortex positions into a long vector 
X = reshape(Xvorts,nc*nvc,[]);
Y = reshape(Yvorts,nc*nvc,[]);

% Define vortex strengths
K = 0.1 + 0.01*randn(size(X)); % setup vortex strengths

% Plot vortices in red with size according to their strength
scatter(X,Y,5*abs(log(K)),'ro',MFC,'r')
hold on

% Plot cluster centers in green
plot(Xcent,Ycent,'ko',MFC,'g');

% Modify axis limits
ax = gca;
axis([ax.XLim(1)-1,ax.XLim(2)+1,ax.YLim(1)-1,ax.YLim(2)+1]);

axis equal;
hold off

elseif dim==3

% Randomly distribute cluster centers on the sphere    
Xcent = asin(-1+2*rand(1,nc));
Ycent = 2*pi*rand(1,nc);    
        
% Should change this so that the points are randomly
% distributed in a circle around the center, on the sphere.
Xvorts = Xcent + asin(spread*(-1+2*rand(nvc,nc)));
Yvorts = Ycent + spread*pi/2*(1-2*rand(nvc,nc));

% Generate circulations
K = randfixedsum(nvc*nc,1,0,-.05,.05); % On the sphere the circulations must sum to zero

% Reshape vortex positions into a long vector 
X = reshape(Xvorts,nc*nvc,[]);
Y = reshape(Yvorts,nc*nvc,[]);

% Plot initial configuration on the sphere
[x, y, z] = sphere(128); % Define sphere coordinates
surfl(x, y, z,'light');  % Plot sphere
hold on
colormap gray
shading interp
caxis([-2,0])

% Factor to make objects appear on surface of sphere
fac = 1.01;

% Convert from spherical polars to Cartesian coordinates
[xc,yc,zc] = sph2cart(Ycent,Xcent,fac); % Cluster centers
[xv,yv,zv] = sph2cart(Yvorts,Xvorts,fac); % Vortex positions

% Plot cluster centers
plot3(xc,yc,zc,'ko',MFC,'g')
p = (K>0);
% Plot vortices with positive circulation in red
scatter3(xv(p),yv(p),zv(p),5*abs(log(K(p))),'ro',MFC,'r')
% Plot vortices with negative circulation in blue
scatter3(xv(~p),yv(~p),zv(~p),5*abs(log(-K(~p))),'bo',MFC,'b')

hold off
axis equal
axis off
lighting gouraud

axis vis3d


end

drawnow;

end
