mma_normal_configuracoes

figura1 = figure;
figura1.Position = [150,221,1482,591];

%% Correlação dos forçamentos

tempos = 50:0.75:150;

forcas = forcamento(tempos);

media_conj_forcamentos = 1/qtd_amostras*forcas'*forcas;
media_conj_forcamentos_diag = diag(flip(media_conj_forcamentos,2));

[varredura_freq_forca,sinal_freq_forca] = transf_fourier(tempos,media_conj_forcamentos_diag);
%% Correlação das respostas

fatores_amort = [0.1,0.25,1,2.5,10];
legendas = "\zeta = "+fatores_amort;

for i = 1:numel(fatores_amort)

fator_amort = fatores_amort(i);

respostas = respostaAnalitica(tempos,cond_iniciais, ...
    freq_ang_natural,freq_ang_amort,fator_amort,amplitude_forca_norm, ...
    freq_ang_forca)';

media_conj_respostas = 1/qtd_amostras*respostas*respostas';
media_conj_respostas_diag = diag(flip(media_conj_respostas,2));

[varredura_freq_resp,sinal_freq_resp] = transf_fourier(tempos,media_conj_respostas_diag);

sinal_freq_resp_norm = sinal_freq_resp/max(sinal_freq_resp);

subplot(1,2,1)
hold on
plot(varredura_freq_resp,sinal_freq_resp_norm,LineWidth=3)

end


%% Gráficos


subplot(1,2,1)

ylim([0,1.1])

title(["Densidade espectral da resposta";"ao forçamento estocástico"],FontSize=20)

xlabel("Frequência (Hz)",FontSize=20)
ylabel("Posição Normalizada(\omega)",FontSize=20)


legend(legendas,Orientation="horizontal")
set(gca,'fontsize',20)

subplot(1,2,2)
stem(varredura_freq_forca,sinal_freq_forca)

title(["Densidade espectral do";"forçamento estocástico"],FontSize=20)

xlabel("Frequência (Hz)",FontSize=20)
ylabel("Força(\omega)",FontSize=20)

set(gca,'fontsize',20)