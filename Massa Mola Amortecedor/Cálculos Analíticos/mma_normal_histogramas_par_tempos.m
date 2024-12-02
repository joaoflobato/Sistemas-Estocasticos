tic
mma_normal_configuracoes

tempo_inicial = 25;
tempo_final = 150;
qtd_instantes = 6;

instantes_analise = linspace(tempo_inicial,tempo_final,qtd_instantes);
qtd_urnas = round(sqrt(qtd_amostras)/2*ones(1,2));
%%
%Histogramas bivariados para cada par de instantes
figura = figure;
figura.Position = [110,62,1717,900];

for i = 2:numel(instantes_analise)

    instante_atual = instantes_analise(i);

    instante_anterior = instantes_analise(i-1);

    respostas_inst_atual_ant = respostaAnalitica([instante_anterior,instante_atual],cond_iniciais, ...
    freq_ang_natural,freq_ang_amort,fator_amort,amplitude_forca_norm, ...
    freq_ang_forca);

    subplot(2,3,i-1)

    titulo = sprintf("Histograma normalizado \nconjunto nos instantes\nt = %.0f s e t = %.0f s",instante_anterior,instante_atual);
    legenda_x1 = sprintf("x_{%.0f}",instante_anterior);
    legenda_x2 = sprintf("x_{%.0f}",instante_atual);


    gerarHistograma(respostas_inst_atual_ant,qtd_urnas, ...
        titulo, ...
        legenda_x1, ...
        legenda_x2)
end
toc