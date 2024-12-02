tic
mma_normal_configuracoes

fatores_amort = [0.1,0.25,1,2.5,10];
intervalo = linspace(0,35);
legendas = "\zeta = "+fatores_amort;

figura1 = figure;
figura1.Position = [314 305 1368 492];

for i = 1:numel(fatores_amort)

    fator_amort = fatores_amort(i);
    freq_ang_amort = freq_ang_natural*sqrt(1-fator_amort^2);

    respostas_desejadas = respostaAnalitica(intervalo,cond_iniciais, ...
    freq_ang_natural,freq_ang_amort,fator_amort,amplitude_forca_norm, ...
    freq_ang_forca)';

    media_posicoes = mean(respostas_desejadas,2);
    media_posicoes_norm = media_posicoes/max(abs(media_posicoes));

    desvio_padrao_posicoes = std(respostas_desejadas,0,2);
    desvio_padrao_posicoes_norm = desvio_padrao_posicoes/max(desvio_padrao_posicoes);


    subplot(1,2,1)
    
    hold on
    plot(intervalo,media_posicoes_norm,LineWidth=3)

    subplot(1,2,2)

    hold on
    plot(intervalo,desvio_padrao_posicoes_norm,LineWidth=3)


end
subplot(1,2,1)

title(["Média Normalizada";"das Posições"],FontSize=20)

xlabel("Tempo (s)",FontSize=15)
ylabel("\mu_x / |\mu_{x_{max}}|",FontSize=15)

legend(legendas,Location="southeast")


subplot(1,2,2)

title(["Desvio Padrão";"Normalizado das Posições"],FontSize=20)

xlabel("Tempo (s)",FontSize=15)
ylabel("\sigma_x / \sigma_{x_{max}}",FontSize=15)

legend(legendas,Location="southeast")
toc