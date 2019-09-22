% Please run the M_H.m firstly to get variables that are used in this file.
% Please run the M_H.m firstly to get variables that are used in this file.
% Please run the M_H.m firstly to get variables that are used in this file.

% construct the canvas
im_x1 = [0; 640; 640; 0];
im_y1 = [[0; 0; 480; 480]];
temp = [im_x1,im_y1,[1;1;1;1]]*H;
temp = temp./repmat(temp(:,3),1,3);
im_x2 = temp(:,1);
im_y2 = temp(:,2);
x_min = int32(min([im_x1,im_x2],[],'all'));
y_min = int32(min([im_y1,im_y2],[],'all'));
x_max = int32(max([im_x1,im_x2],[],'all'));
y_max = int32(max([im_y1,im_y2],[],'all'));
canvas = zeros(y_max-y_min+1,x_max-x_min+1,3,'uint8'); % plus 1 to round up 

% painting image2 on the canvas
[h1,w1,~]=size(image2);
for h=1:h1
    for w=1:w1
        canvas(h-y_min,w-x_min,:) = image2(h,w,:);
    end
end

% painting J on the canvas
x2_min = int32(min(im_x2,[],'all'));
y2_min = int32(min(im_y2,[],'all'));
x1_min = int32(min(im_x1,[],'all'));
y1_min = int32(min(im_y1,[],'all'));
x1_max = int32(max(im_x1,[],'all'));
y1_max = int32(max(im_y1,[],'all'));
[h2,w2,~]=size(J);
for h=1:h2
    for w=1:w2
        
        if sum(J(h,w,:)) ~= 0
            % overlapping
            if  (h+y2_min-y_min) >=(y1_min-y_min) && (h+y2_min-y_min) <=(y1_max-y_min) && (w+x2_min-x_min)>=(x1_min-x_min) && (w+x2_min-x_min)<=(x1_max-x_min)
                canvas(h+y2_min-y_min,w+x2_min-x_min,:) = canvas(h+y2_min-y_min,w+x2_min-x_min,:)./2+J(h,w,:)./2;
            % nonoverlapping
            else
                canvas(h+y2_min-y_min,w+x2_min-x_min,:) = J(h,w,:);
            end
        end
        
    end
end
figure();imshow(canvas)
%axis on % not beautiful 