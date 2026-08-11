mma_ruido_cauchy

indices = [1,51,101,n_amostras];
qtd_urnas = 32;
%% Cores

meuVerde = [9,133,66]/255;
meuVermelho = [195, 40, 30]/255;
meuPreto = [7, 3, 8]/255;
meuAzul = [51, 51, 179]/255;
meuRoxo = [150,30,119]/255;
meuLaranja = [243,156,18]/255;

minhasCores = [meuVermelho;meuPreto;meuAzul;meuVerde;meuLaranja;meuRoxo];
%% Histogramas do forçamento

for indice_atual = indices

    figure
    
    tempo_atual = sprintf("t=%.0f",tempo(indice_atual));
    forcas_deste_instante = realizacoes_ruido_cauchy(:,indice_atual);

    histogram(forcas_deste_instante,FaceColor=meuVermelho,EdgeColor=meuPreto,NumBins=qtd_urnas,Normalization="pdf")

    set(gca,'fontsize',15)
    title("Force Distribution at $"+ tempo_atual+"$ s",FontSize=20,Interpreter="latex")
    xlabel("Force (N)",FontSize=20)
end