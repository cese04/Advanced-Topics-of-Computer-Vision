function n = proj(m,P)

n = P * m;

n(1, :) = n(1, :) ./ n(3, :);
n(2, :) = n(2, :) ./ n(3, :);


