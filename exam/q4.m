clear;
close all;
load('cylinderdata2017.mat');
mymeshdeform(v,face,[indmove; indfix], def_handle);



