clear all;
clc;

%% load images
img = imread('depthImage.png');
img = double(img);
img = img / 1000;

% parameters
cx = 260.1922;
cy = 209.5835;
f  = 365.5953;

% depth to point cloud
[points] = depthimage_to_p(img, cx, cy, f);
% figure;
% scatter3(points(:,1),points(:,2),points(:,3), '.', 'r');
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Point cloud');

%% initiate search tree
tree = KDTreeSearcher(points);
nTrees = 100;
radius = 0.2;

%%
img_col = imread('image_o.png');

% colors in rgb values
color_yellow = [255, 242, 0];
color_blue   = [63, 72, 204];
color_red    = [237, 28, 36];
color_green  = [181, 230, 29];

[idx_person, idx_ceil, idx_desk, idx_wall] = read_color(img_col, color_yellow, color_blue, color_red, color_green);

%% create training data
feature_ceil  = create_training_data(points, idx_ceil, tree, radius, 1);
feature_person = create_training_data(points, idx_person, tree, radius, 2);
feature_desk  = create_training_data(points, idx_desk, tree, radius, 3);
feature_wall  = create_training_data(points, idx_wall, tree, radius, 4);

features_training = [feature_ceil; feature_person; feature_desk; feature_wall];

features = features_training(:,1:6);
classes  = features_training(:,7);

%% create decision tree
B = TreeBagger(nTrees, features, classes);
 
%% Classification
features_all=find_features_all(points, tree, radius);

prediction = B.predict(features_all);

%% Visualization
[cols, rows] =size(img);
col_img = img_col;
c=0;
for k=1:3:cols
    for l=1:3:rows
        if(img(k,l)~=0)
            c = c +1;
            P = str2num(prediction{c});
            if P == 1 % yellow
                col_img(k,l,1) = 255;
                col_img(k,l,2) = 242;
                col_img(k,l,3) = 0;
            elseif P == 4 % blue
                col_img(k,l,1) = 63;
                col_img(k,l,2) = 72;
                col_img(k,l,3) = 204;
            elseif  P == 2 % red
                col_img(k,l,1) = 237;
                col_img(k,l,2) = 28;
                col_img(k,l,3) = 36;
            elseif P == 3 % green
                col_img(k,l,1) = 181;
                col_img(k,l,2) = 230;
                col_img(k,l,3) = 29;
            end
        end
    end
end

% Output
figure(1)
image(col_img)
%imwrite(col_img,'result.png');
