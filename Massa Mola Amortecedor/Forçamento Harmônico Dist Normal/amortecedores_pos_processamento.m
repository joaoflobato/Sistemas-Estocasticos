clc
clear all
close all

addpath("../../Classes","../../Funções/")

load("Variáveis/amortecedores.mat");

qtd_amortecedores = numel(amortecedores);

fatores_amort = amortecedores/amortecimento_crit;
legendas_amort = "\zeta = "+fatores_amort;

margem_convergencia = 0.045;

figura = figure;
figura.Position = [195,95,1600,871];

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
subplot(2,3,1)

hold on
plot(tempos,media_deste_amort_norm,LineWidth=3)
%%
%Gráfico do desvio padrão

subplot(2,3,2)

hold on
plot(tempos,desv_pad_deste_amort_norm,LineWidth=3)
%%
%Gráfico das distâncias de Wasserstein
subplot(2,3,3)

passo = 0.02;
total_passos = (tempos(end) - tempos(1))/passo + 1;
indices_analise = 1:1000:total_passos;

ordem_Wassertein = 2;
dists_W = distanciasWasserstein(respostas_diferentes_amort(indices_analise,:,i),ordem_Wassertein);
dists_W_norm = dists_W/max(dists_W);

hold on
plot(tempos(indices_analise(2:end)),dists_W_norm,LineWidth=3);
end
%%
%Gráfico da média
subplot(2,3,1)

xlim([0,35])
ylim([-1,1])

title(["Média Normalizada";"das Posições"],FontSize=20)

xlabel("Tempo (s)",FontSize=15)
ylabel("\mu_x / |\mu_{x_{max}}|",FontSize=15)

legend(legendas_amort)

%%
%Gráfico do desvio padrão

subplot(2,3,2)

xlim([0,35])
ylim([0,1])

title(["Desvio Padrão";"Normalizado das Posições"],FontSize=20)

xlabel("Tempo (s)",FontSize=15)
ylabel("\sigma_x / \sigma_{x_{max}}",FontSize=15)

legend(legendas_amort,Location="southeast")

%%
%Gráfico do tempo de convergência das médias

subplot(2,3,4)

loglog(fatores_amort,tempo_conv_medias,LineWidth=2)

title(["Tempo de Convergência";"das Médias"],FontSize=20)

xlabel("Fator de Amortecimento (\zeta)",FontSize=15)
ylabel(["Tempo de";"Convergência"],FontSize=15)
%%
%Gráfico do tempo de convergência das desvios padrões

subplot(2,3,5)

loglog(fatores_amort,tempo_conv_dp,LineWidth=2)

title(["Tempo de Convergência";"dos Desvios Padrões"],FontSize=20)

xlabel("Fator de Amortecimento (\zeta)",FontSize=15)
ylabel(["Tempo de";"Convergência"],FontSize=15)
%%
%Gráfico das distâncias de Wasserstein

subplot(2,3,3)
set(gca,'yscale','log')
yticks(2.^([-5:0]))

title(["Distâncias de";"Wasserstein Normalizadas"],FontSize=20)

xlabel("Tempo (s)",FontSize=15)
ylabel("W/W_{max}",FontSize=15)

legend(legendas_amort)