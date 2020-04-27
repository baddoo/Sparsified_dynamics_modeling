%

function dynamics_plot(X,Y,X_org,Y_org,X_sparse,Y_sparse,nt,nvc,nc)

LW = 'LineWidth'; CL = 'Color'; MCL = 'MarkerFaceColor';
cmap = hsv(nc);
Xm = mean(X);Ym = mean(Y);
r_macro = mean(sqrt((X-Xm).^2+(Y-Ym).^2));
X_org = [X X_org(:,1:nt)];X_org = (X_org-Xm)/r_macro;
Y_org = [Y Y_org(:,1:nt)];Y_org = (Y_org-Ym)/r_macro;
X_sparse = [X X_sparse(:,1:nt)];X_sparse = (X_sparse - Xm)/r_macro;
Y_sparse = [Y Y_sparse(:,1:nt)];Y_sparse = (Y_sparse - Ym)/r_macro;

for j = 1:nc
    % Plot original dynamics
x11 = mean(X_sparse((j-1)*nvc+1:j*nvc,:),1); y11 = mean(Y_sparse((j-1)*nvc+1:j*nvc,:),1);
x11o= mean(X_org((j-1)*nvc+1:j*nvc,:),1);y11o = mean(Y_org((j-1)*nvc+1:j*nvc,:),1);
    % Plot sparsified dynamics
plot(x11,y11,'-',x11o,y11o,'--',CL,[cmap(j,:)],LW,3);
hold on
plot(x11(1),y11(1),'o',MCL,[cmap(j,:)],...
    'MarkerEdgeColor',[cmap(j,:)]);
end
hold off;axis square;
xlim([-2 2]);ylim([-2 2]);box on;
