vdp_normal_pos_processamento;

amortecedores = [0.2,0.5,2,5,20];

respostas_diferentes_amort = [];
media_respostas = [];
desvio_padrao_respostas = [];
qtd_amortecedores = numel(amortecedores);

tic;
for i = 1:qtd_amortecedores
    
    alpha = amortecedores(i);

    for j = 1:contagem_amostras

        intensidade_forca = forcas_maximas_amostral(j);
        freq_forca = frequecia_forcas_amostral(j);

        forca_ext = @(t) intensidade_forca*cos(2*pi*freq_forca*t);

        equacao_vdp = @(t,X) [X(2);1/massa*(forca_ext(t) - X(1) + alpha*(1-X(1).^2)*X(2))];
    
        sist_vdp = sistema(equacao_vdp , condicoes_iniciais_vdp , intervalo , passo);

        respostas_diferentes_amort(:,j,i) = sist_vdp.posicoes;

        ExibirProgresso(i,qtd_amortecedores,j,contagem_amostras)


    end

end
tempo_execucao = toc;
fprintf("Tempo de execução: %.3f s\n",tempo_execucao)

save("Variáveis/amortecedores.mat", ...
    "amortecedores","respostas_diferentes_amort", ...
    "tempos","passo","tempo_inicial", ...
    "tempo_final","tempo_execucao","qtd_amortecedores");