clc;
clear all;
close all;

tic; % ��ʱ��ʼ

win_size = 15;
t0 = 0.1;
r = win_size*4;
eps = 10^-6;

image = double(imread('.\underwater\8.jpg'))/255;
figure('name', 'input'), imshow(image);
 
Udark = get_underwater_dark_channel(image, win_size);
% ��ʾͼ��ͨ��
figure('name', 'dark channel'),imshow(Udark);

Atom  = get_atomsphere(image, Udark); 

t = 1 - get_underwater_dark_channel(image ./ Atom, win_size);

trans_est = guidedfilter(double(rgb2gray(image)), t, r, eps);

figure('name', 't'), imshow(trans_est);
figure('name', 't_color'), imshow(t_color);

max_trans_est = repmat(max(trans_est, 0.1), [1, 1, 3]);


% �������ͼ��
% J = (I-A)/max(t,t(0)) + A

result = ( (image - Atom)./max_trans_est ) + Atom;

toc; % ��ʱ����

figure('name', 'output'); imshow(result);
