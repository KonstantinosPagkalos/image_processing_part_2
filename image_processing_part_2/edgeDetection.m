function edgeDetection(image)
    % Convert image to grayscale
    grayImage = rgb2gray(image);

    % Apply Sobel operator for edge detection
    sobelX = [-1 0 1; -2 0 2; -1 0 1];
    sobelY = [-1 -2 -1; 0 0 0; 1 2 1];
    Gx = conv2(double(grayImage), sobelX, 'same');
    Gy = conv2(double(grayImage), sobelY, 'same');
    G = sqrt(Gx.^2 + Gy.^2);

    % Threshold the image
    T = 0.1 * max(G(:));
    binaryImage = G > T;

    % Create RGB image where edges are green and background is blue
    edgeImage = zeros(size(image));
    edgeImage(:,:,2) = binaryImage;
    edgeImage(:,:,3) = ~binaryImage;

    % Display original, grayscale, edge-detected, and thresholded images
    figure
    subplot(2,2,1)
    imshow(image)
    title('Original Image')
    subplot(2,2,2)
    imshow(grayImage)
    title('Grayscale Image')
    subplot(2,2,3)
    imshow(G, [])
    title('Edge Detection')
    subplot(2,2,4)
    imshow(binaryImage)
    title('Thresholded Image')

    % Add another subplot to show the thresholded edges in the context of the original image
    figure
    subplot(1,2,1)
    imshow(image)
    title('Original Image')
    subplot(1,2,2)
    imshow(edgeImage)
    title('Thresholded Edges (Green)')

end
