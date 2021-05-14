
function rotation = isRot(R)

    rotation = max(max(abs(R' - inv(R)))) < 0.0001 && abs(det(R) -1) < 0.0001;
    
end