mma_normal_configuracoes

tempo_inicial = 25;
tempo_final = 150;
qtd_instantes = 6;

instantes_analise = linspace(tempo_inicial,tempo_final,qtd_instantes);
qtd_urnas = round(sqrt(qtd_amostras));
%%
%Histogramas ao longo do tempo
figura = figure;
figura.Position = [81,98,1767,864];

for i = 1:qtd_instantes
    
    instante_atual = instantes_analise(i);
    posicoes_tempo_atual = respostaAnalitica(instante_atual,cond_iniciais,freq_ang_natural, ...
        freq_ang_amort,fator_amort,amplitude_forca_norm,freq_ang_forca)';
    
    titulo = ["Histograma Normalizado";sprintf(["das Respostas em t = %.0f s"],instante_atual)];

    subplot(2,3,i)
    gerarHistograma(posicoes_tempo_atual,qtd_urnas, ...
    titulo, ...
    "Posição (m)", ...
    "Frequência Relativa")
    


end