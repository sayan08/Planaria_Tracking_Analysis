function [ ar ] = obj_in_fusion( prop, num, img_bn )

ar=[];
 for i=1:size(prop,1)
     ar(i,1)=prop(i).Area;
     ar(i,2)=1;
 end
 
 [arr_val,arr_idx]=sort(ar(:,1),'descend');
 
if (num-size(prop,1))==1
    ar(arr_idx(1),2)=ar(arr_idx(1),2)+1;
   return
elseif size(prop,1) == 1
    ar(arr_idx(1),2)=num;
   return
else
    while(sum(ar(:,2))~=num)
   for i=1:size(prop,1)
        crp=imcrop(img_bn,ceil(prop(arr_idx(i)).BoundingBox));
        figure(2)
        imshowpair(img_bn,crp,'montage');
        prompt='Number of Object Fused';
        ip=input(prompt);
        ar(arr_idx(i),2)=ar(arr_idx(i),2)+(ip-1);
        if sum(ar(:,2))==num
            break
            
        end
   end
    end
end
end

