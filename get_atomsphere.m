%求解大气光强度A
function Atomsphere = get_atomsphere(image, dark_channel)

[m, n, ~] = size(image);

pixels_num = m * n; % 像素总和

select_pixel_num = floor(pixels_num * 0.0001); %选取像素0.1%

max_pix = [0, 0];

for i = 1 : 1 : select_pixel_num
    MaxVaule = max(max(dark_channel));
    [x, y] = find(dark_channel == MaxVaule);
    dark_channel(dark_channel == MaxVaule) = 0; %最大值清零，寻找其他合适的值
    max_pix = vertcat(max_pix, [x, y]);
    
    num = length(max_pix);
    if num > select_pixel_num
        break;
    end
end
%取select_pixel_num个合适值，去除首个初始化值与后面超出个数的值
Max_Pix = max_pix(2 : select_pixel_num + 1, : );

Rsum = 0;  Jr = image(:,:,1);
Gsum = 0;  Jg = image(:,:,2);
Bsum = 0;  Jb = image(:,:,3);

for i = 1 : 1 : select_pixel_num
    Rsum = Rsum + Jr(Max_Pix(i, 1), Max_Pix(i, 2));
    Gsum = Gsum + Jg(Max_Pix(i, 1), Max_Pix(i, 2));
    Bsum = Bsum + Jb(Max_Pix(i, 1), Max_Pix(i, 2));
end
    
sum = [Rsum/select_pixel_num, Gsum/select_pixel_num, Bsum/select_pixel_num];

Atomsphere = repmat(reshape(sum, [1, 1, 3]), m, n);


