tic
mma_normal_configuracoes

intervalo = 0:0.1:150;


qtd_amostras = 10^4;

rng('default')      %Garante reprodutibilidade
    
amplitude_forca = random("Normal",amplitude_forca_teorica(1),amplitude_forca_teorica(2),[qtd_amostras,1]);
amplitude_forca_norm = amplitude_forca / massa;
freq_ang_forca = random("Normal",freq_ang_forca_teorica(1),freq_ang_forca_teorica(2),[qtd_amostras,1]);

forcamento = @(t) amplitude_forca .* cos(freq_ang_forca.*t);

forcamentos_desejados = forcamento(intervalo);
%%
%Densidade do forçamento

correlacao_forcamentos = 1/qtd_amostras*(forcamentos_desejados'*forcamentos_desejados);
correlacao_forcamentos_diag = diag(flip(correlacao_forcamentos,2));

[varredura_freq_forca,sinal_freq_forca] = transf_fourier(intervalo,correlacao_forcamentos_diag);
%%
%Densidade da resposta

respostas_desejadas = respostaAnalitica(intervalo,cond_iniciais, ...
    freq_ang_natural,freq_ang_amort,fator_amort,amplitude_forca_norm, ...
    freq_ang_forca)';


correlacao_respostas = 1/qtd_amostras*(respostas_desejadas*respostas_desejadas');
correlacao_respostas_diag = diag(flip(correlacao_respostas,2));

[varredura_freq_resp,sinal_freq_resp] = transf_fourier(intervalo,correlacao_respostas_diag);
%%
%Reposta a um impulso unitário
varredura_freq_imp = varredura_freq_resp;
varredura_freq_ang = varredura_freq_resp*2*pi;
sinal_freq_imp_quad = (freq_ang_natural^-2./sqrt((1-varredura_freq_ang.^2/freq_ang_natural^2).^2 + (2*fator_amort*varredura_freq_ang/freq_ang_natural).^2)).^2;
%%
%Malha grossa
fator_engrossamento = 20;

tempos_mg = intervalo(1:fator_engrossamento:end);
correlacao_forcamentos_mg = correlacao_forcamentos(1:fator_engrossamento:end,1:fator_engrossamento:end);
correlacao_respostas_mg = correlacao_respostas(1:fator_engrossamento:end,1:fator_engrossamento:end);

[T1,T2] = meshgrid(tempos_mg,tempos_mg);
%%
%Gráficos
legenda_correl_forcas = ["Correlação"; "do forçamento"];
legenda_correl_resp = ["Correlação";"da resposta"];

figura1 = figure;
figura1.Position = [327,91,1201,866];

subplot(2,2,1)

colormap jet
surf(T1,T2,correlacao_forcamentos_mg)

title(legenda_correl_forcas,FontSize=20)

xlabel("t_1 (s)",FontSize=20)
ylabel("t_2 (s)",FontSize=20)
zlabel("r_F(t_1,t_2) (N)",FontSize=20)

subplot(2,2,2)

surf(T1,T2,correlacao_respostas_mg)

title(legenda_correl_resp,FontSize=20)

xlabel("t_1 (s)",FontSize=20)
ylabel("t_2 (s)",FontSize=20)
zlabel("r_X(t_1,t_2) (m)",FontSize=20)

subplot(2,2,3)
imagesc(tempos_mg,tempos_mg,correlacao_forcamentos_mg)
colorbar

title(legenda_correl_forcas,FontSize=20)

xlabel("t (s)",FontSize=20)
ylabel("t + \tau (s)",FontSize=20)

subplot(2,2,4)
imagesc(tempos_mg,tempos_mg,correlacao_respostas_mg)
colorbar

title(legenda_correl_resp,FontSize=20)

xlabel("t (s)",FontSize=20)
ylabel("t + \tau (s)",FontSize=20)





figura2 = figure;
figura2.Position = [308,287,1226,427];

subplot(1,2,1)
plot(intervalo,correlacao_forcamentos_diag,LineWidth=2)

title(["Diagonal da correlação";"do forçamento"],FontSize=20)

xlabel("\tau (s)",FontSize=20)
ylabel("Força (N)",FontSize=20)

subplot(1,2,2)
plot(intervalo,correlacao_respostas_diag,LineWidth=2)

title(["Diagonal da correlação";"da resposta"],FontSize=20)

xlabel("\tau (s)",FontSize=20)
ylabel("Posição (m)",FontSize=20)






figura3 = figure;
figura3.Position = [57 298 1709 441];

subplot(1,3,1)

stem(varredura_freq_imp,sinal_freq_imp_quad)
xlim([-1/2,1/2])
xticks([-0.5,-0.16,0,0.16,0.5])

title(["Densidade espectral da resposta";"ao impulso unitário"],FontSize=20)

xlabel("Frequência (Hz)",FontSize=20)
ylabel("|h(\omega)|^2",FontSize=20)

subplot(1,3,2)

stem(varredura_freq_forca,sinal_freq_forca)
xlim([-1/2,1/2])
xticks([-0.5,-0.32,0,0.32,0.5])

title(["Densidade espectral do";"forçamento estocástico"],FontSize=20)

xlabel("Frequência (Hz)",FontSize=20)
ylabel("Força(\omega)",FontSize=20)


subplot(1,3,3)
stem(varredura_freq_resp,sinal_freq_resp)
xlim([-1/2,1/2])
xticks([-0.5,-0.32,0,0.32,0.5])

title(["Densidade espectral da resposta";"ao forçamento estocástico"],FontSize=20)

xlabel("Frequência (Hz)",FontSize=20)
ylabel("Posição(\omega)",FontSize=20)
toc