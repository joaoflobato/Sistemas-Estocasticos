mma_normal_configuracoes
%% Medições do tempo

%tempos_tipicos = []; %Descomente essa linha caso não haja nenhum arquivo "Tempos dist Eng amostras.mat" na pasta "Arquivos de Custo Computacional".
load("Arquivos de Custo Computacional/Tempos dist Eng amostras.mat");  %Descomente essa linha caso já haja um arquivo "Tempos dist Eng amostras.mat" na pasta "Arquivos de Custo Computacional".

%% Configurações


inicio = 0;
fim = 300;

passos = [10,5,2];
ordens_grandeza = [3,4,5];

figura = figure;
figura.Position = [1 350 1919 492];
%% Simulações
tempos_todos_deltaTs = zeros(1,3);
for i = 1:3

   tic
    for j = 1:3

    qtd_amostras = 3*10^ordens_grandeza(j);

    passo = passos(i);
    intervalo = inicio:passo:fim;

    rng('default')      %Garante reprodutibilidade
    
    amplitude_forca = random("Normal",amplitude_forca_teorica(1),amplitude_forca_teorica(2),[qtd_amostras,1]);
    amplitude_forca_norm = amplitude_forca / massa;
    freq_ang_forca = random("Normal",freq_ang_forca_teorica(1),freq_ang_forca_teorica(2),[qtd_amostras,1]);
    
    respostas_desejadas = respostaAnalitica(intervalo,cond_iniciais, ...
        freq_ang_natural,freq_ang_amort,fator_amort,amplitude_forca_norm, ...
        freq_ang_forca)';



    dists_eng = distanciasEng(respostas_desejadas);
    titulo = ["Distâncias de Engenharia";"para \Deltat = "+sprintf("%.0f s",passo)];
    legendas(j) = sprintf("3.10^{%d} realizações",ordens_grandeza(j));
    
    subplot(1,3,i) 
    
    hold on
    set(gca,'yscale','log')
    semilogy(intervalo(2:end),dists_eng,LineWidth=3)
    

    

    end
    tempo_deste_deltaT = toc;
    tempos_todos_deltaTs(i) = tempo_deste_deltaT;



    %% Gráficos
    title(titulo,FontSize=20)
    xlabel("Tempo (s)",FontSize=20)
    ylabel("Distância",FontSize=20)
    legend(legendas)

end

tempos_tipicos = [tempos_tipicos;tempos_todos_deltaTs];
save("Arquivos de Custo Computacional/Tempos dist Eng amostras.mat","tempos_tipicos")

media_tempos_calculo = mean(tempos_tipicos)
desv_pad_tempos_calculo = std(tempos_tipicos)