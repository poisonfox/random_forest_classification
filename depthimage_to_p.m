function p = depthimage_to_p(image, cx, cy, f)
    p = zeros(length(image(:,1)) * length(image(1,:)),3);
    counter = 1;
    for i=1:3:length(image(:,1))
        for j=1:3:length(image(1,:))
            if (image(i,j)~=0)
            counter = counter + 1;
            y = image(i,j);
            x = ((j - cx) * y)/f;
            z = (-(i- cy)*y)/f;
            p(counter,:) = [x,y,z];
            end
        end
    end
    
   p(any(abs(p') == 0),:) = [];
end

