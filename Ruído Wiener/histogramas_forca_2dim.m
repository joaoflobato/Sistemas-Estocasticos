mma_ruido_Wiener

indices = [1,51,101,n_amostras-1];
qtd_urnas = 32;
%% Histogramas do forçamento

for indice_atual = indices

    figure
    
    tempos_atuais = sprintf("(t_1,t_2)=%.2f,%.2f",tempo(indice_atual),tempo(indice_atual+1));
    forcas_deste_instante = realizacoes_ruido_Wiener(:,[indice_atual,indice_atual+1]);

    %histogram(forcas_deste_instante,FaceColor=meuVermelho,NumBins=qtd_urnas,Normalization="pdf")
    histogram2(forcas_deste_instante(:,1),forcas_deste_instante(:,2),Normalization="pdf",FaceColor=meuVermelho,EdgeColor=meuPreto,NumBins=qtd_urnas*[1,1])

    set(gca,'fontsize',15)
    title(["Force Distribution at";"$"+ tempos_atuais+"$ s"],FontSize=20,Interpreter="latex")
    xlabel("$f_1$ (N)",FontSize=20,Interpreter="latex")
    ylabel("$f_2$ (N)",FontSize=20,Interpreter="latex")
end