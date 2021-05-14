function pose_kor = clc1(start, delta_real, X)
   
%startwert minsearche
x0 = [0,1];

%Definition der Fehlerfunktion
f = @(x)(err_lc(x0,delta_real, start, X));

%Funktion aufrufen und minimum suchen
x = fminsearch(f,x0);

pose_kor(1,:) = start;

end