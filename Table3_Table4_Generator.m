clc
clear all
close all
load('Table2.mat');
load('Table1_Rp.mat');

%%%%%%%% TABLE 3 GENERATOR

x1=Values(M(:,1)==1);
x2=Values(M(:,2)==1);
x3=Values(M(:,3)==1);
x4=Values(M(:,4)==1);
x5=Values(M(:,5)==1);
x6=Values(M(:,6)==1);
x7=Values(M(:,7)==1);
x8=Values(M(:,8)==1);

y1=Values(M(:,1)==0);
y2=Values(M(:,2)==0);
y3=Values(M(:,3)==0);
y4=Values(M(:,4)==0);
y5=Values(M(:,5)==0);
y6=Values(M(:,6)==0);
y7=Values(M(:,7)==0);
y8=Values(M(:,8)==0);



h=[]; p=[]; ci=zeros(8,2); stats=[];
[h(1),p(1),ci(1,:),stat] = ttest2(x1, y1, 'Tail','right'); stats(1)=stat.tstat;
[h(2),p(2),ci(2,:),stat] = ttest2(x2, y2, 'Tail','right'); stats(2)=stat.tstat;
[h(3),p(3),ci(3,:),stat] = ttest2(x3, y3, 'Tail','right'); stats(3)=stat.tstat;
[h(4),p(4),ci(4,:),stat] = ttest2(x4, y4, 'Tail','right'); stats(4)=stat.tstat;
[h(5),p(5),ci(5,:),stat] = ttest2(x5, y5, 'Tail','right'); stats(5)=stat.tstat;
[h(6),p(6),ci(6,:),stat] = ttest2(x6, y6, 'Tail','right'); stats(6)=stat.tstat;
[h(7),p(7),ci(7,:),stat] = ttest2(x7, y7, 'Tail','right'); stats(7)=stat.tstat;
[h(8),p(8),ci(8,:),stat] = ttest2(x8, y8, 'Tail','right'); stats(8)=stat.tstat;

Table3=[h',p']

%%%%%%%% TABLE 4 GENERATOR

X=M;
[num_obs, num_vars] = size(X);

if num_vars ~= 8
    error('La matriu ha de tenir exactament 8 columnes');
end

alpha = 0.01;  % nivell de significació

resultats = cell(num_vars, num_vars);

Table4=zeros(num_vars, num_vars);
for i = 1:num_vars-1
    for j = i+1:num_vars
        
        % Taula de contingència
        tabela = crosstab(X(:,i), X(:,j));
        E=sum(tabela,2) * sum(tabela,1) / sum(tabela(:));
        % Test Chi-quadrat
        [~, p, stats] = chi2gof( ...
            (1:numel(tabela))', ...
            'Ctrs', (1:numel(tabela))', ...
            'Frequency', tabela(:), ...
            'Expected', E(:) ...
        );

        % Resultat
        independents = p > alpha;

        % Guardar informació
        resultats{i,j} = struct( ...
            'Chi2', stats.chi2stat, ...
            'df', stats.df, ...
            'p_value', p, ...
            'independents', independents);
        Table4(i,j)=p;
    end
end

Table4