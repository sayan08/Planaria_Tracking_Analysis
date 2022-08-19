function [ ovp ] = dist_centd( cord_curr,cord_pre )

ovp=zeros(size(cord_curr,1),size(cord_pre,1));
for i=1:size(cord_curr,1)
    val1=cord_curr(i,:);
    for j=1:size(cord_pre,1)
        val2=cord_pre(j,:);
        ovp(i,j)=pdist2(val1(1:2),val2(1:2));
    end
end



end

