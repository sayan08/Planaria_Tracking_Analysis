% Developed by by Sayan Biswas (sayanbiswasjuee@gmail.com)

% Note: Update the directory from where to read the files; threshold Array
clear all
close all
moth_dirt = 'Put your directory here\';
lst = dir(strcat(moth_dirt,'*.avi'));

trck_vid = fullfile(moth_dirt, 'Tracked_Video');
mkdir ( trck_vid );

trck_res = fullfile(moth_dirt,'Tracking_Results');
mkdir ( trck_res );

tm_smp = 4; % Calculate every which frame
inter_frm = 0.25; % inter frame time distance

color_org = {'blue', 'green', 'red' 'yellow','black','white','blue', 'green', 'red', 'cyan', 'magenta', 'yellow','black','white'};
% load (fullfile(moth_dirt, 'arr.mat'))
thr = 165*ones(1,15); % arr(:,1);
open_var_arr = 12*ones(1,15); % arr(:,2);

load (fullfile(moth_dirt, 'Roi.mat'))
op_res = fullfile(trck_res, strcat('Tracking.xlsx'));

for vid_range = 1:length(lst)
    disp(strcat( 'Starting', num2str(vid_range)) )
   
    clearvars -except vid_range trck_res trck_vid lst moth_dirt color_org thr open_var_arr op_res roi_arr tm_smp inter_frm
    open_var = open_var_arr(vid_range);
    


    vid_nm = lst(vid_range).name;
    v = VideoReader(strcat(moth_dirt,vid_nm));
    

    rect = roi_arr{vid_range,1};
    
   
    obj_num = roi_arr{vid_range,2};
    
    color_markr = color_org(1,1:obj_num);    
    level = graythresh( imcrop( read(v,1), rect));
    disp(strcat('OTSU is',num2str(255*level)));

   imthrlvl = thr(vid_range);
   
   
    
    opvd = VideoWriter(fullfile(trck_vid, vid_nm)); % for writing the Detected video
    
   
    op_var = fullfile(trck_res, strcat('Track_', vid_nm, '.mat'));
    tracking_centroid_with_time
end