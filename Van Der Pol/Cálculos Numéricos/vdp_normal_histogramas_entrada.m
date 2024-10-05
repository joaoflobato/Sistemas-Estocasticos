vdp_normal_pos_processamento;

%%
%Histograma da força

figura = figure;
figura.Position = [453, 290, 1334, 506];


subplot(1,2,1)
hold on

gerarHistograma(forcas_maximas_amostral,qtd_urnas, ...
    ["Histograma Normalizado das";"Amplitudes da Força Externa"], ...
    "Força (N)", ...
    "Frequência Relativa")
plot(varredura_amplitudes,normal_amplitudes,LineWidth=3)

%%
%Histograma da frequência de forçamento

subplot(1,2,2)
hold on


gerarHistograma(frequecia_forcas_amostral,qtd_urnas, ...
    ["Histograma Normalizado";"das Frequências"], ...
    "Frequência (Hz)", ...
    "Frequência Relativa")

plot(varredura_frequencias,normal_frequencias,LineWidth=3)