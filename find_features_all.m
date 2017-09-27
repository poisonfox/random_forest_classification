function [matrix] = find_features_all(points, tree, radius)

[cols,rows]=size(points);
matrix = zeros(cols, 6);

for k=1:cols

    idx = rangesearch(tree, points(k,:), radius);
    circle = points(idx{1},:);
    %display(k)
    %display(circle)
    
    [n, l, p, v, sigma] = calculate_plane(circle);

    matrix(k, 1)= l;
    matrix(k, 2)= p;
    matrix(k, 3)= v;
    matrix(k, 4)= points(k,3);
    matrix(k, 5)= n(3); 
    matrix(k, 6)= sigma;
    
end


end
