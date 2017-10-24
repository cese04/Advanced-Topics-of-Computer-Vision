% External contour, rectangle.
x1 = [0 0 6 6 0];
y1 = [0 3 3 0 0];

% First hole contour, square.
x2 = [1 2 2 1 1];
y2 = [1 1 2 2 1];

% Second hole contour, triangle.
x3 = [4 5 4 4];
y3 = [1 1 2 1];

% Compute face and vertex matrices.
[f, v] = poly2fv({x1, x2}, {y1, y2});

% Display the patch.
patch('Faces', f, 'Vertices', v, 'FaceColor', 'r', ...
 'EdgeColor', 'none');
axis off, axis equal