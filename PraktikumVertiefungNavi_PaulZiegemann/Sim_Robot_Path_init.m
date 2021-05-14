
X = [509, 180];
Y = [467, 466];

load('pose_real.mat');

%%Erstelle GPS_Matrix
gps_sim = zeros(102,2);

%% Lauf der Trejaktorie ab
for i = 1 : length(pose_real)-1
       
    %Simulation GPS Koordinaten
    gps_sim(i,:) = [pose_real(i+1,1) + 2*randn(), pose_real(i+1,2) + randn()];

end

save('GPS_sim.mat','gps_sim');
save ('X.mat', 'X'); 
save ('Y.mat', 'Y');