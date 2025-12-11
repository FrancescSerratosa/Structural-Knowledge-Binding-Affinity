clc
clear all
close all
load('Table2.mat');
load('Table1_Rp.mat');

mu0=mean(Values);
x1=Values(M(:,1)==1);
x2=Values(M(:,2)==1);
x3=Values(M(:,3)==1);
x4=Values(M(:,4)==1);
x5=Values(M(:,5)==1);
x6=Values(M(:,6)==1);
x7=Values(M(:,7)==1);
x8=Values(M(:,8)==1);

h=[]; p=[]; ci=zeros(8,2); stats=[];
[h(1),p(1),ci(1,:),stat] = ttest(x1, mu0, 'Tail','right'); stats(1)=stat.tstat;
[h(2),p(2),ci(2,:),stat] = ttest(x2, mu0, 'Tail','right'); stats(2)=stat.tstat;
[h(3),p(3),ci(3,:),stat] = ttest(x3, mu0, 'Tail','right'); stats(3)=stat.tstat;
[h(4),p(4),ci(4,:),stat] = ttest(x4, mu0, 'Tail','right'); stats(4)=stat.tstat;
[h(5),p(5),ci(5,:),stat] = ttest(x5, mu0, 'Tail','right'); stats(5)=stat.tstat;
[h(6),p(6),ci(6,:),stat] = ttest(x6, mu0, 'Tail','right'); stats(6)=stat.tstat;
[h(7),p(7),ci(7,:),stat] = ttest(x7, mu0, 'Tail','right'); stats(7)=stat.tstat;
[h(8),p(8),ci(8,:),stat] = ttest(x8, mu0, 'Tail','right'); stats(8)=stat.tstat;

Table3=[h',p',ci(:,1),stats']
