mma_normal_pos_processamento;

%%
%Gráficos envelope

figura = figure;
figura.Position = [106,171,1745,639];

subplot(1,2,1)

borda = desvio_padrao_forcamentos;

legendas = ["Gráfico envelope dos forçamentos","Tempo(s)","Força(N)","\mu_F + \sigma_F","\mu_F"];

graficoEnvelope(tempos,media_forcamentos,borda,legendas)

graficoEnvelope(tempos,media_posicoes,borda,legendas)

subplot(1,2,2)

borda = desvio_padrao_posicoes;
legendas = ["Gráfico envelope das respostas","Tempo(s)","Posição(m)","\mu_x + \sigma_x","\mu_x"];



graficoEnvelope(tempos,media_posicoes,borda,legendas)
