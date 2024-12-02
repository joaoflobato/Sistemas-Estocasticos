tic
mma_normal_configuracoes

inicio = 0;
fim = 150;
ordem_Wassertein = 2;

passos = [10,5,2];
ordens_grandeza = [3,4,5];

figura = figure;
figura.Position = [1 350 1919 492];
for i = 1:3
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



    dists_W = distanciasWasserstein(respostas_desejadas,ordem_Wassertein);
    titulo = ["Distâncias de Wasserstein";"para \Deltat = "+sprintf("%.0f s",passo)];
    legendas(j) = sprintf("3.10^{%d} realizações",ordens_grandeza(j));
    
    subplot(1,3,i) 
    
    hold on
    set(gca,'yscale','log')
    semilogy(intervalo(2:end),dists_W,LineWidth=3)
    

    

    end
    yticks(2.^[-6:0])

    title(titulo,FontSize=20)
    xlabel("Tempo (s)",FontSize=20)
    ylabel("Distância",FontSize=20)
    legend(legendas)

end
toc