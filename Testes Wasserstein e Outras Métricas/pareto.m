clc
clear all
close all

addpath("../Funções/")

xm = 1;

alphas = 1:5;
qtd_alphas = numel(alphas);

tamanhos_amostra = [10,50,100,500,1000,5000,10000,50000,100000];
qtd_tamanhos = numel(tamanhos_amostra);

medias = zeros(qtd_alphas,qtd_tamanhos);
dist_Wass = zeros(qtd_alphas,qtd_tamanhos);

rng('default')      %Garante reprodutibilidade
for i = 1:qtd_alphas

alpha = alphas(i);

%% Médias

for n = 1:qtd_tamanhos

tamanho_amostra = tamanhos_amostra(n);
realizacoes_uniformes = rand([1,tamanho_amostra]);
realizacoes_pareto = xm ./ (1 - realizacoes_uniformes).^(1/alpha);

medias(i,n) = mean(realizacoes_pareto);

end
%% Wasserstein


for n = 1:qtd_tamanhos

tamanho_amostra = tamanhos_amostra(n);
uniformes_1 = rand([1,tamanho_amostra]);
uniformes_2 = rand([1,tamanho_amostra]);

pareto_1 = xm ./ (1 - uniformes_1).^(1/alpha);
pareto_2 = xm ./ (1 - uniformes_2).^(1/alpha);

dist_Wass(i,n) = distanciasWasserstein([pareto_1;pareto_2],2);

end
end
%% Gráficos
figure

semilogx(tamanhos_amostra,medias,LineWidth=3)

set(gca,'xscale','log','fontsize',15)
xlim([tamanhos_amostra(1),tamanhos_amostra(end)])
xticks(tamanhos_amostra(1:2:end))

title(["Sample Mean Values";"of a Pareto Variable"],FontSize=20)
xlabel("Sample Size",FontSize=20)
ylabel("Sample Mean",FontSize=20)

legend(["$\alpha = $"+alphas],Interpreter="latex",FontSize=20,Orientation="horizontal")

figure

hold on
loglog(tamanhos_amostra,dist_Wass,LineWidth=3)

set(gca,'xscale','log','yscale','log','fontsize',15)
xlim([tamanhos_amostra(1),tamanhos_amostra(end)])
xticks(tamanhos_amostra(1:2:end))

title(["Sample Wasserstein Distances";"between Pareto Variables"],FontSize=20)
xlabel("Sample Size",FontSize=20)
ylabel("Wasserstein Distance",FontSize=20)

legend(["$\alpha = $"+alphas],Interpreter="latex",FontSize=20,Orientation="horizontal")