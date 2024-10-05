mma_normal_pos_processamento;

%%
%Produtos cartesianos para cada par de instantes

figura = figure;
figura.Position = [107,71,1695,891];

for i = 2:numel(instantes_analise)

    instante_atual = instantes_analise(i);
    indice_tempo_atual = find(tempos == instante_atual);

    instante_anterior = instantes_analise(i-1);
    indice_tempo_anterior = find(tempos == instante_anterior);

    respostas_inst_anterior = respostas(indice_tempo_anterior,:);
    respostas_inst_atual = respostas(indice_tempo_atual,:);

    [histograma_inst_anterior,suporte_inst_anterior] = tabela_contagens(respostas_inst_anterior,qtd_urnas);
    [histograma_inst_atual,suporte_inst_atual] = tabela_contagens(respostas_inst_atual,qtd_urnas);

    produtos_catesianos = histograma_inst_anterior'*histograma_inst_atual;

    subplot(2,3,i-1)

    bar3(produtos_catesianos)

    xticklabels(respostas_inst_anterior)
    yticklabels(respostas_inst_atual)

    titulo = sprintf("Produtos cartesianos\ndos histogramas nos instantes\nt = %.0f s e t = %.0f s ",instante_anterior,instante_atual);
    legenda_x1 = sprintf("x_{%.0f}",instante_anterior);
    legenda_x2 = sprintf("x_{%.0f}",instante_atual);

    title(titulo,FontSize=15)
    xlabel(legenda_x1,FontSize=15)
    ylabel(legenda_x2,FontSize=15)

end