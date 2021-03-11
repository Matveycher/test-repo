%% Изучение красного смещения звезд

close all
clear variables
%% Импорт данных

spectra = importdata("spectra.csv")
lambdaStart = importdata("lambda_start.csv")
lambdaDelta = importdata("lambda_delta.csv")
starNames = importdata('star_names.csv')
%% Константы

lambdaPredicted = 656.28 %нм
speedOfLight = 299792.458 %км/с
%% Определение диапазона длин волн

nObs = size(spectra, 1)
nStars = size(starNames, 1)
lambdaEnd = lambdaStart+(nObs -1)*lambdaDelta
lambda =(lambdaStart : lambdaDelta : lambdaEnd)'
%% Расчёт скорости удаления звезды от Земли

s = spectra(:,6)
[sHa, idx] = min(s)
lambdaHa = lambda(idx)

z = (lambdaHa / lambdaPredicted)-1
speed = z * speedOfLight
%% Построение графика

fg1 = figure
plot(lambda, s, "b--o", 'MarkerIndices',1:5:length(s), 'MarkerSize',2,"Color",[0.2 0.8 0.7])
set(gcf, 'visible', 'on')
xlabel('Длина волны, нм')
ylabel(['Интенсивность, эрг/см^2/с/',char(197)])
title({'Спектр звезды HD94028', 'в созвездии льва'})
legend('I(\lambda)')
text(lambdaEnd - 20, max(s)*0,8, ['Cкорость =', num2str(speed), 'км/с'])
grid on
hold on
plot(lambdaHa, sHa, 'rs', 'MarkerSize',8)
legend('I(\lambda)','Бальмер-альфа', 'Location', 'southwest')
text(lambdaEnd - 20, max(s)*0,8, ['Cкорость =', num2str(speed), 'км/с'])
hold off
%% Сохранение графика

 saveas(fg1,'spectraHD94028.png')