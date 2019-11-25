clc;
clear all;
close all;

tic; % 计时开始

win_size = 15;
W = 0.95;
t0 = 0.1;
l = 10^-4;

image = double(imread('./underwater/8.jpg'))/255;
figure('name', 'forest.jpg'); imshow(image);
 
Udark = get_underwater_dark_channel(image, win_size);

Atom  = get_atomsphere(image, Udark); 

t = 1 - W * get_underwater_dark_channel(image ./ Atom, win_size);

trans_est = softmatting(image, t, l);
figure('name', 't'); imshow(trans_est);

max_trans_est = repmat(max(trans_est, 0.1), [1, 1, 3]);

% 求解清晰图像
% J = (I-A)/max(t,t(0)) + A

result = ( (image - Atom)./max_trans_est ) + Atom;

toc; % 计时结束

figure('name', 'forest_recover.jpg'); imshow(result);
