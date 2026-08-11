clc
clear all
close all

addpath("../Funções/")

fs = 50;
duracao = 31;
n_amostras = fs*duracao;
qtd_realizacoes = 4*10^4;

massa = 1;
const_amort = 0.1;
const_mola = 1;

freq_natural = sqrt(const_mola/massa);
fator_amort = const_amort/(2*sqrt(massa*const_mola));
freq_amort = freq_natural*sqrt(1-fator_amort^2);

amplitude_forca_norm = 1/massa;
freq_ang_forca = 1;



rng('default')      %Garante reprodutibilidade
% Geração do ruído branco
realizacoes_va_uniforme = rand(qtd_realizacoes, n_amostras);
realizacoes_ruido_cauchy = tan(pi*(realizacoes_va_uniforme-1/2));

tempo = linspace(0,duracao,n_amostras);


resposta_imp = 1/(massa*freq_amort)*exp(-fator_amort*freq_natural*tempo).*sin(freq_amort*tempo);

realizacoes_respostas = zeros(qtd_realizacoes,n_amostras);


for realizacao_atual = 1:qtd_realizacoes
    
    ruido_branco = realizacoes_ruido_cauchy(realizacao_atual,:);
    x2 = conv(ruido_branco,resposta_imp)/fs;
    x2_truncado = x2(1:n_amostras);

    realizacoes_respostas(realizacao_atual,:) = x2_truncado;

end
