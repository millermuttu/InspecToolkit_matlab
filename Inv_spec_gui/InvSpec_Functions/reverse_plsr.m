function [X_new,Y_new] = reverse_plsr(X,Y,Y_pred)
    [n,p] = size(X);
    str = 'Xloadings';
    for k = 1:1:size(X,2)
        Xloadings{k} = sprintf('%s_%d',str,k);
    end
    str = 'Yloadings';
    for k = 1:1:size(X,2)
        Yloadings{k} = sprintf('%s_%d',str,k);
    end
    str = 'Xscores';
    for k = 1:1:size(X,2)
        Xscores{k} = sprintf('%s_%d',str,k);
    end
    str = 'Yscores';
    for k = 1:1:size(X,2)
        Yscores{k} = sprintf('%s_%d',str,k);
    end
    str = 'betaPLS7';
    for k = 1:1:size(X,2)
        betaPLS7{k} = sprintf('%s_%d',str,k);
    end
    str = 'PLSPctVar';
    for k = 1:1:size(X,2)
        PLSPctVar{k} = sprintf('%s_%d',str,k);
    end
    for i = 1:size(X,2)
        [Xloadings{i},Yloadings{i},Xscores{i},Yscores{i},betaPLS7{i},PLSPctVar{i}] = plsregress(X(:,1:i),Y,1);
    end
    x_pred = zeros(1,size(X,2)+1);
    x_pred(1,1) = 1;
    for k = 1:size(X,2)
        mass = 0;
        for h = 1:size(betaPLS7{k},1)-1
            mass = mass + (x_pred(h)*betaPLS7{k}(h,1));
        end
        x_pred(1,h+1) = (Y_pred - mass)/betaPLS7{k}(h+1,1);
    end
    final_x_pred = x_pred(1,2:end);
    X_new=[X;final_x_pred];
    Y_new=[Y;Y_pred];
end

