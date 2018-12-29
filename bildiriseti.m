function [fit]= bildiriseti(x, func_num)

if func_num == 1
    S=x.*x;
    fit=sum(S');
elseif func_num == 2
    [~, D] = size(x);
    p=x;
    fit=100*sum((p(:,2:D)-(p(:,1:D-1)).^2).^2,2)+sum((p(:,1:(D-1))-1).^2,2);    
elseif func_num == 3
    fit = sum(x .^ 2 - 10 .* cos(2 .* pi .* x) + 10, 2);    
elseif func_num == 4
    [~, D] = size(x);
    f = 1;
    for i = 1 : D
        f = f .* cos(x(:, i) ./ sqrt(i));
    end
    f = sum(x .^ 2, 2) ./ 4000 - f + 1;
    fit=f;
elseif func_num == 5
    [~,D] = size(x);
    f = sum(x .^ 2, 2);
    f = 20 - 20 .* exp(-0.2 .* sqrt(f ./ D)) - exp(sum(cos(2 .* pi .* x), 2) ./ D) + exp(1);
    fit=f;
end
end