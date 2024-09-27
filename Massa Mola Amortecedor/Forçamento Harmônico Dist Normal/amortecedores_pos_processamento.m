clc
clear all
close all

addpath("../../Classes","../../Funções/")

load("Variáveis/amortecedores.mat");


fatores_amort = amortecedores/amortecimento_crit;
legendas_amort = "\zeta = "+fatores_amort;

margem_convergencia = 0.045;

figura = figure;
figura.Position = [198 236 1610 577];

tempo_conv_medias = zeros(1,qtd_amortecedores);
tempo_conv_dp = zeros(1,qtd_amortecedores);

for i = 1:qtd_amortecedores
    media_deste_amort = mean(respostas_diferentes_amort(:,:,i),2);
    media_deste_amort_norm = media_deste_amort/max(abs(media_deste_amort));

    posicoes_fora_conv = find(abs(media_deste_amort) > margem_convergencia);
    tempo_conv_medias(i) = tempos(posicoes_fora_conv(end));



    desv_pad_deste_amort = std(respostas_diferentes_amort(:,:,i),0,2);
    desv_pad_deste_amort_norm = desv_pad_deste_amort/max(desv_pad_deste_amort);

    posicoes_fora_conv = find(abs(desv_pad_deste_amort_norm-1) > margem_convergencia);
    tempo_conv_dp(i) = tempos(posicoes_fora_conv(end));
%%
%Gráfico da média
subplot(1,2,1)

hold on
plot(tempos,media_deste_amort_norm,LineWidth=3)
%%
%Gráfico do desvio padrão

subplot(1,2,2)

hold on
plot(tempos,desv_pad_deste_amort_norm,LineWidth=3)
end
%%
%Gráfico da média
subplot(1,2,1)

xlim([0,35])
ylim([-1,1])

title(["Média Normalizada";"das Posições"],FontSize=20)

xlabel("Tempo (s)",FontSize=15)
ylabel("\mu_x / |\mu_{x_{max}}|",FontSize=15)

legend(legendas_amort)

%%
%Gráfico do desvio padrão

subplot(1,2,2)

xlim([0,35])
ylim([0,1])

title(["Desvio Padrão";"Normalizado das Posições"],FontSize=20)

xlabel("Tempo (s)",FontSize=15)
ylabel("\sigma_x / \sigma_{x_{max}}",FontSize=15)

legend(legendas_amort,Location="southeast")