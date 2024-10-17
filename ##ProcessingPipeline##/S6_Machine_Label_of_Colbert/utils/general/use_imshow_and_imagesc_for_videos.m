dbstop if error;
clc;clear;close all;

%%
folder_path = uigetdir;
list = get_all_files_of_a_certain_name_pattern_in_a_rootpath(folder_path,"*.avi");
[indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Choose files');
for i = indx
    full_path = list{i};
    vid_reader = VideoReader(full_path);

    % loop to process
    while hasFrame(vid_reader)
        frame = readFrame(vid_reader);

        % imshow
        imshow(frame);

        % imagesc
        channel_1 = frame(:,:,1);
        channel_2 = frame(:,:,2);
        channel_3 = frame(:,:,3);
        my_imagesc(channel_1)
        my_imagesc(channel_2)
        my_imagesc(channel_3)
    end
end

function my_imagesc(matrix_2D)
figure;
imagesc(matrix_2D);
colormap('hot');
colorbar;
axis equal;
end