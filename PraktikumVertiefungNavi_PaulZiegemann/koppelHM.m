
%%Koppelnavigation mit homogenen Matritzen

function HMK = koppelHM(HMK,delta_real)

    start = [0,0,0];

     x_new = motionModel(start, delta_real);
     
     dx = x_new(1);
     dy = x_new(2);
     dh = x_new(3);
    
     HMKm = zeros(4,4);
     HMKm(1,:) = [cosd(dh), -sind(dh), 0, dx];
     HMKm(2,:) = [sind(dh), cosd(dh), 0, dy];
     HMKm(3,:) = [0, 0, 1, 0];
     HMKm(4,:) = [0, 0, 0, 1];
     
     HMK = HMK*HMKm;
end