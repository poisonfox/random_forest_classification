function [matrix] = create_training_data(points, idx_object, tree, radius, class)

[cols,rows]=size(idx_object);
matrix = zeros(cols, 7);

for k=1:cols
    object = points(idx_object(k),:);
    idx = rangesearch(tree, object, radius);
    circle = points(idx{1},:);
    
    [n, l, p, v, sigma] = calculate_plane(circle);
    
    matrix(k, 1)= l;
    matrix(k, 2)= p;
    matrix(k, 3)= v;
    matrix(k, 4)= points(idx_object(k),3);
    matrix(k, 5)= n(3);
    matrix(k, 6)= sigma;
    matrix(k, 7)= class;
   % display(matrix(k,:))
end


end
