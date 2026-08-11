mma_ruido_branco
%% Cores

meuVerde = [9,133,66]/255;
meuVermelho = [195, 40, 30]/255;
meuPreto = [7, 3, 8]/255;
meuAzul = [51, 51, 179]/255;
meuRoxo = [150,30,119]/255;
meuLaranja = [243,156,18]/255;

minhasCores = [meuVermelho;meuPreto;meuAzul;meuVerde;meuLaranja;meuRoxo];
%% Distancias de Wasserstein


dimensoes = 1:4;
ordem = 2;
intervalo = 1;
duracao_efetiva = duracao - intervalo;
indices_intervalo = intervalo*fs;
instantes = 0:intervalo:duracao_efetiva-intervalo;



for m = dimensoes

W = zeros(1,duracao_efetiva);
indice_wass = 1;

for instante_atual = instantes
    
    if m == 1
        indices1 = instante_atual*fs+1;
    else
        indices1 = (instante_atual*fs+1)*ones(1,m) + [0:m-1];
    end

    indices2 = indices1 + indices_intervalo-1;

    forcas1 = realizacoes_ruido_branco(:,indices1);
    forcas2 = realizacoes_ruido_branco(:,indices2);

     W(indice_wass) = wasserstein_distance_nd(forcas1',forcas2',ordem);
     indice_wass = 1 + indice_wass;

end

hold on
colororder(minhasCores)
semilogy(instantes,W+m*10^-4,LineWidth=3)

end


set(gca,'fontsize',15)
ylim([0,2*max(W)])

title(["Wasserstein Distances between $\mathbf{f}$ Sections'";"Distributions for $\Delta t = 1$ s"],FontSize=20,Interpreter="latex")
xlabel("$t_1$ [s]",FontSize=20,Interpreter="latex")
ylabel("$\hat{\mathcal{W}}_{2,m}(\mathbf{f}_1,\mathbf{f}_2)$",FontSize=20,Interpreter="latex")