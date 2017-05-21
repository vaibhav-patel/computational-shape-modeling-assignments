close all;
clear;
t=-10:0.25:10;
t=t';
p=sin(t);
r=2*p;
p=t+p*i;
q=5*p+1;
r=3*p+5;
r=r*exp(i*1);
q=q*exp(i*1);

%Problem 2
pa=myProcrustesAlign(p,r,1);

%Problem 3
mnshp=myProcrustesMean([p q r],0.25,1);












