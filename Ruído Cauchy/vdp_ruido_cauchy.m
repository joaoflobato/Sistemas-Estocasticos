clc
clear all
close all


addpath("../Funções/")

fs = 50;
duracao = 31;
tamanho_realizacao = fs*duracao+1;
qtd_realizacoes = 10^4;

massa = 1;
alpha = 0.5;
rigidez = 1;

cond_iniciais = [0;0];
tempo = 0:1/fs:duracao;

potencia_ruido = 1; 



realizacoes_va_uniforme = rand(qtd_realizacoes, tamanho_realizacao);
realizacoes_ruido_cauchy = tan(pi*(realizacoes_va_uniforme-1/2));
realizacoes_respostas = zeros(qtd_realizacoes,tamanho_realizacao);


rng('default')      %Garante reprodutibilidade
for realizacao_atual = 1:qtd_realizacoes

    forca = @(t) realizacoes_ruido_cauchy(realizacao_atual,round(fs*t+1));

    funcao_acel = @(t,vetor_x) [vetor_x(2);1/massa*(forca(t)+alpha*(1-vetor_x(1)^2)*vetor_x(2)-rigidez*vetor_x(1))];
    [~,X] = ode45(funcao_acel,tempo,cond_iniciais);

    realizacoes_respostas(realizacao_atual,:) = X(:,1)';

end