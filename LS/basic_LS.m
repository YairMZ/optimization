%% reference and blurring
clear
close all

pic = imread('tree.jpg');
[A,y,X] = blurring(pic);

[n,m] = size(X);
blurred_pic = reshape(y, n, m);

figure(1)
imshow(X)
title('Reference picture')
%saveas(gcf,'Reference.eps','epsc')
%% blurred picture

figure(2)
imshow(blurred_pic)
title('Blurred picture')
%saveas(gcf,'Blurred.eps','epsc')
%% LS
x_LS = (A'* A)\(A'*y);

figure(3)
imshow(reshape(x_LS, n, m))
title('LS reconstructed picture')
%saveas(gcf,'LS.eps','epsc')
%% RLS 
lambda = 5*1e-4; %required some trial and error
x_RLS = (A'* A + lambda*speye(size(A'* A,1)) )\(A'*y);

figure(4)
imshow(reshape(x_RLS, n, m))
title('RLS reconstructed picture, \lambda = 5*1e-4')
%saveas(gcf,'RLS.eps','epsc')
%% MSE 
LS_MSE = norm(x_LS - X(:))^2 / length(x_LS)
RLS_MSE = norm(x_RLS - X(:))^2 / length(x_RLS)