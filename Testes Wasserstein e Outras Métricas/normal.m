clc
clear all
close all

addpath("../Funções/")

tamanhos_amostra = [10,50,100,500,1000,5000,10000,50000,100000];
qtd_tamanhos = numel(tamanhos_amostra);

%% Médias

medias = zeros(1,qtd_tamanhos);

rng('default')      %Garante reprodutibilidade
for n = 1:qtd_tamanhos

tamanho_amostra = tamanhos_amostra(n);
realizacoes_normais = randn([1,tamanho_amostra]);

medias(n) = mean(realizacoes_normais);

end
%% Wasserstein

dist_Wass = zeros(1,qtd_tamanhos);

for n = 1:qtd_tamanhos

tamanho_amostra = tamanhos_amostra(n);
realizacoes_1 = randn([1,tamanho_amostra]);
realizacoes_2 = randn([1,tamanho_amostra]);

dist_Wass(n) = distanciasWasserstein([realizacoes_1;realizacoes_2],2);

end

%% Gráficos
figure

semilogx(tamanhos_amostra,medias,LineWidth=3)

set(gca,'xscale','log','fontsize',15)
xlim([tamanhos_amostra(1),tamanhos_amostra(end)])
xticks(tamanhos_amostra(1:2:end))

title(["Sample Mean Values";"of a Normal Variable"],FontSize=20)
xlabel("Sample Size",FontSize=20)
ylabel("Sample Mean",FontSize=20)

figure

loglog(tamanhos_amostra,dist_Wass,LineWidth=3)

set(gca,'xscale','log','yscale','log','fontsize',15)
xlim([tamanhos_amostra(1),tamanhos_amostra(end)])
xticks(tamanhos_amostra(1:2:end))

title(["Sample Wasserstein Distances";"between Normal Variables"],FontSize=20)
xlabel("Sample Size",FontSize=20)
ylabel("Wasserstein Distance",FontSize=20)