mma_normal_configuracoes
%% Medições do tempo

%tempos_tipicos = []; %Descomente essa linha caso não haja nenhum arquivo "Tempos dist Wass dimensão.mat" na pasta "Arquivos de Custo Computacional".
load("Arquivos de Custo Computacional/Tempos dist Wass dimensão.mat");  %Descomente essa linha caso já haja um arquivo "Tempos dist Wass dimensão.mat" na pasta "Arquivos de Custo Computacional".

%% Configurações
passos = [10,5,2];

inicio = 0;
fim = 300;

dimensoes = 1:5;
legendas = "m = "+dimensoes;

figura = figure;
figura.Position = [1 350 1919 492];

%% Simulações
tempos_todos_deltaTs = zeros(1,3);
for i = 1:3
tic
for j = 1:numel(dimensoes)

    passo = passos(i);
    intervalo = inicio:passo:fim;

    ordem_Wasserstein = 2;
    dim_Wasserstein = dimensoes(j);

    respostas_desejadas = respostaAnalitica(intervalo,cond_iniciais, ...
    freq_ang_natural,freq_ang_amort,fator_amort,amplitude_forca_norm, ...
    freq_ang_forca)';

    dists_W = distWassersteinMultiDim(respostas_desejadas,dim_Wasserstein,ordem_Wasserstein);
    titulo = ["Distâncias de Wasserstein";"para \Deltat = "+sprintf("%.0f s",passo)];
    subplot(1,3,i)
    
    hold on
    set(gca,'yscale','log')
    semilogy(intervalo(1:end - 2*dim_Wasserstein+1),dists_W,LineWidth=3)



    end
    tempo_deste_deltaT = toc;
    tempos_todos_deltaTs(i) = tempo_deste_deltaT;
    %% Gráficos
    title(titulo,FontSize=25)
    xlabel("Tempo (s)",FontSize=25)
    ylabel("Distância",FontSize=25)
    legend(legendas,Orientation="horizontal")

    set(gca,'fontsize',15)
end

tempos_tipicos = [tempos_tipicos;tempos_todos_deltaTs];
save("Arquivos de Custo Computacional/Tempos dist Wass dimensão.mat")

%% Incertezas

media_tempos_calculo = mean(tempos_tipicos)
desv_pad_tempos_calculo = std(tempos_tipicos);

qtd_medicoes = size(tempos_tipicos,1);
incertezas_tipoA = desv_pad_tempos_calculo / sqrt(qtd_medicoes);

fator_abrangencia = 2;
resolucao = 5*10^-5;
incertezas_tipoB = resolucao/sqrt(12);

incertezas_expandidas = fator_abrangencia*sqrt(incertezas_tipoA.^2 + incertezas_tipoB^2)
