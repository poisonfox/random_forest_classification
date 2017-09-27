function [person, ceil, desk, wall] = read_color(image_color, yellow, blue, red, green)
    person = zeros(0);
    ceil = zeros(0);
    desk = zeros(0);
    wall = zeros(0);
    c = 0;
    [cols, rows, ch] = size(image_color);
    
    for i=1:3:cols
        for j=1:3:rows
            if (image_color(i,j)~=0)       
                c = c + 1;
                
                if([image_color(i,j,1), image_color(i,j,2), image_color(i,j,3)] == blue)
                     wall = [wall; c];
                     
                elseif ([image_color(i,j,1), image_color(i,j,2), image_color(i,j,3)] == yellow)
                     ceil = [ceil; c];
                    
                elseif ([image_color(i,j,1), image_color(i,j,2), image_color(i,j,3)] == red)
                     person = [person; c];
                    
                elseif ([image_color(i,j,1), image_color(i,j,2), image_color(i,j,3)] == green)
                     desk = [desk; c];
                end             
            end            
        end
    end
end

