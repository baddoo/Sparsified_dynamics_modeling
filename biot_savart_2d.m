%% Biot-Savart
%
% Computes the Biot-Savart law

function dzdt = biot_savart_2d(z,K,W)

n = numel(K);

x = z(1:n); y = z(n+1:end);
dx = x - x'; dy = y - y';
r2 = dx.^2 + dy.^2;

BSmatX = W.*dx./r2; BSmatX(logical(eye(n)))=0;
BSmatY = W.*dy./r2; BSmatY(logical(eye(n)))=0;

dxdt = -BSmatX*K/(2*pi);
dydt = -BSmatY*K/(2*pi);

dzdt = [dxdt;dydt];

end