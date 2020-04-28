%% Biot-Savart
%
% Computes the Biot-Savart law

function dzdt = biot_savart_3d(z,K,W)

n = numel(K);

thet = z(1:n); phi = z(n+1:end);
dphi = phi - phi';

l2 = 2*(1 - cos(thet)*cos(thet') - sin(thet).*sin(thet.').*cos(dphi)); % Square of chord distance between vortices

BSmatThet = W.*sin(thet').*sin(dphi)./l2; 
BSmatThet(logical(eye(n)))=0;
BSmatPhi = W.*(cos(thet') - cot(thet).*sin(thet').*cos(dphi))./l2; 
BSmatPhi(logical(eye(n)))=0;

dthetdt = -BSmatThet*K/(2*pi);
dphidt =   BSmatPhi*K/(2*pi);

dzdt = [dthetdt;dphidt];

end