clear; clc;
set(0, 'defaultTextInterpreter', 'Tex');

%% CALIBRAÇÃO DO SENSOR DE PRESSÃO - Regressão Linear
mes = ...
[-2.49	-2.49	-2.48	-2.49
-2.39	-2.41	-2.40	-2.39
-2.26	-2.24	-2.23	-2.24
-2.09	-2.08	-2.06	-2.06
-1.90	-1.91	-1.91	-1.91
-1.78	-1.77	-1.75	-1.75
-1.63	-1.60	-1.59	-1.59
-1.43	-1.44	-1.41	-1.43
-1.29	-1.26	-1.23	-1.26
-1.12	-1.11	-1.09	-1.11
-0.96	-0.96	-0.93	-0.95
-0.78	-0.79	-0.79	-0.78
-0.60	-0.60	-0.61	-0.62
-0.46	-0.48	-0.47	-0.47
-0.31	-0.30	-0.31	-0.31
-0.15	-0.13	-0.14	-0.14
0.01	0.00	0.03	0.02
0.19	0.16	0.16	0.19
0.33	0.32	0.36	0.34
0.51	0.51	0.50	0.49
0.69	0.66	0.67	0.69
0.84	0.82	0.83	0.85
1.02	1.00	1.00	1.01
1.17	1.16	1.18	1.17
1.33	1.30	1.35	1.34
1.54	1.49	1.49	1.48
1.68	1.65	1.66	1.66
1.83	1.81	1.84	1.82];

Y = mean(mes, 2);
X = [0.00 5.57 12.89 20.22 27.54 34.87 42.19 49.52 56.84 64.17 71.49 ...
    78.82 86.14 93.47 100.79 108.12 115.44 122.77 130.09 137.42 144.74 ...
    152.07 159.39 166.72 174.05 181.37 188.70 196.02]';

lm = LinearModel.fit(X,Y)
lm.plot()
lm.anova()

title('')
xlabel('Pressão [mmHg]', 'FontSize', 12);
ylabel('Tensão Elétrica [V]', 'FontSize', 12);
legend('Dados', 'Regressão Linear', 'Location', 'NorthWest');

xlim([0,200]);
ylim([-2.5,2.5]);
set(gca,'XTick',(0:20:200), 'FontSize', 12);
set(gca,'YTick',(-2.5:0.5:2.5), 'FontSize', 12);

children = get(gca, 'children');
set(children(4),'Marker', '*')
delete(children(1));
grid on;

% Y = -2.5238 + 0.022112*X
b0 = 2.5238/0.022112
b1 = 1/0.022112

% OUTPUT
%
% 
% lm = 
% 
% 
% Linear regression model:
%     y ~ 1 + x1
% 
% Estimated Coefficients:
%                    Estimate    SE            tStat      pValue    
%     (Intercept)     -2.5238     0.0044076    -572.61    7.5895e-55
%     x1             0.022112    3.8753e-05     570.59    8.3192e-55
% 
% 
% Number of observations: 28, Error degrees of freedom: 26
% Root Mean Squared Error: 0.0121
% R-squared: 1,  Adjusted R-Squared 1
% F-statistic vs. constant model: 3.26e+05, p-value = 8.32e-55
% 
% ans = 
% 
%              SumSq        DF    MeanSq        F             pValue    
%     x1          47.765     1        47.765    3.2557e+05    8.3192e-55
%     Error    0.0038144    26    0.00014671                            
% 
% 
% b0 =
% 
%   114.1371
% 
% 
% b1 =
% 
%    45.2243

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