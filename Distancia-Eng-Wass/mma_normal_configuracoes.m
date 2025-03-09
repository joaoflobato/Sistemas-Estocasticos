clc
clear all
close all


addpath("../Funções")
%%
%Parâmetros do sistema
massa = 1;
const_amort = 0.1;
rigidez_mola = 1;

qtd_amostras = 3*10^5;

fator_amort = const_amort/(2*sqrt(massa*rigidez_mola));


media_teorica = 1;
desvio_padrao_teorico = 1/3;

amplitude_forca_teorica = [media_teorica ; desvio_padrao_teorico];
freq_ang_forca_teorica = amplitude_forca_teorica;

rng('default')      %Garante reprodutibilidade

amplitude_forca = random("Normal",amplitude_forca_teorica(1),amplitude_forca_teorica(2),[qtd_amostras,1]);
amplitude_forca_norm = amplitude_forca / massa;
freq_ang_forca = random("Normal",freq_ang_forca_teorica(1),freq_ang_forca_teorica(2),[qtd_amostras,1]);

forcamento = @(t) amplitude_forca .* cos(freq_ang_forca.*t);

freq_ang_natural = sqrt(rigidez_mola/massa);
freq_ang_amort = freq_ang_natural*sqrt(1-fator_amort^2);
razao_freqs = freq_ang_forca/freq_ang_natural;


cond_iniciais = [0;0];