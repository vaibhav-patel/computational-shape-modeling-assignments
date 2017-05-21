close all;
clear;
load('cat0.mat')
M=surface;
V = [M.X M.Y M.Z];
F = M.TRIV;
computeLaplaceBeltrami(V,F)





















