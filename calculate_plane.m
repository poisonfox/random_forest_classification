function[n, l, p, v, sigma] = calculate_plane(pc)

[cols, rows] =size(pc);

if (cols<3)
    n = [0 0 1];
    eigenVal = [1 0 0;0 1 0;0 0 1];
    l = (eigenVal(3,3) - eigenVal(2,2))/eigenVal(3,3);
    p = (eigenVal(2,2) - eigenVal(1,1))/eigenVal(3,3);
    v = eigenVal(1,1)/eigenVal(3,3);
    sigma = 1;
else
    % determine center of mass
    p_(1,1) = sum(pc(:,1))/length(pc);
    p_(2,1) = sum(pc(:,2))/length(pc);
    p_(3,1) = sum(pc(:,3))/length(pc);

    % reduced coordinates
    for k = 1:length(pc);
        p_red(k,1) = pc(k,1)-p_(1,1);
        p_red(k,2) = pc(k,2)-p_(2,1);
        p_red(k,3) = pc(k,3)-p_(3,1);
    end

    %compute A^T*A
    AtA = p_red'*p_red;

    % calculate n
    [eigenVec, eigenVal] = eig(AtA);
    ev(1,1) = eigenVal(1,1);
    ev(2,1) = eigenVal(2,2);
    ev(3,1) = eigenVal(3,3);

    min_eig = min(ev);
    ind = find(min(ev));
    n = eigenVec(:,ind);      
    %n = n/norm(n);    

    % calculate d
    %d = -n'*p_;

    l = (eigenVal(3,3) - eigenVal(2,2))/eigenVal(3,3);
    p = (eigenVal(2,2) - eigenVal(1,1))/eigenVal(3,3);
    v = eigenVal(1,1)/eigenVal(3,3);

    sigma = abs(sqrt(min_eig/(length(pc(:,1)) - 3)));
end



end