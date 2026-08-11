addpath("../Configurações Sistemas/","../Funções/")
mma_configuracoes


rng('default')      %Garante reprodutibilidade
% Geração do ruído branco


realizacoes_ruido_Wiener = repmat(sqrt(tempo),qtd_realizacoes,1).*randn(qtd_realizacoes,n_amostras);
realizacoes_respostas = zeros(qtd_realizacoes,n_amostras);

for realizacao_atual = 1:qtd_realizacoes
    
    ruido_Wiener = realizacoes_ruido_Wiener(realizacao_atual,:);
    realizacoes_respostas(realizacao_atual,:) = resposta_mma(tempo,ruido_Wiener,massa,fator_amort,freq_natural);

end