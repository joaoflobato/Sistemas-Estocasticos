clc
clear all
close all

addpath("../Funções/")

tamanhos_amostra = [10,50,100,500,1000,5000,10000,50000,100000];
qtd_tamanhos = numel(tamanhos_amostra);

lambda = 2;
%% Médias

medias = zeros(1,qtd_tamanhos);

rng('default')      %Garante reprodutibilidade
for n = 1:qtd_tamanhos

tamanho_amostra = tamanhos_amostra(n);
realizacoes_uniformes = rand([1,tamanho_amostra]);
realizacoes_exp = -log(1-realizacoes_uniformes)/lambda;
medias(n) = mean(realizacoes_exp);

end
%% Wasserstein

dist_Wass = zeros(1,qtd_tamanhos);

for n = 1:qtd_tamanhos

tamanho_amostra = tamanhos_amostra(n);
uniformes_1 = rand([1,tamanho_amostra]);
uniformes_2 = rand([1,tamanho_amostra]);

exp_1 = -log(1-uniformes_1)/lambda;
exp_2 = -log(1-uniformes_2)/lambda;

dist_Wass(n) = distanciasWasserstein([exp_1;exp_2],2);

end

%% Gráficos
figure

semilogx(tamanhos_amostra,medias,LineWidth=3)

set(gca,'xscale','log','fontsize',15)
xlim([tamanhos_amostra(1),tamanhos_amostra(end)])
xticks(tamanhos_amostra(1:2:end))

title(["Sample Mean Values";"of an Exponential Variable"],FontSize=20)
xlabel("Sample Size",FontSize=20)
ylabel("Sample Mean",FontSize=20)

figure

loglog(tamanhos_amostra,dist_Wass,LineWidth=3)
xlim([tamanhos_amostra(1),tamanhos_amostra(end)])
xticks(tamanhos_amostra(1:2:end))

set(gca,'xscale','log','yscale','log','fontsize',15)

title(["Sample Wasserstein Distances";"between Exponential Variables"],FontSize=20)
xlabel("Sample Size",FontSize=20)
ylabel("Wasserstein Distance",FontSize=20)