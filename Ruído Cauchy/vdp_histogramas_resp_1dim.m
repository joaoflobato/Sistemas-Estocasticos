vdp_ruido_cauchy

indices = [1,51,251,501,1001,tamanho_realizacao-51];
qtd_urnas = 32;
%% Cores

meuVerde = [0,176,80]/255;
meuVermelho = [195, 40, 30]/255;
meuPreto = [7, 3, 8]/255;
meuAzul = [51, 51, 179]/255;
meuRoxo = [112,48,160]/255;
meuLaranja = [243,156,18]/255;

minhasCores = [meuVermelho;meuPreto;meuAzul;meuVerde;meuLaranja;meuRoxo];
%% Histogramas da resposta

for indice_atual = indices

    figure
    
    tempo_atual = sprintf("t=%.0f",tempo(indice_atual));
    respostas_deste_instante = realizacoes_respostas(:,indice_atual);

    histogram(respostas_deste_instante,FaceColor=meuVermelho,EdgeColor=meuPreto,NumBins=qtd_urnas,Normalization="pdf")
    
    %xlim([-1.1,1.1])
    set(gca,'fontsize',15)
    title("Response Distribution at $"+ tempo_atual+"$ s",FontSize=20,Interpreter="latex")
    xlabel("$x$ [m]",FontSize=20,Interpreter="latex")
end