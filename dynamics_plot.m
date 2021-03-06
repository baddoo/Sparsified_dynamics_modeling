%

function dynamics_plot(XF,YF,XS,YS,nvc,nc,dim)

LW = 'LineWidth'; CL = 'Color'; MFC = 'MarkerFaceColor';
cmap = hsv(nc); % Define colormap

if dim == 2 % 2D plot
   
for j = 1:nc
    
% Mean of sparsified dynamics    
x11 = mean(XS((j-1)*nvc+1:j*nvc,:),1); y11 = mean(YS((j-1)*nvc+1:j*nvc,:),1);
% Mean of full dynamics
x11o= mean(XF((j-1)*nvc+1:j*nvc,:),1);y11o = mean(YF((j-1)*nvc+1:j*nvc,:),1);

plot(x11,y11,'-',x11o,y11o,'--',CL,[cmap(j,:)],LW,3);
hold on
plot(x11(1),y11(1),'o',MFC,[cmap(j,:)],...
    'MarkerEdgeColor',[cmap(j,:)]);

% Plot vortex trajectories
for l = 1:nvc % Need to vectorise to make lines transparent
pv = plot(XF((j-1)*nvc+l,:),YF((j-1)*nvc+l,:),'k',LW,.5);
hold on
pv.Color(4)=0.1;
end

plot(x11,y11,'-',x11o,y11o,'--',CL,[cmap(j,:)],LW,3);
plot(x11(1),y11(1),'o',MFC,[cmap(j,:)],...
    'MarkerEdgeColor',[cmap(j,:)]);

end
hold off;

% Expand axis limits
ax = gca;
axis([ax.XLim(1)-1,ax.XLim(2)+1,ax.YLim(1)-1,ax.YLim(2)+1]);
axis equal;    

elseif dim ==3 % 3D plot:
    
% Plot sphere    
[x, y, z] = sphere(128);
surfl(x, y, z,'light'); 
colormap gray
%set(h, 'FaceAlpha', 0.5)
shading interp
caxis([-2,0])
hold on

for j = 1:nc
    
% Trajectories of vortices    
thetV = XF((j-1)*nvc+1:j*nvc,:); phiV = YF((j-1)*nvc+1:j*nvc,:);

% Mean of sparsified trajectories
thetS = mean(XS((j-1)*nvc+1:j*nvc,:),1); phiS = mean(YS((j-1)*nvc+1:j*nvc,:),1);

% Mean of full trajectories
thetF = mean(XF((j-1)*nvc+1:j*nvc,:),1); phiF = mean(YF((j-1)*nvc+1:j*nvc,:),1);

% Factor to make objects appear on surface of sphere
fac = 1.01;

% Convert from spherical polars to Cartesian coordinates
[xS,yS,zS] = sph2cart(phiS,thetS,fac); % Mean sparsified
[xF,yF,zF] = sph2cart(phiF,thetF,fac); % Mean full
[xV,yV,zV] = sph2cart(phiV,thetV,fac); % Full vortex trajectories

% Plot vortex trajectories
for l = 1:nvc % Need to vectorise to make lines transparent
pv = plot3(xV(l,:),yV(l,:),zV(l,:),'k',LW,.5);
pv.Color(4)=0.2;
end

% Plot mean of sparsified dynamics
plot3(xS,yS,zS,'-',CL,cmap(j,:),LW,3);

% Plot mean of full dynamics
plot3(xF,yF,zF,'--',CL,cmap(j,:),LW,3);

% Plot initial location of mean
plot3(xF(1),yF(1),zF(1),'o',CL,cmap(j,:),MFC,cmap(j,:),LW,3);
end

hold off
axis equal
axis off
lighting gouraud
axis vis3d
end

end