mma_ruido_branco

indices = [1,51,101,n_amostras-51];
qtd_urnas = 32;
%% Histogramas da resposta

for indice_atual = indices

    figure
    
    tempos_atuais = sprintf("(t_1,t_2)=(%.2f,%.2f)",tempo(indice_atual),tempo(indice_atual+1));
    respostas_deste_instante = realizacoes_respostas(:,[indice_atual,indice_atual+1]);

    histogram2(respostas_deste_instante(:,1),respostas_deste_instante(:,2),Normalization="pdf",FaceColor=meuVermelho,EdgeColor=meuPreto,NumBins=qtd_urnas*[1,1])

    xlim([-1.1,1.1])
    ylim([-1.1,1.1])

    set(gca,'fontsize',15)
    title(["Response Joint Distribution";"at $"+ tempos_atuais+"$ s"],FontSize=20,Interpreter="latex")
    xlabel("$x_1$ [m]",FontSize=20,Interpreter="latex")
    ylabel("$x_2$ [m]",FontSize=20,Interpreter="latex")

end