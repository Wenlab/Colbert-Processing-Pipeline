# Instruction

Download your .yaml files and HUDS.avi video files (which were generated using Colbert system to image) from servers. 
It's suggested to sort the file according to the experimental groups and worm numbers, like 'WEN1111\ctl\w1\20241017_2112_w1.yaml'. 
Use code in sequence from S1 to S7 for data preprocessing. (S4 need to be done by human action rather than code)
Finally you will end up with .mat files named like 'w1_mcd_corred_swapped.mat', which storage temporal and spatial information about the nematodes photographed, and .csv files named like 'machine_label_frame_window_10.csv', which storage machine-labeled classification results of nematode behavior.

Matlab Version: R2021a

# Processing of Colbert Dada

1. Reassemble the Yaml files into the MCD format and save as .mat files.

        S1_Convert_Yaml_to_Mcd.m

2. Fix the axis flipping issue.

        S2_Fix_axis_flipping_issue_of_mcd.m

3. Generate manual annotation table files (.csv) based on the HUDS video files.

        S3_Generate_manul_label_csv_based_on_HUDS.m

4. Manually annotate segments where the head and tail are upside-down.

        

5. Swap heads and tails coordinates as well as the centerline coordinates based on the table.

        S5_Swap_head_and_tail.m

6. Machine label of worm behavior.

        S6_Machine_Label_of_Colbert\interactive.mlapp
