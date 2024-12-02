tic
mma_normal_configuracoes

%%
%Curva teórica

Normal = @(x,mu,sigma) exp(-1/2*((x-mu)/sigma).^2)/(sigma*sqrt(2*pi));

varredura_amplitudes = linspace(min(amplitude_forca),max(amplitude_forca));
varredura_freq_ang = linspace(min(freq_ang_forca),max(freq_ang_forca));

normal_amplitudes = Normal(varredura_amplitudes,amplitude_forca_teorica(1),amplitude_forca_teorica(2));
normal_frequencias = Normal(varredura_freq_ang,freq_ang_forca_teorica(1),freq_ang_forca_teorica(2));
%%
%Histograma da força

qtd_urnas = round(sqrt(qtd_amostras));

figura = figure;
figura.Position = [453, 290, 1334, 506];


subplot(1,2,1)
hold on

gerarHistograma(amplitude_forca,qtd_urnas, ...
    ["Histograma Normalizado das";"Amplitudes da Força Externa"], ...
    "Força (N)", ...
    "Frequência Relativa")
plot(varredura_amplitudes,normal_amplitudes,LineWidth=3)

%%
%Histograma da frequência de forçamento

subplot(1,2,2)
hold on


gerarHistograma(freq_ang_forca,qtd_urnas, ...
    ["Histograma Normalizado";"das Frequências Angulares"], ...
    "Frequência Angular (rad/s)", ...
    "Frequência Relativa")

plot(varredura_freq_ang,normal_frequencias,LineWidth=3)
toc