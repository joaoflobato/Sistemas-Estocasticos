mma_normal_pos_processamento;

%%
%Histogramas ao longo do tempo
figura = figure;
figura.Position = [81,98,1767,864];

for i = 1:numel(instantes_analise)
    
    instante_atual = instantes_analise(i);
    indice_tempo_atual = tempos == instante_atual;
    posicoes_tempo_atual = respostas(indice_tempo_atual,:); 
    
    titulo = ["Histograma Normalizado";sprintf(["das Respostas em t = %.1f s"],instante_atual)];

    subplot(2,3,i)
    gerarHistograma(posicoes_tempo_atual,qtd_urnas, ...
    titulo, ...
    "Posição (m)", ...
    "Frequência Relativa")
    


end