function Udark = get_underwater_dark_channel(image, win_size)

[m, n, ~] = size(image);

Ig = image( : , : , 2);
Ib = image( : , : , 3);

%选取窗口定义初始化
Igg = 1./zeros(m + (win_size-1), n + (win_size-1));
Ibb = 1./zeros(m + (win_size-1), n + (win_size-1));

radius_size = floor(win_size / 2);
Igg(radius_size : (m + radius_size-1), radius_size :(n + radius_size-1)) = Ig;
Ibb(radius_size : (m + radius_size-1), radius_size :(n + radius_size-1)) = Ib;

Udark = zeros(m, n);

for i = 1 : 1 : m
    for j = 1 : 1 : n
        Gmin = min(min( Igg(i : i + (win_size-1), j : j + (win_size-1)) ));
        Bmin = min(min( Ibb(i : i + (win_size-1), j : j + (win_size-1)) ));      
        Udark(i,j) = min(Gmin, Bmin);
    end
end