
im_numb = v.FrameRate*v.Duration;

opvd.FrameRate = 5;
open(opvd)

cent_cord = cell(round(im_numb),1);
oret_angle = [];
majr_ax = [];
fus_lab=[];

ovrlp = cell(1);
relation = [];

inter_track = tm_smp*inter_frm;

for i = 1:tm_smp:im_numb
    img = read(v,i); % reading frame
    if size(img,3)>1
    img = rgb2gray(img); % colour conversion
    end
    img = imcrop(img,rect);
   img_real = img; % storing in another variable
   img_bn = imbinarize(img, imthrlvl/255); % binarizing
   img_bn = imcomplement(img_bn); % Complementing as the input image is negative contrast
   img_bn = imfill(img_bn,'holes');
   img_bn = bwareaopen(img_bn,open_var); % removing open objects
   
   cn_cmp = bwconncomp(img_bn);  % finding connected component
   
   obj_props = regionprops(img_bn,'Area','BoundingBox','MajorAxis','MinorAxis','Solidity');
  
   img_bn_act = img_bn;
   
   if cn_cmp.NumObjects < obj_num
       
       ar = obj_in_fusion(obj_props,obj_num,img_bn);
       for obj_nm = 1:size(obj_props,1)
           if ar(obj_nm,2)>1
               bbox_cl = ceil(obj_props(obj_nm).BoundingBox);
             
               
               crp=imcrop(img_bn,bbox_cl);
              
               crp_op=Segment_randomly_seg(crp,ar(obj_nm,2));
               i;
               img_bn(bbox_cl(2):bbox_cl(2)+bbox_cl(4),bbox_cl(1):bbox_cl(1)+bbox_cl(3)) = crp_op; 
           end
       end
       
   end
   
   
    if size(obj_props,1) > obj_num
        img_bn = bwareafilt(img_bn,obj_num);
    end
    obj_props=regionprops(img_bn,'Area','Centroid','PixelIdxList','BoundingBox','Orientation','Perimeter','MajorAxis');

   if size(obj_props,1)~=obj_num
       disp('Wrong Segmt');
      size(obj_props,1)
      i
      pause
   end
     
   
   if i == 1
       cord = [];
       bbox = [];
       oret = [];
       for j=1:obj_num
           cord(j,1:2)=[obj_props(j).Centroid];
           bbox(j,:)=obj_props(j).BoundingBox;
           oret(j)=obj_props(j).Orientation;
           majax(j)=obj_props(j).MajorAxisLength;
       end
       bbox_pre = bbox;
       cord_pre = cord;
       oret_pre = oret;
       maja_pre = majax;
       cent_cord{i} = cord;
       oret_angle(i,:) = oret;
       majr_ax(i,:) = majax;
       cord_arr = cord;
       
       
   else
       for j=1:obj_num
           bbox(j,:) = obj_props(j).BoundingBox;
           cord_curr(j,:) = obj_props(j).Centroid;
           oret_curr(j) = obj_props(j).Orientation;
           maja_curr(j) = obj_props(j).MajorAxisLength;
       end
       [relt,cord_arr,oret_arr,majax_arr,ovp] = assign_tracks(cord_pre, cord_curr,oret_curr,maja_curr);
   
       cord_pre=cord_arr;
       cent_cord{i}=cord_arr;
       ovrlp{i}=ovp;
       relation(i,:)=relt;
       oret_angle(i,:)=oret_arr;
       majr_ax(i,:)=majax_arr;
       fus_lab(i,:)=label_fus(img_bn_act,cord_arr,obj_num,cn_cmp);
       
   end
   
   
   markd_im = insertMarker(img_real,cord_arr,'color',color_markr);
   writeVideo(opvd, markd_im);
end

oret_angle = oret_angle(1:tm_smp:end,:);
majr_ax = majr_ax(1:tm_smp:end,:);
fus_lab = fus_lab(1:tm_smp:end,:);
relation = relation(1:tm_smp:end,:);
ovrlp = ovrlp(:,1:tm_smp:end);
cent_cord = cent_cord(1:tm_smp:end,:);
cent_cord = cell2mat(cent_cord);
cent_cord = reshape(cent_cord',obj_num*2,[]);

out_tab = [[1:tm_smp:im_numb]', cent_cord', oret_angle, majr_ax, fus_lab];


save(op_var, 'oret_angle','majr_ax','cent_cord','ovrlp','relation','tm_smp','inter_frm','inter_track','imthrlvl','obj_num','fus_lab','rect','out_tab');
writematrix(out_tab, op_res, 'Sheet', vid_nm);

close(opvd)
