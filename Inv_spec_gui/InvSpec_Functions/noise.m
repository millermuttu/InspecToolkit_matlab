function [Y] = noise(X,m)
i=0;
Y=zeros(m,size(X,2));
for i=1:m
    Y(i,:)= (X+(rand(size(X(i)))*0.01));
end
end