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
tamanho_realizacao = fs*duracao+1;
qtd_realizacoes = 10^4;

massa = 1;
alpha = 0.5;
rigidez = 1;

cond_iniciais = [0;0];
tempo = 0:1/fs:duracao;
