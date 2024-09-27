vdp_normal_pos_processamento;

%%
%Histogramas bivariados para cada par de instantes
figura = figure;
figura.Position = [110,62,1717,900];

for i = 2:numel(instantes_analise)

    instante_atual = instantes_analise(i);
    indice_tempo_atual = find(tempos == instante_atual);

    instante_anterior = instantes_analise(i-1);
    indice_tempo_anterior = find(tempos == instante_anterior);

    respostas_inst_atual_ant = respostas([indice_tempo_anterior,indice_tempo_atual],:)';

    subplot(2,3,i-1)

    titulo = sprintf("Histograma normalizado \nconjunto nos instantes\nt = %.0f s e t = %.0f s",instante_anterior,instante_atual);
    legenda_x1 = sprintf("x_{%.0f}",instante_anterior);
    legenda_x2 = sprintf("x_{%.0f}",instante_atual);


    gerarHistograma(respostas_inst_atual_ant,qtd_urnas, ...
        titulo, ...
        legenda_x1, ...
        legenda_x2)
end