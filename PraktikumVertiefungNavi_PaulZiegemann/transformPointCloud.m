
%%lade Daten
tp1 = load('teapotOut.asc');
tp2 = load('teapotOut2.asc');

%%homogene Anfangsmatrix
HMK = zeros(4,4);

HMK(1,:) = [cos(pi/4), sin(pi/4), 0, 0];
HMK(1,:) = [-sin(pi/4), cos(pi/4), 0, 0];
HMK(1,:) = [0, 0, 1, 0];
HMK(1,:) = [0, 0, 0, 1];

HMK = inv(HMK);

Pct = [];

for i=1 : length(tp1) 
 P(i,1) = HMK(1,:)*[tp1(i,1),tp1(i,2),tp1(i,3),1]'; 
 P(i,2) = HMK(2,:)*[tp1(i,1),tp1(i,2),tp1(i,3),1]'; 
 P(i,3) = HMK(3,:)*[tp1(i,1),tp1(i,2),tp1(i,3),1]'; 
end


scatter3(tp1(1:10:end,1), tp1(1:10:end,2), tp1(1:10:end,3),1);

hold on;
scatter3(tp2(1:10:end,1), tp2(1:10:end,2), tp2(1:10:end,3),10, 'g');
axis equal;

scatter3(P(1:10:end,1), P(1:10:end,2), P(1:10:end,3),10, 'm');
axis equal;







