function [X,Y,K] = vortex_setup(nc,nvc,spread,dim)

MFC = 'MarkerFaceColor';

if dim ==2

%% Set up point vortices in clusters
lp = -5;up = 5; nrange = 100;
% Generate centers of clusters
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

%Plot vortex centers
plot(Xcent,Ycent,'ko',MFC,'r');hold on;
plot(X,Y,'b.');
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
K = randfixedsum(nvc*nc,1,0,-.1,.1); % On the sphere the circulations must sum to zero

% Reshape vortex positions into a long vector 
X = reshape(Xvorts,nc*nvc,[]);
Y = reshape(Yvorts,nc*nvc,[]);

% Plot initial configuration on the sphere

[x, y, z] = sphere(128);
h = surfl(x, y, z,'light'); 
hold on
colormap gray
shading interp
fac = 1.01;
[x1,y1,z1] = sph2cart(Ycent,Xcent,fac);
[xv,yv,zv] = sph2cart(Yvorts,Xvorts,fac);


plot3(x1,y1,z1,'ko',MFC,'g')
p = (K>0);
scatter3(xv(p),yv(p),zv(p),5*abs(log(K(p))),'ro',MFC,'r')
scatter3(xv(~p),yv(~p),zv(~p),5*abs(log(-K(~p))),'bo',MFC,'b')

hold off
axis equal
axis off
lighting gouraud

axis vis3d

end

end
