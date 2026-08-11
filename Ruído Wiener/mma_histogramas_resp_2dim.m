mma_ruido_Wiener

indices = [1,51,101,n_amostras-51];
qtd_urnas = 32;
%% Cores

meuVerde = [9,133,66]/255;
meuVermelho = [195, 40, 30]/255;
meuPreto = [7, 3, 8]/255;
meuAzul = [51, 51, 179]/255;
meuRoxo = [150,30,119]/255;
meuLaranja = [243,156,18]/255;

minhasCores = [meuVermelho;meuPreto;meuAzul;meuVerde;meuLaranja;meuRoxo];
%% Histogramas da resposta

for indice_atual = indices

    figure
    
    tempos_atuais = sprintf("(t_1,t_2)=(%.2f,%.2f)",tempo(indice_atual),tempo(indice_atual+1));
    respostas_deste_instante = realizacoes_respostas(:,[indice_atual,indice_atual+1]);

    histogram2(respostas_deste_instante(:,1),respostas_deste_instante(:,2),Normalization="pdf",FaceColor=meuVermelho,EdgeColor=meuPreto,NumBins=qtd_urnas*[1,1])

    %xlim([-1.1,1.1])
    %ylim([-1.1,1.1])

    set(gca,'fontsize',15)
    title(["Response Joint Distribution";"at $"+ tempos_atuais+"$ s"],FontSize=20,Interpreter="latex")
    xlabel("$x_1$ [m]",FontSize=20,Interpreter="latex")
    ylabel("$x_2$ [m]",FontSize=20,Interpreter="latex")

end