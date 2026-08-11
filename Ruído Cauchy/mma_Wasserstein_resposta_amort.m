clc
clear all
close all
%% Cores

meuVerde = [9,133,66]/255;
meuVermelho = [195, 40, 30]/255;
meuPreto = [7, 3, 8]/255;
meuAzul = [51, 51, 179]/255;
meuRoxo = [150,30,119]/255;
meuLaranja = [243,156,18]/255;

minhasCores = [meuVermelho;meuPreto;meuAzul;meuVerde;meuLaranja;meuRoxo];

%% Ruído

addpath("../Funções/")

fs = 50;
duracao = 51;
n_amostras = fs*duracao;
qtd_realizacoes = 4*10^4;

massa = 1;
const_mola = 1;

freq_natural = sqrt(const_mola/massa);
amplitude_forca_norm = 1/massa;
freq_ang_forca = 1;


potencia = 1; % Potência do ruído (variância)


rng('default')      %Garante reprodutibilidade

realizacoes_va_uniforme = rand(qtd_realizacoes, n_amostras);
realizacoes_ruido_cauchy = tan(pi*(realizacoes_va_uniforme-1/2));
tempo = linspace(0,duracao,n_amostras);
%% Distancias de Wasserstein


dimensoes = 1:4;
ordem = 2;
intervalo = 1;
duracao_efetiva = duracao - intervalo;
indices_intervalo = intervalo*fs;
instantes = 0:intervalo:duracao_efetiva-intervalo;

for fator_amort = [0.01,0.2,1,5]
figure
legenda_amort = sprintf("%.2f",fator_amort);


if fator_amort < 1
    freq_amort = freq_natural*sqrt(1-fator_amort^2);
    resposta_imp = 1/(massa*freq_amort)*exp(-fator_amort*freq_natural*tempo).*sin(freq_amort*tempo);
elseif fator_amort == 1
    resposta_imp = tempo/massa.*exp(-fator_amort*freq_natural*tempo);
else
    const_lambda = freq_natural*sqrt(fator_amort^2-1);
    resposta_imp = 1/(2*massa*const_lambda)*exp(-fator_amort*freq_natural*tempo).*(exp(const_lambda*tempo)-exp(-const_lambda*tempo));
end


realizacoes_respostas = zeros(qtd_realizacoes,n_amostras);
for realizacao_atual = 1:qtd_realizacoes
    
    ruido_cauchy = realizacoes_ruido_cauchy(realizacao_atual,:);
    x2 = conv(ruido_cauchy,resposta_imp)/fs;
    x2_truncado = x2(1:n_amostras);

    realizacoes_respostas(realizacao_atual,:) = x2_truncado;

end

for m = dimensoes

W = zeros(1,duracao_efetiva);
indice_wass = 1;


for instante_atual = instantes
    
    if m == 1
        indices1 = instante_atual*fs+1;
    else
        indices1 = (instante_atual*fs+1)*ones(1,m) + [0:m-1];
    end

    indices2 = indices1 + indices_intervalo-1;

    respostas1 = realizacoes_respostas(:,indices1);
    respostas2 = realizacoes_respostas(:,indices2);

     W(indice_wass) = wasserstein_distance_nd(respostas1',respostas2',ordem);
     indice_wass = 1 + indice_wass;

end

hold on


W = W*(1+m*10^-2);
colororder(minhasCores)
semilogy(instantes,W+m*min(W),LineWidth=3)

end

set(gca,'fontsize',15)

 ylim([0,1.5*max(W)])

title(["Wasserstein Distances between $\mathbf{x}$";"Sections' Distributions for";"$\Delta t = 1$ s and $\zeta="+legenda_amort+"$"],FontSize=20,Interpreter="latex")
xlabel("$t_1$ [s]",FontSize=20,Interpreter="latex")
ylabel("$\hat{\mathcal{W}}_{2,m}(\mathbf{x}_1,\mathbf{x}_2)$",FontSize=20,Interpreter="latex")
end