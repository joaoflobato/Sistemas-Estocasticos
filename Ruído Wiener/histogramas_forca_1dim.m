mma_ruido_Wiener

indices = [1,51,251,501,1001,n_amostras];
qtd_urnas = 32;
%% Histogramas do forçamento

for indice_atual = indices

    figure
    
    tempo_atual = sprintf("t=%.0f",tempo(indice_atual));
    forcas_deste_instante = realizacoes_ruido_Wiener(:,indice_atual);

    histogram(forcas_deste_instante,FaceColor=meuVermelho,EdgeColor=meuPreto,NumBins=qtd_urnas,Normalization="pdf")

    set(gca,'fontsize',15)
    title("Force Distribution at $"+ tempo_atual+"$ s",FontSize=20,Interpreter="latex")
    xlabel("Force (N)",FontSize=20)
end