function [op_im] = Segment_randomly_seg(im, part_nm)


op_im = im;
obj_cont_in_crp = length(regionprops(im));

all_pxid = regionprops(im, 'PixelIdxList', 'Area');
[~, idx] = max([all_pxid(:).Area]);
pix_id = all_pxid(idx).PixelIdxList;

op_im(pix_id) = 0;


    pick_points = pix_id( randperm(length(pix_id), part_nm));
    op_im(pick_points) = 1;
    k = bwconncomp(op_im);
    
    while k.NumObjects ~= obj_cont_in_crp+(part_nm-1)
        pick_points = pix_id( randperm(length(pix_id), part_nm));
        op_im = zeros(size(im));
        op_im(pick_points) = 1;
        k = bwconncomp(op_im);
    end
    
end

