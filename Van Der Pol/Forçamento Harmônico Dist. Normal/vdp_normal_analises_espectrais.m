vdp_normal_pos_processamento;

%%
%Resposta ao impulso unitário

impulso = 1;
condicoes_iniciais_vdp = [0;impulso/massa];
equacao_vdp = @(t,X) [X(2);1/massa*(forca_ext(t) - X(1) + alpha*(1-X(1).^2)*X(2))];

sist_vdp_imp_unit = sistema(equacao_vdp , condicoes_iniciais_vdp , intervalo , passo);
tempos = sist_vdp_imp_unit.instantes;
posicoes = sist_vdp_imp_unit.posicoes;

[varredura_freq_imp,sinal_freq_imp_quad] = transf_fourier(tempos,posicoes);

sinal_freq_imp_quad = sinal_freq_imp_quad.^2;
%%
%Média conjunta dos forçamentos

media_conj_forcamentos = 1/contagem_amostras*forcamentos'*forcamentos;
media_conj_forcamentos_diag = diag(flip(media_conj_forcamentos,2));

[varredura_freq_forca,sinal_freq_forca] = transf_fourier(tempos,media_conj_forcamentos_diag);
%%
%Média conjunta das respostas

media_conj_respostas = 1/contagem_amostras*respostas*respostas';
media_conj_respostas_diag = diag(flip(media_conj_respostas,2));

[varredura_freq_resp,sinal_freq_resp] = transf_fourier(tempos,media_conj_respostas_diag);
%%
%Malha grossa
fator_engrossamento = 100;

tempos_mg = tempos(1:fator_engrossamento:end);
media_conj_forcamentos_mg = media_conj_forcamentos(1:fator_engrossamento:end,1:fator_engrossamento:end);
media_conj_respostas_mg = media_conj_respostas(1:fator_engrossamento:end,1:fator_engrossamento:end);

[T1,T2] = meshgrid(tempos_mg,tempos_mg);
%%
%Gráficos
legenda_correl_forcas = ["Correlação"; "do forçamento"];
legenda_correl_resp = ["Correlação";"da resposta"];

figura1 = figure;
figura1.Position = [327,91,1201,866];

subplot(2,2,1)

colormap jet
surf(T1,T2,media_conj_forcamentos_mg)

title(legenda_correl_forcas,FontSize=20)

xlabel("t_1 (s)",FontSize=20)
ylabel("t_2 (s)",FontSize=20)
zlabel("r_F(t_1,t_2) (N)",FontSize=20)

subplot(2,2,2)

surf(T1,T2,media_conj_respostas_mg)

title(legenda_correl_resp,FontSize=20)

xlabel("t_1 (s)",FontSize=20)
ylabel("t_2 (s)",FontSize=20)
zlabel("r_X(t_1,t_2) (m)",FontSize=20)

subplot(2,2,3)
imagesc(tempos_mg,tempos_mg,media_conj_forcamentos_mg)
colorbar

title(legenda_correl_forcas,FontSize=20)

xlabel("t (s)",FontSize=20)
ylabel("t + \tau (s)",FontSize=20)

subplot(2,2,4)
imagesc(tempos_mg,tempos_mg,media_conj_respostas_mg)
colorbar

title(legenda_correl_resp,FontSize=20)

xlabel("t (s)",FontSize=20)
ylabel("t + \tau (s)",FontSize=20)





figura2 = figure;
figura2.Position = [308,287,1226,427];

subplot(1,2,1)
plot(tempos,media_conj_forcamentos_diag,LineWidth=2)

title(["Diagonal da correlação";"do forçamento"],FontSize=20)

xlabel("\tau (s)",FontSize=20)
ylabel("Força (N)",FontSize=20)

subplot(1,2,2)
plot(tempos,media_conj_respostas_diag,LineWidth=2)

title(["Diagonal da correlação";"da resposta"],FontSize=20)

xlabel("\tau (s)",FontSize=20)
ylabel("Posição (m)",FontSize=20)






figura3 = figure;
figura3.Position = [5,304,1913,431];


subplot(1,3,1)
stem(varredura_freq_resp,sinal_freq_resp)
xlim([-1/2,1/2])
xticks([-0.5,-0.32,0,0.32,0.5])

title(["Densidade espectral da resposta";"ao forçamento estocástico"],FontSize=20)

xlabel("Frequência (Hz)",FontSize=20)
ylabel("Posição(\omega)",FontSize=20)


subplot(1,3,2)
stem(varredura_freq_imp,sinal_freq_imp_quad)
xlim([-1/2,1/2])
xticks([-0.5,-0.16,0,0.16,0.5])

title(["Densidade espectral da resposta";"ao impulso unitário"],FontSize=20)

xlabel("Frequência (Hz)",FontSize=20)
ylabel("|h(\omega)|^2",FontSize=20)


subplot(1,3,3)
stem(varredura_freq_forca,sinal_freq_forca)
xlim([-1/2,1/2])
xticks([-0.5,-0.32,0,0.32,0.5])

title(["Densidade espectral do";"forçamento estocástico"],FontSize=20)

xlabel("Frequência (Hz)",FontSize=20)
ylabel("Força(\omega)",FontSize=20)