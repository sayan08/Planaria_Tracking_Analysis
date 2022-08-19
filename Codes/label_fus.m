function [ fs_lab ] = label_fus(img_bn_act,cord_arr,obj_num,cn_cmp)

fs_lab=zeros(1,obj_num);
props=regionprops(img_bn_act,'PixelList');
idt=0;
if length(props)<obj_num
    for i=1:length(props)
        px=props(i).PixelList;
        mmb=ismember(round(cord_arr),round(px),'rows');
        if nnz(mmb)>1
            idt=idt+1;
            fs_lab(find(mmb==1))=idt;
        end
    end
    
    
elseif cn_cmp.NumObjects==obj_num
    
end

end

