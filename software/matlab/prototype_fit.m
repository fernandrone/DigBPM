clear; clc;

%% CALIBRAÇÃO DO SENSOR DE PRESSÃO

mes = ...
[0.02	0.03	0.01	0.02
0.87	0.91	0.90    0.89
1.70	1.72	1.70	1.72
2.48	2.55	2.53	2.57
3.37	3.36	3.39	3.40
4.20	4.21	4.21	4.21
5.06	5.07	5.07	5.05
5.92	5.95	5.92	5.92
6.68	6.75	6.70	6.72
7.58	7.58	7.57	7.59
8.37	8.43	8.40	8.41
9.20	9.20    9.22	9.17
10.02	10.02	10.01	10.03];

Y = mean(mes, 2);
X = [0 20 40 60 80 100 120 140 160 180 200 220 240]';

lm = LinearModel.fit(X,Y)
lm.plot()
lm.anova()

title('Função de transferência (V x P)')
xlabel('P [mmHg]', 'FontSize', 12);
ylabel('V [V]', 'FontSize', 12);
legend('Dados', 'Regressão Linear', 'Location', 'NorthWest');

xlim([0,250]);
ylim([0,10.5]);
set(gca,'XTick',(0:20:240), 'FontSize', 12);
set(gca,'YTick',(0:1:10.5), 'FontSize', 12);

children = get(gca, 'children');
set(children(4),'Marker', '*')
delete(children(1));
grid on;

% Y = 0.044478 + 0.041709*X
b0 = -0.044478/0.041709
b1 = 1/0.041709