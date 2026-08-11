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
realizacoes_uniformes = 2*rand([1,tamanho_amostra])-1;

medias(n) = mean(realizacoes_uniformes);

end
%% Wasserstein

dist_Wass = zeros(1,qtd_tamanhos);

for n = 1:qtd_tamanhos

tamanho_amostra = tamanhos_amostra(n);
realizacoes_1 = 2*rand([1,tamanho_amostra])-1;
realizacoes_2 = 2*rand([1,tamanho_amostra])-1;

dist_Wass(n) = distanciasWasserstein([realizacoes_1;realizacoes_2],2);

end

%% Gráficos
figure

semilogx(tamanhos_amostra,medias,LineWidth=3)

title(["Sample Mean Values";"of a Uniform Variable"],FontSize=20)
xlabel("Sample Size",FontSize=20)
ylabel("Sample Mean",FontSize=20)

figure

semilogx(tamanhos_amostra,dist_Wass,LineWidth=3)

title(["Sample Wasserstein Distances";"between Uniform Variables"],FontSize=20)
xlabel("Sample Size",FontSize=20)
ylabel("Wasserstein Distance",FontSize=20)