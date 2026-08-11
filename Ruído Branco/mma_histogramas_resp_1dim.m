mma_ruido_branco

indices = [1,51,251,501,1001,n_amostras];
qtd_urnas = 32;
%% Histogramas da resposta

for indice_atual = indices

    figure
    
    tempo_atual = sprintf("t=%.0f",tempo(indice_atual));
    respostas_deste_instante = realizacoes_respostas(:,indice_atual);

    histogram(respostas_deste_instante,FaceColor=meuVermelho,EdgeColor=meuPreto,NumBins=qtd_urnas,Normalization="pdf")
    
    xlim([-1.1,1.1])
    set(gca,'fontsize',15)
    title("Response Distribution at $"+ tempo_atual+"$ s",FontSize=20,Interpreter="latex")
    xlabel("$x$ [m]",FontSize=20,Interpreter="latex")
end