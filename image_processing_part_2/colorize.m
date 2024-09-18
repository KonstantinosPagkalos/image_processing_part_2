function colorize(imagedata, wr, wg, wb)
    % Compute the total intensity of the grayscale image
    total_intensity = imagedata;
    
    % Compute the percentage of each primary color
    red_percent = total_intensity ./ max(total_intensity(:)); % Normalize to [0, 1]
    green_percent = total_intensity ./ max(total_intensity(:)); % Normalize to [0, 1]
    blue_percent = total_intensity ./ max(total_intensity(:)); % Normalize to [0, 1]
    
    % Multiply each color channel by the corresponding weight and the percentage of its primary color
    R = wr * red_percent .* imagedata;
    G = wg * green_percent .* imagedata;
    B = wb * blue_percent .* imagedata;
    
    % Combine the color channels back into an RGB image
    colored_imagedata = cat(3, R, G, B);
    
    % Display the original and colored images side by side
    figure;
    subplot(1,2,1);
    imshow(uint8(imagedata));
    title('Original Image');
    subplot(1,2,2);
    imshow(uint8(colored_imagedata));
    title('Colored Image');
end
