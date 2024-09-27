clc
clear all
close all

addpath("../../Classes","../../Funções/")
%%
%Pós Processamento

load("Variáveis/variaveis vdp normal.mat");
instantes_analise = tempo_inicial + (tempo_final-tempo_inicial)/6 : (tempo_final-tempo_inicial)/6 : tempo_final;

%%
%Funções Comparativas

Normal = @(x,mu,sigma) exp(-1/2*((x-mu)/sigma).^2)/(sigma*sqrt(2*pi));

%%
%Estatísticas

media_posicoes = mean(respostas,2);
desvio_padrao_posicoes = std(respostas,0,2);



media_forcamentos = mean(forcamentos',2);
desvio_padrao_forcamentos = std(forcamentos',0,2);


varredura_amplitudes = linspace(min(forcas_maximas_amostral),max(forcas_maximas_amostral));
varredura_frequencias = linspace(min(frequecia_forcas_amostral),max(frequecia_forcas_amostral));

normal_amplitudes = Normal(varredura_amplitudes,media_teorica,desvio_padrao_teorico);
normal_frequencias = Normal(varredura_frequencias,frequencia_forca_teorica(1),frequencia_forca_teorica(2));

qtd_urnas = round(sqrt(contagem_amostras));