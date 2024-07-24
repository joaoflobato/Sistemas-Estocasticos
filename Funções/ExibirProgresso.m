function ExibirProgresso(indice_atual,qtd_indices,subindice_atual,qtd_subindices)
    
    total_iteracoes = qtd_indices*qtd_subindices;
    iteracao_atual = (indice_atual-1)*qtd_subindices + subindice_atual;

    percentual = 100*iteracao_atual/total_iteracoes;
    clc
    fprintf("Progresso: \t %.2f %%\n",percentual)

end