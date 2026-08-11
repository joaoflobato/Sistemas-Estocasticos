addpath("../Configurações Sistemas/","../Funções/")
mma_configuracoes


potencia = 1; % Potência do ruído (variância)


rng('default')      %Garante reprodutibilidade
% Geração do ruído branco
realizacoes_ruido_branco = sqrt(potencia) * randn(qtd_realizacoes, n_amostras);




%resposta_imp = 1/(massa*freq_amort)*exp(-fator_amort*freq_natural*tempo).*sin(freq_amort*tempo);

realizacoes_respostas = zeros(qtd_realizacoes,n_amostras);


for realizacao_atual = 1:qtd_realizacoes
    
    ruido_branco = realizacoes_ruido_branco(realizacao_atual,:);
    realizacoes_respostas(realizacao_atual,:) = resposta_mma(tempo,ruido_branco,massa,fator_amort,freq_natural);

end