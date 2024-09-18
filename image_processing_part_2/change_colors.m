function change_colors(image)
% display original image
figure(1), imshow(image), title('Original Image')

% convert image to double precision for mathematical operations
image = im2double(image);

% initialize variables
x = []; y = [];

% select color to replace
while isempty(x) || isempty(y)
    [xi,yi,button] = ginput(1);
    if button == 1 % add point
        x = [x; xi];
        y = [y; yi];
        hold on;
        plot(x(end), y(end), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
    elseif button == 3 % remove point
        if ~isempty(x)
            x = x(1:end-1);
            y = y(1:end-1);
            hold off;
            imshow(image);
            hold on;
            plot(x, y, 'r+', 'MarkerSize', 10, 'LineWidth', 2);
        end
    end
end

% select color to replace
n_points = numel(x);
color_to_replace = zeros(1, 1, 3);
for i = 1:n_points
    color_to_replace = color_to_replace + image(round(y(i)), round(x(i)), :);
end
color_to_replace = color_to_replace / n_points;

% select new color
new_color = uisetcolor('Select a new color');

% compute squared distance to color to replace
R0 = 0.1; % color range
diff = image - repmat(color_to_replace, [size(image,1), size(image,2), 1]);
S = sum(diff.^2, 3);

% select pixels within color range
mask = S < (R0^2);

% update color values for selected pixels
image_new = image;
image_new(:,:,1) = mask.*new_color(1) + (1-mask).*image(:,:,1);
image_new(:,:,2) = mask.*new_color(2) + (1-mask).*image(:,:,2);
image_new(:,:,3) = mask.*new_color(3) + (1-mask).*image(:,:,3);

% display modified image
figure(1), imshow(image_new), title('Modified Image');
    
end
