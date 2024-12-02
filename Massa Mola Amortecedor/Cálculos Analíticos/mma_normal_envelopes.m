tic
mma_normal_configuracoes

inicio = 0;
fim = 150;
passo = 0.1;
intervalo = inicio:passo:fim;

respostas_desejadas = respostaAnalitica(intervalo,cond_iniciais, ...
    freq_ang_natural,freq_ang_amort,fator_amort,amplitude_forca_norm, ...
    freq_ang_forca)';
forcamentos_desejados = forcamento(intervalo)';

media_posicoes = mean(respostas_desejadas,2);
desvio_padrao_posicoes = std(respostas_desejadas,0,2);


media_forcamentos = mean(forcamentos_desejados,2);
desvio_padrao_forcamentos = std(forcamentos_desejados,0,2);

figura = figure;
figura.Position = [106 171 1745 639];

subplot(1,2,1)

borda = desvio_padrao_forcamentos;

legendas = ["Gráfico envelope dos forçamentos","Tempo(s)","Força(N)","\mu_F \pm \sigma_F","\mu_F"];

graficoEnvelope(intervalo,media_forcamentos,borda,legendas)

subplot(1,2,2)

borda = desvio_padrao_posicoes;
legendas([1,3:5]) = ["Gráfico envelope das respostas","Posição(m)","\mu_x \pm \sigma_x","\mu_x"];



graficoEnvelope(intervalo,media_posicoes,borda,legendas)
toc