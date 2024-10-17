% Protect beyond edge situation when labelling turn
%
% 2023-10-13, Yixuan Li
%

function label = beyond_the_edge(mcd,label,enable_output)

%% get mask
n_frames = numel(mcd);
start_frame = 1;
end_frame = n_frames;
[centerline_all,~,~] = get_centerlines_in_relative_frame(mcd,start_frame,end_frame);

% only label the unlabelled
mask = label == 0;
centerline_all = centerline_all(mask);

%% if the tail is near edges
pixel_threshold = 10; % super-parameter
[x_max,x_min,y_max,y_min] = detect_edge(centerline_all);
[x_tail,y_tail] = get_tail_coord(centerline_all);
mask_x = abs(x_tail - x_max) < pixel_threshold | abs(x_tail - x_min) < pixel_threshold;
mask_y = abs(y_tail - y_max) < pixel_threshold | abs(y_tail - y_min) < pixel_threshold;
mask_all = mask_x | mask_y;

%% label
global label_number_beyond_edge
label(mask) = mask_all * label_number_beyond_edge;
label_beyond_edge = rearrange_label(label);
label_beyond_edge = remain_rows(label_beyond_edge,label_number_beyond_edge);

%% save
global folder_of_saved_files
file_name = 'beyond_the_edge.csv';

if nargin < 3
    output_label(label_beyond_edge, folder_of_saved_files, file_name, mcd);
elseif enable_output == true
    output_label(label_beyond_edge, folder_of_saved_files, file_name, mcd);
end

end