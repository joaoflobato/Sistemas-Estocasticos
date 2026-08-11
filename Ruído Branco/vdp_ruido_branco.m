addpath("../Configurações Sistemas/","../Funções/")
vdp_configuracoes



potencia_ruido = 1; 




realizacoes_ruido_branco = sqrt(potencia_ruido)*randn(qtd_realizacoes,tamanho_realizacao);
realizacoes_respostas = zeros(qtd_realizacoes,tamanho_realizacao);


rng('default')      %Garante reprodutibilidade
for realizacao_atual = 1:qtd_realizacoes

    ruido_branco = realizacoes_ruido_branco(realizacao_atual,:);
    realizacoes_respostas(realizacao_atual,:) = resposta_vdp(tempo,ruido_branco,massa,alpha,rigidez,cond_iniciais);

end