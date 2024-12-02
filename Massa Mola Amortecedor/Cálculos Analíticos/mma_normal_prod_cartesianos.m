tic
mma_normal_configuracoes

tempo_inicial = 25;
tempo_final = 150;
qtd_instantes = 6;

instantes_analise = linspace(tempo_inicial,tempo_final,qtd_instantes);
qtd_urnas = round(sqrt(qtd_amostras)/2);
%%
%Produtos cartesianos para cada par de instantes

figura = figure;
figura.Position = [107,71,1695,891];

for i = 2:numel(instantes_analise)

    instante_atual = instantes_analise(i);

    instante_anterior = instantes_analise(i-1);

    respostas_inst_atual_ant = respostaAnalitica([instante_anterior,instante_atual],cond_iniciais, ...
    freq_ang_natural,freq_ang_amort,fator_amort,amplitude_forca_norm, ...
    freq_ang_forca);

    [histograma_inst_anterior,suporte_inst_anterior] = tabela_contagens(respostas_inst_atual_ant(:,1),qtd_urnas);
    [histograma_inst_atual,suporte_inst_atual] = tabela_contagens(respostas_inst_atual_ant(:,2),qtd_urnas);

    produtos_catesianos = histograma_inst_anterior'*histograma_inst_atual;

    subplot(2,3,i-1)

    bar3(produtos_catesianos)

    xticklabels(respostas_inst_atual_ant(:,1))
    yticklabels(respostas_inst_atual_ant(:,2))

    titulo = sprintf("Produtos cartesianos\ndos histogramas nos instantes\nt = %.0f s e t = %.0f s ",instante_anterior,instante_atual);
    legenda_x1 = sprintf("x_{%.0f}",instante_anterior);
    legenda_x2 = sprintf("x_{%.0f}",instante_atual);

    title(titulo,FontSize=15)
    xlabel(legenda_x1,FontSize=15)
    ylabel(legenda_x2,FontSize=15)

end
toc