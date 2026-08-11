clc
clear all
close all

addpath("../Funções/")
%% Cores

meuVerde = [0,176,80]/255;
meuVermelho = [195, 40, 30]/255;
meuPreto = [7, 3, 8]/255;
meuAzul = [51, 51, 179]/255;
meuRoxo = [112,48,160]/255;
meuLaranja = [243,156,18]/255;

minhasCores = [meuVermelho;meuPreto;meuAzul;meuVerde;meuLaranja;meuRoxo];
%%


qtd_urnas = 50;
n_r = 10^5;
m = 1;
media = 0;
desvio_pad = 1;

pdf_normal = @(x) exp(-(x-media).^2/(2*desvio_pad^2))/sqrt(2*pi*desvio_pad);
amostra = media+desvio_pad*randn(m,n_r);

mins_amostra = min(amostra,[],2);
maxs_amostra = max(amostra,[],2);



[alturas_norm,pos_med] = gerarPDF(amostra,qtd_urnas,mins_amostra,maxs_amostra,m);

for indice_dimensao = 1:m
    
    altura_exata = pdf_normal(pos_med);

end

hold on
bar(pos_med,alturas_norm,FaceColor=meuVermelho)
plot(pos_med,altura_exata,LineWidth=3,Color=meuPreto)