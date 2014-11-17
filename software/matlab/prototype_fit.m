clear; clc;
set(0, 'defaultTextInterpreter', 'Tex');

%% CALIBRAÇÃO DO SENSOR DE PRESSÃO - Regressão Linear
mes = ...
[0.06	0.07	0.06	0.05
0.82	0.95	0.94	0.87
1.62	1.66	1.68	1.65
2.40	2.48	2.53	2.45
3.31	3.43	3.38	3.33
4.15	4.16	4.14	4.13
4.97	5.04	4.94	4.93
5.84	5.86	5.77	5.88
6.67	6.61	6.56	6.67
7.44	7.47	7.38	7.39
8.27	8.24	8.19	8.26
9.07	9.01	9.01	9.00
9.86	9.83	9.83	9.84];

Y = mean(mes, 2);
X = [0 20 40 60 80 100 120 140 160 180 200 220 240]';

lm = LinearModel.fit(X,Y)
lm.plot()
lm.anova()

title('')
xlabel('Pressão [mmHg]', 'FontSize', 12);
ylabel('Tensão Elétrica [V]', 'FontSize', 12);
legend('Dados', 'Regressão Linear', 'Location', 'NorthWest');

xlim([0,250]);
ylim([0,10.5]);
set(gca,'XTick',(0:20:240), 'FontSize', 12);
set(gca,'YTick',(0:1:10.5), 'FontSize', 12);

children = get(gca, 'children');
set(children(4),'Marker', '*')
delete(children(1));
grid on;

% Y = 0.060412 + 0.040867*X
b0 = -0.060412/0.040867
b1 = 1/0.040867

% OUTPUT
%
% lm = 
% 
% 
% Linear regression model:
%     y ~ 1 + x1
% 
% Estimated Coefficients:
%                    Estimate    SE            tStat     pValue    
%     (Intercept)    0.060412       0.01662     3.635     0.0039223
%     x1             0.040867    0.00011752    347.75    1.3962e-23
% 
% 
% Number of observations: 13, Error degrees of freedom: 11
% Root Mean Squared Error: 0.0317
% R-squared: 1,  Adjusted R-Squared 1
% F-statistic vs. constant model: 1.21e+05, p-value = 1.4e-23
% 
% ans = 
% 
%              SumSq       DF    MeanSq       F             pValue    
%     x1         121.58     1       121.58    1.2093e+05    1.3962e-23
%     Error    0.011059    11    0.0010054                            
% 
% 
% b0 =
% 
%    -1.4783
% 
% 
% b1 =
% 
%    24.4696

%% CALIBRAÇÃO DO SENSOR DE PRESSÃO - Resíduos

abs_residuals = abs(double(lm.Residuals(:,1)));

bar(X, abs_residuals)

xlabel('P [mmHg]', 'FontSize', 12);
ylabel('Dif [V]', 'FontSize', 12);

xlim([-10,250]);
set(gca,'XTick',(0:20:240), 'FontSize', 12);
grid on;

max_dif = max(abs_residuals)
span = max(Y)
lin_error_pct = max_dif/span*100

% OUTPUT
%
% max_dif =
% 
%     0.0557
% 
% 
% span =
% 
%     9.8400
% 
% 
% lin_error_pct =
% 
%     0.5665