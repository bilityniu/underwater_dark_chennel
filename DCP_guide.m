% function:Dark channel period(DCP) to dedhaze, use guide filter.
% input: 
%       image: origin  input image;
%       win_size: the pitch size of dark channel windows
%       omega: a constant parameter W(0<W<=1), keep little haze to make the image more natural.
%       t0: the low bound of transmission, a typical value is 0.1.
% output: dehazed image.
function [result] = DCP_guide(image, win_size, omega, t0)

if ~exist('win_size', 'var')
    win_size = 15;
end

if ~exist('omega', 'var')
    omega = 0.95;
end

if ~exist('t0', 'var')
    t0 = 0.1;
end

r = win_size * 4;
eps = 10^-6;

image = double(im2uint8(imread(image)))/255;
figure('name', 'imput'); imshow(image);

Jdark = get_dark_channel(image, win_size);

Atom  = get_atomsphere(image, Jdark); 

t = 1 - omega * get_dark_channel(image ./ Atom, win_size);

trans_est = guidedfilter(double(rgb2gray(image)), t, r, eps);
figure('name', 't'); imshow(trans_est);

max_trans_est = repmat(max(trans_est, t0), [1, 1, 3]);

% Çó½âÇåÎúÍ¼Ïñ
% J = (I-A)/max(t,t(0)) + A
result = ( (image - Atom)./max_trans_est ) + Atom;

end
