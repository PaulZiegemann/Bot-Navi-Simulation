function reg = calc_reg_gps(gps,delay)

sz = size(gps);
i = 1;
j = sz(1);


%Messwerte durchegehen (Singulärwertzerlegung)
for i=1 : N
    A(i, :) = [1, i/N, (i/N)^2];
    b1(i) = GPS(i,1);
    b2(i) = GPS(i,2);
    i=i+1;
end
    
    %Solve constrained linear least-squares problems
    [U,D,V] = svd(A'*A );
    M = V*inv(D)*U'*A'; % bei äqui. Zeiten offline möglich
    a1 = M*b1';
    a2 = M*b2'; 
    
    %normierten Zeitpunkt mit Verzögerung
    t = (j - delay)/j;
    
    %Trajektorie berechnen
    reg(1) = a1(1) + a1(2) * t + a1(3) * t^2;
    reg(2) = a2(1) + a2(2) * t + a2(3) * t^2;

end