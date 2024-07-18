mma_normal_pos_processamento;

figura = figure;
figura.Position = [408,94,1118,857];
    
    subplot(2,2,1)
    plot(vetor_qtd_amostras,abs(vetor_media_forcas-media_teorica),Color="b")


    title("Convergência das Forças",FontSize=15)
    xlabel("Tamanho da Amostra",FontSize=15)
    ylabel(["Resíduos da Média";"das Amplitudes (N)"],FontSize=15)
    
    
    subplot(2,2,2)

    plot(vetor_qtd_amostras,abs(vetor_media_frequencias-media_teorica/(2*pi)),Color="b")

    title("Convergência das Frequências",FontSize=15)
    xlabel("Tamanho da Amostra",FontSize=15)
    ylabel(["Resíduos da Média";"das Frequências (Hz)"],FontSize=15)

    subplot(2,2,3)
    
    plot(vetor_qtd_amostras,abs(vetor_dp_forcas - desvio_padrao_teorico))

    title("Convergência das Forças",FontSize=15)
    xlabel("Tamanho da Amostra",FontSize=15)
    ylabel(["Resíduos do Desvio Padrão";"das Amplitudes (N)"],FontSize=15)

    subplot(2,2,4)

    plot(vetor_qtd_amostras,abs(vetor_dp_frequencias - desvio_padrao_teorico/(2*pi)))

    title("Convergência das Frequências",FontSize=15)
    xlabel("Tamanho da Amostra",FontSize=15)
    ylabel(["Resíduos do Desvio Padrão";"das Frequências (Hz)"],FontSize=15)