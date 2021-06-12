function [outnew] = overlapp(WL_A,WL_B,b,s)
i=0;
j=0;
outnew=zeros(1,(b+s));
for i=1:b
     for j=1:s
        if WL_A(i)== WL_B(j);
            outnew(i)=[WL_A(i)];
         end
     end
end
end

