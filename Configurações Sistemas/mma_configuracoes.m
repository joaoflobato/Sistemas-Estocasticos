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
%%
fs = 50;
duracao = 31;
n_amostras = fs*duracao+1;

tempo = 0:1/fs:duracao;

qtd_realizacoes = 10^5;

massa = 1;
const_amort = 0.1;
const_mola = 1;

freq_natural = sqrt(const_mola/massa);
fator_amort = const_amort/(2*sqrt(massa*const_mola));
freq_amort = freq_natural*sqrt(1-fator_amort^2);
