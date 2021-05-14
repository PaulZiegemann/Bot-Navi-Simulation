
%% erstelle figure
fig = figure();

%% lade Daten rein
% pose_real -> X,Y,Orientation
load('pose_real.mat');
load('GPS.mat');
load('delta_real.mat');
load('X.mat');
load('Y.mat');


%%initialiesiere homogene Anfangsmatrix
 pHMK = zeros(4,4);
 pHMK(1,:) = [cosd(pose_real(1,3)), -sind(pose_real(1,3)), 0, pose_real(1,1)];
 pHMK(2,:) = [sind(pose_real(1,3)),  cosd(pose_real(1,3)), 0, pose_real(1,2)];
 pHMK(3,:) = [0, 0, 1, 0];
 pHMK(4,:) = [0, 0, 0, 1];
 xyHMK(1,1:2) = pose_real(1,1:2);
 
 

%%Setze die Anfangsposition fuer Koppelnavigation fest
pose_koppel_kor(1,1:3) = pose_real(1,1:3);
pose_koppel(1,1:3) = pose_real(1,1:3);

%% Lauf der Trejaktorie ab
for i = 1 : length(pose_real)-2
    
    %Koppelnavigation
    kp = koppel(pose_koppel(i,1:3),delta_real(i+1, 1:2));
    pose_koppel(i+1, 1:3) = kp(1:3);
    pose_koppel_kor(i+1, 1:3) = kp(1:3);
    
    %Koppelnavigation durch Homogen Matrix
    pHMK = koppelHM(pHMK, delta_real(i+1,1:2));
    xyHMK(i+1,1) = pHMK(1,4);
    xyHMK(i+1,2) = pHMK(2,4);
    
    %Koppelnavigation korrigieren durch Stützstellen
    if(i  > 0)
        
        funx = @(x)(pose_koppel_kor(i+1,1)-(GPS(i,1)+x(1)+x(2)))^2;
        funy = @(x)(pose_koppel_kor(i+1,2)-(GPS(i,2)+x(1)+x(2)))^2;
        
        kor1 = [-1,1];
        kor2 = [-1.2,1];
    
        korKompX(1,1:2) = fminsearch(funx, kor1); 
        korKompY(1,1:2) = fminsearch(funy, kor2);
        
        pose_koppel_kor(i+1,1) = pose_koppel_kor(i+1,1)-korKompX(1,1)-korKompX(1,2);
        pose_koppel_kor(i+1,2) = pose_koppel_kor(i+1,2)-korKompY(1,2)-korKompY(1,2);
        
    end
    sw = 20;
    delay = 6;
    
    %if i>sw
        %gps_sw = GPS( k-sw+2 : k+1, : ); 
        %reg = calc_reg(gps_sw, delay);
        %ppr(i+1,-delay, 1:3) = [reg(1:2),0];
    %else
        %ppr(i+1,1:3) = ppr(1,1:3);
    %end
    
    
    %%Plot Konfiguration
    clf(fig);
    fig = figure(1);
    img = imread('myImg3.jpg');
    imshow(img);
    [h,w,c] = size(img);
    axis([-0 w -0 h]);
    hold on;
    grid on;
    
    %plot gefahrene Trajektorie
    plot(pose_real(1:i+1,1), pose_real(1:i+1,2), 'w-', 'LineWidth', 8);
    
    %plot Trajektorie nach Koppelnavigationsberechnung
    plot(pose_koppel(1:i+1,1), pose_koppel(1:i+1,2), 'r', 'LineWidth', 5);
    
    %plot neuster Stand der Trajektorie zu den Landmarken
    %d1 = sqrt((X(1)-pose_real(i,1))^2 + (Y(1) - pose_real(i,2))^2);
    %d2 = sqrt((X(2)-pose_real(i,1))^2 + (Y(2) - pose_real(i,2))^2);
    plot([pose_real(i,1),X(1)],[pose_real(i,2),Y(1)], 'w-', 'LineWidth', 2);
    plot([pose_real(i,1),X(2)],[pose_real(i,2),Y(2)], 'w-', 'LineWidth', 2);
    
    %plot GPS
    plot(GPS(1:i+1,1), GPS(1:i+1,2), 'g*');
    
    %plot homogenMatrix Koppelnavigation
    plot(xyHMK(1:i+1,1), xyHMK(1:i+1,2), 'y-', 'LineWidth', 3);
    
    %plot korregierte Koppelnav
    plot( pose_koppel_kor(1:i+1,1), pose_koppel_kor(1:i+1,2), 'c-', 'LineWidth',3); 
    
    %plot regression
    %if i > 9
    %plot(reg_store(1:i,1), reg_store(1:i,2), 'b-', 'LineWidth',3);
    %end
    
    p1x = pHMK(:,1) + pHMK(:,4);
    p1y = pHMK(:,2) + pHMK(:,4);
    
    p2 = pHMK(:,4);
    
    vecX = (p1x-p2) / norm(p1x-p2) * 10;
    vecY = (p1y-p2) / norm(p1y-p2) * 10;
    
    plot( [p2(1) + vecX(1), p2(1)], [p2(2)+vecX(2), p2(2)], '-r');
    plot( [p2(1) + vecY(1), p2(1)], [p2(2)+vecY(2), p2(2)], '-b');
    
    %plot legeneden
    legend('Gefahrene Traj', 'Koppel Navigation', 'Messung 2', 'Messung 1', 'GPS','Homogen Matrix KoppelNav','Driftkorrekigiert','Regression','','');
    title('Landmarken Navigation basierend auf Odometrie, Range Bearing und GPS');
    
    pause(0.1);
    
    
end


P_dach_kp1_kf = [0.2, 0; 0, 0.2];
x_dach_kp1_kf(1:3) = [100, 100, 90];
V_kf = [0.01, 0; 0, 0.01];
W_kf = [0.2, 0; 0, 0.2];
