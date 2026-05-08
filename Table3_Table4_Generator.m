clc
clear all
close all
load('Table2.txt');
load('Table1.txt');
M=Table2;
Values=Table1;

% Person coeficient:
v=1

x1=Values(M(:,1)==1,v); %mean(x1)
x2=Values(M(:,2)==1,v);
x3=Values(M(:,3)==1,v);
x4=Values(M(:,4)==1,v);
x5=Values(M(:,5)==1,v);
x6=Values(M(:,6)==1,v);
x7=Values(M(:,7)==1,v);
x8=Values(M(:,8)==1,v);

y1=Values(M(:,1)==0,v); %mean(y1)
y2=Values(M(:,2)==0,v);
y3=Values(M(:,3)==0,v);
y4=Values(M(:,4)==0,v);
y5=Values(M(:,5)==0,v);
y6=Values(M(:,6)==0,v);
y7=Values(M(:,7)==0,v);
y8=Values(M(:,8)==0,v);

size_x(1)=size(x1,1);
size_y(1)=size(y1,1);
size_x(2)=size(x2,1);
size_y(2)=size(y2,1);
size_x(3)=size(x3,1);
size_y(3)=size(y3,1);
size_x(4)=size(x4,1);
size_y(4)=size(y4,1);
size_x(5)=size(x5,1);
size_y(5)=size(y5,1);
size_x(6)=size(x6,1);
size_y(6)=size(y6,1);
size_x(7)=size(x7,1);
size_y(7)=size(y7,1);
size_x(8)=size(x8,1);
size_y(8)=size(y8,1);

%%%%%%%% SIZE OF THE SAMPLES
size_x
size_y


%%%%%%%% 16 HISTOGRAM GENERATOR

histogram(x1)
title('Pearson coefficient. DG=1')
saveas(gcf,'Pc_DG1.png')

figure
histogram(y1)
title('Pearson coefficient. DG=0')
saveas(gcf,'Pc_DG0.png')

figure
histogram(x2)
title('Pearson coefficient. PrG=1')
saveas(gcf,'Pc_PrG1.png')

figure
histogram(y2)
title('Pearson coefficient. PrG=0')
saveas(gcf,'Pc_PrG0.png')

figure
histogram(x3)
title('Pearson coefficient. PoI=1')
saveas(gcf,'Pc_PoI1.png')

figure
histogram(y3)
title('Pearson coefficient. PoI=0')
saveas(gcf,'Pc_PoI0.png')

figure
histogram(x4)
title('Pearson coefficient. PrI=1')
saveas(gcf,'Pc_PrI1.png')

figure
histogram(y4)
title('Pearson coefficient. PrI=0')
saveas(gcf,'Pc_PrI0.png')

figure
histogram(x5)
title('Pearson coefficient. II=1')
saveas(gcf,'Pc_II1.png')

figure
histogram(y5)
title('Pearson coefficient. II=0')
saveas(gcf,'Pc_II0.png')

figure
histogram(x6)
title('Pearson coefficient. A3D=1')
saveas(gcf,'Pc_A3D1.png')

figure
histogram(y6)
title('Pearson coefficient. A3D=0')
saveas(gcf,'Pc_A3D0.png')

figure
histogram(x7)
title('Pearson coefficient. D3D=1')
saveas(gcf,'Pc_D3D1.png')

figure
histogram(y7)
title('Pearson coefficient. D3D=0')
saveas(gcf,'Pc_D3D0.png')

figure
histogram(x8)
title('Pearson coefficient. BT=1')
saveas(gcf,'Pc_BT1.png')

figure
histogram(y8)
title('Pearson coefficient. BT=0')
saveas(gcf,'Pc_BT0.png')


%%%%%%%% TABLE 4 GENERATOR

h=[]; p=[]; ci=zeros(8,2); stats=[];
[h(1),p(1),ci(1,:),~] = ttest2(x1, y1, 'Tail','right'); 
[h(2),p(2),ci(2,:),~] = ttest2(x2, y2, 'Tail','right'); 
[h(3),p(3),ci(3,:),~] = ttest2(x3, y3, 'Tail','right'); 
[h(4),p(4),ci(4,:),~] = ttest2(x4, y4, 'Tail','right'); 
[h(5),p(5),ci(5,:),~] = ttest2(x5, y5, 'Tail','right'); 
[h(6),p(6),ci(6,:),~] = ttest2(x6, y6, 'Tail','right'); 
[h(7),p(7),ci(7,:),~] = ttest2(x7, y7, 'Tail','right'); 
[h(8),p(8),ci(8,:),~] = ttest2(x8, y8, 'Tail','right'); 

Table3=[h',p']

%%%%%%%% TABLE 5 GENERATOR

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