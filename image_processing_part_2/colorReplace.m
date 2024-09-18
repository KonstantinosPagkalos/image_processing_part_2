function [newImage, cancel] = colorReplace(image)
    % Display the input image
    figure;
    imshow(image);
    
    % Prompt the user to select a color to replace
    colorToReplace = impixel(image);
    tolerance = 20; % Set a tolerance for color matching
    
    % Reshape colorToReplace to match the size of the image array
    colorToReplace = reshape(colorToReplace, 1, 1, size(image, 3));
    
    % Prompt the user to select a new color
    newColor = uisetcolor();
    
    % Replace the selected color with the new color
    colorMask = (abs(double(image) - double(colorToReplace)) <= tolerance);
    newImage = image;
    newImage(repmat(colorMask, [1 1 3])) = repmat(newColor, [nnz(colorMask) 1]);
    
    % Display the resulting image
    figure;
    imshow(newImage);
    
    % Prompt the user to continue or cancel
    prompt = 'Do you want to continue? Y/N [Y]: ';
    str = input(prompt,'s');
    if isempty(str)
        str = 'Y';
    end
    if strcmpi(str, 'N')
        cancel = true;
    else
        cancel = false;
    end
end
