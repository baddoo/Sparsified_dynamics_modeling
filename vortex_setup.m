function [X,Y] = vortex_setup(nc,nvc,spread)

%% Set up point vortices in clusters
lp = -5;up = 5; nrange = 100;

% Generate centers of clusters
Xcent = randi([lp*nrange up*nrange],nc,1)/nrange;
Ycent = randi([lp*nrange up*nrange],nc,1)/nrange;
Xvorts = zeros(nvc,nc); Yvorts = zeros(nvc,nc);

Xcent = sin(-1+2*rand(1,nc));
Ycent = 2*pi*rand(1,nc);

% Generate vortices around centers
    %Xvorts(:,i)=Xcent(i)+spread*randn(nvc,1);
    %Yvorts(:,i)=Ycent(i)+spread*randn(nvc,1);
    
% Should change this so that the points are randomly
% distributed in a circle around the center, on the sphere.
Xvorts=Xcent+asin(spread*(-1+2*rand(nvc,nc)));
Yvorts=Ycent+spread*pi/2*(1-2*rand(nvc,nc));

% Reshape vortex positions into a long vector 
X = reshape(Xvorts,nc*nvc,[]);
Y = reshape(Yvorts,nc*nvc,[]);

% Plot vortex centers
% plot(Xcent,Ycent,'ko','MarkerFaceColor','r');hold on;
% plot(X,Y,'b.');
% axis equal;
% hold off

[x y z] = sphere(128);
h = surfl(x, y, z,'light'); 
hold on
colormap gray
shading interp
fac = 1.01;
[x1,y1,z1] = sph2cart(Ycent,Xcent,fac);
[xv,yv,zv] = sph2cart(Yvorts,Xvorts,fac);


plot3(x1,y1,z1,'ko','MarkerFaceColor','r')
plot3(xv,yv,zv,'b.')
hold off
axis equal
axis off
lighting gouraud

axis vis3d


