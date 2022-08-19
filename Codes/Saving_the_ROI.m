% Developed by by Sayan Biswas (sayanbiswasjuee@gmail.com)

% Note: Update the directory from where to read the files
clear all
close all
moth_dirt = 'Directory\';
lst = dir(strcat(moth_dirt,'*.avi'));
roi_arr = cell(1);

for vid_range = 1:length(lst)
    vid_nm = lst(vid_range).name;
    v = VideoReader(strcat(moth_dirt,vid_nm));
    
    figure(1)
    clf
    imshow(read(v,1));
    
    title('Select the assay region')
    rect = getrect;
    
    prompt = 'Number of Objects';
    obj_num = input(prompt);
    
    roi_arr(vid_range,1:2) = {rect, obj_num};
end

save(fullfile(moth_dirt, 'Roi.mat'), 'roi_arr')