mma_normal_pos_processamento;

amortecedores = [0.2,0.5,2,5,20];

respostas_diferentes_amort = [];
media_respostas = [];
desvio_padrao_respostas = [];

for i = 1:numel(amortecedores)
    
    const_amortecedor = amortecedores(i);

    for j = 1:contagem_amostras

        intensidade_forca = forcas_maximas_amostral(j);
        freq_forca = frequecia_forcas_amostral(j);

        forca_ext = @(t) intensidade_forca*cos(2*pi*freq_forca*t);

        equacao_mma = @(t,X) [0,1;-const_mola/massa,-const_amortecedor/massa]*X + [0;forca_ext(t)/massa];

    
        sist_mma = sistema(equacao_mma , condicoes_iniciais_mma , intervalo , passo);

        respostas_diferentes_amort(:,j,i) = sist_mma.posicoes;


    end

end

save("Variáveis/amortecedores.mat", ...
    "amortecedores","respostas_diferentes_amort", ...
    "amortecimento_crit","tempos");