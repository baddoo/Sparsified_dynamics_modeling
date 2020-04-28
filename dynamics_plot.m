%

function dynamics_plot(X_org,Y_org,X_sparse,Y_sparse,nvc,nc,dim)

LW = 'LineWidth'; CL = 'Color'; MFC = 'MarkerFaceColor';
cmap = hsv(nc); % Define colormap

if dim == 2 % 2D plot
   
for j = 1:nc
    % Plot original dynamics
x11 = mean(X_sparse((j-1)*nvc+1:j*nvc,:),1); y11 = mean(Y_sparse((j-1)*nvc+1:j*nvc,:),1);
x11o= mean(X_org((j-1)*nvc+1:j*nvc,:),1);y11o = mean(Y_org((j-1)*nvc+1:j*nvc,:),1);
    % Plot sparsified dynamics
plot(x11,y11,'-',x11o,y11o,'--',CL,[cmap(j,:)],LW,3);
hold on
plot(x11(1),y11(1),'o',MFC,[cmap(j,:)],...
    'MarkerEdgeColor',[cmap(j,:)]);
end
hold off;
ax = gca;
axis([ax.XLim(1)-1,ax.XLim(2)+1,ax.YLim(1)-1,ax.YLim(2)+1]);
axis equal;    
elseif dim ==3 % 3D plot:


[x, y, z] = sphere(128);
surfl(x, y, z,'light'); 
colormap gray
%set(h, 'FaceAlpha', 0.5)
shading interp
caxis([-2,0])
hold on
for j = 1:nc
    
% Trajectories of vortices    
thetV = X_org((j-1)*nvc+1:j*nvc,:); phiV = Y_org((j-1)*nvc+1:j*nvc,:);

% Mean of sparsified trajectories
thetS = mean(X_sparse((j-1)*nvc+1:j*nvc,:),1); phiS = mean(Y_sparse((j-1)*nvc+1:j*nvc,:),1);

% Mean of full trajectories
thetF = mean(X_org((j-1)*nvc+1:j*nvc,:),1); phiF = mean(Y_org((j-1)*nvc+1:j*nvc,:),1);

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

% Plot 
plot3(xS,yS,zS,'-',CL,cmap(j,:),LW,3);
plot3(xF,yF,zF,'--',CL,cmap(j,:),LW,3);

plot3(x(1),yF(1),zF(1),'o',CL,cmap(j,:),MFC,cmap(j,:),LW,3);
end

hold off
axis equal
axis off
lighting gouraud
axis vis3d
end

end