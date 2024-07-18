mma_normal_pos_processamento;

total_passos = (tempo_final - tempo_inicial)/passo + 1;
indices_analise = 1:1000:total_passos;


ordem_Wassertein = 2;

dists_W = distanciasWasserstein(respostas(indices_analise,:),ordem_Wassertein);

figura = figure;
figura.Position = [417,108,1138,850];


semilogy(tempos(indices_analise(2:end)),dists_W,LineWidth=3)

title(["Distâncias de Wasserstein";"ao longo do Tempo"],FontSize=20)

xlabel("Tempo (s)",FontSize=20)
ylabel("Distância",FontSize=20)

yticks([0.25,0.5,1,2])