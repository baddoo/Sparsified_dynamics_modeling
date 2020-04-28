%

function dynamics_plot(X,Y,X_org,Y_org,X_sparse,Y_sparse,nt,nvc,nc)

LW = 'LineWidth'; CL = 'Color'; MFC = 'MarkerFaceColor';
cmap = hsv(nc); % Define colormap
Xm = 0;%mean(X);
Ym = 0;%mean(Y); % Rescaling factor
r_macro = 1;mean(sqrt((X-Xm).^2+(Y-Ym).^2));
X_org = [X X_org(:,1:nt)];X_org = (X_org-Xm)/r_macro;
Y_org = [Y Y_org(:,1:nt)];Y_org = (Y_org-Ym)/r_macro;
%X_sparse = [X X_sparse(:,1:nt)];X_sparse = (X_sparse - Xm)/r_macro;
%Y_sparse = [Y Y_sparse(:,1:nt)];Y_sparse = (Y_sparse - Ym)/r_macro;

% for j = 1:nc
%     % Plot original dynamics
% x11 = mean(X_sparse((j-1)*nvc+1:j*nvc,:),1); y11 = mean(Y_sparse((j-1)*nvc+1:j*nvc,:),1);
% x11o= mean(X_org((j-1)*nvc+1:j*nvc,:),1);y11o = mean(Y_org((j-1)*nvc+1:j*nvc,:),1);
%     % Plot sparsified dynamics
% plot(x11,y11,'-',x11o,y11o,'--',CL,[cmap(j,:)],LW,3);
% hold on
% plot(x11(1),y11(1),'o',MFC,[cmap(j,:)],...
%     'MarkerEdgeColor',[cmap(j,:)]);
% end
% hold off;axis square;
% xlim([-2 2]);ylim([-2 2]);box on;

% 3D plot:

[x y z] = sphere(128);
h = surfl(x, y, z,'light'); 
%caxis([-2,-1])
colormap gray
%set(h, 'FaceAlpha', 0.5)
shading interp
hold on
for j = 1:nc
thet11 = mean(X_sparse((j-1)*nvc+1:j*nvc,:),1); phi11 = mean(Y_sparse((j-1)*nvc+1:j*nvc,:),1);
theto = mean(X_org((j-1)*nvc+1:j*nvc,:),1); phio = mean(Y_org((j-1)*nvc+1:j*nvc,:),1);

%thet11 = X_sparse((j-1)*nvc+1,:);
%phi11 = Y_sparse((j-1)*nvc+1,:);
%thet11 = X((j-1)*nvc+1,:);
%phi11 = Y((j-1)*nvc+1,:);

%thet11o= mean(X_org((j-1)*nvc+1:j*nvc,:),1); phi11o = mean(Y_org((j-1)*nvc+1:j*nvc,:),1);

fac = 1.01; 
[x1,y1,z1] = sph2cart(phi11,thet11,fac);

[xo,yo,zo] = sph2cart(phio,theto,fac);

plot3(x1,y1,z1,'-',CL,cmap(j,:),LW,3);
plot3(xo,yo,zo,'--',CL,cmap(j,:),LW,3);
plot3(xo(1),yo(1),zo(1),'o',CL,cmap(j,:),MFC,cmap(j,:),LW,3);


%plot3(sin(they11o).*cos(phi11o),sin(they11o).*sin(phi11o),cos(they11o),'--',CL,cmap(j,:),LW,3);

end

% line([-1.2,1.2], [0,0], [0,0], 'LineWidth', 3, 'Color', 'k');
% line([0,0], [-1.2,1.2], [0,0], 'LineWidth', 3, 'Color', 'k');
% line([0,0], [0,0], [-1.2,1.2], 'LineWidth', 3, 'Color', 'k');

hold off
axis equal
axis off
lighting gouraud


axis vis3d

