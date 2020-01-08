clear all, close all, clc

% The input file
input_fid = fopen('User1_100_20181017_222554.hpl');
output_fid = fopen('test.hpl')

input_line = fgetl(input_fid);
while ischar(input_fid)
    output_line = input_line;
    fprintf(fileID,'%6.2f %12.8f\n', y);