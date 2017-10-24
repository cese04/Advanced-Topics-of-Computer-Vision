clc, clear all, close all


X = rand(200,3000)*255;

mu = mean(X);
[x,y] = size(X);

for i=1:y
    X1(:,i) = X(:,i)-mu(i);
end

Ep = cov(X1);

[vec, latent] = eig(Ep);
latent = diag(latent);
%%
for i=1:y
    Y(:,i) = X*vec(:,i);
end