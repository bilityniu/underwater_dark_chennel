function result = softmatting(image, t, lambda)

[m, n, ~] = size(image);

L = get_laplacian(image);

A = L + lambda * speye(size(L));
b = lambda * t(:);

x = A \ b;

result = reshape(x, m, n);
end
