function [X] =update(x,k)
X={};
p=1;
for i=1:size(x,2)
    if all(double(i~=k)==1)
        X{p}=x{i};
        p=p+1;
    end
end
end


