addpath("../Configurações Sistemas/","../Funções/")
vdp_configuracoes
%% Ruído



potencia = 1; % Potência do ruído (variância)


rng('default')      %Garante reprodutibilidade

realizacoes_ruido_branco = sqrt(potencia) * randn(qtd_realizacoes, tamanho_realizacao);
%% Distancias de Wasserstein


dimensoes = 1:4;
ordem = 2;
intervalo = 1;
cond_iniciais = [0;0];
duracao_efetiva = duracao - intervalo;
indices_intervalo = intervalo*fs;
instantes = 0:intervalo:duracao_efetiva-intervalo;

for fator_alpha = [0.1,1,2,5]
figure
legenda_amort = sprintf("%.2f",fator_alpha);

realizacoes_respostas = zeros(qtd_realizacoes,tamanho_realizacao);
for realizacao_atual = 1:qtd_realizacoes

    ruido_branco = realizacoes_ruido_branco(realizacao_atual,:);
    realizacoes_respostas(realizacao_atual,:) = resposta_vdp(tempo,ruido_branco,massa,fator_alpha,rigidez,cond_iniciais);

end




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

    respostas1 = realizacoes_respostas(:,indices1);
    respostas2 = realizacoes_respostas(:,indices2);

     W(indice_wass) = wasserstein_distance_nd(respostas1',respostas2',ordem);
     indice_wass = 1 + indice_wass;

end

hold on



W = W*(1+m*10^-2);
colororder(minhasCores)
semilogy(instantes,W,LineWidth=3)

end

set(gca,'fontsize',15)

 ylim([0,1.5*max(W)])

title(["$\mathbf{x}$ Wasserstein Distances ";"for $\Delta t = 1$ s and $\alpha="+legenda_amort+"$"],FontSize=20,Interpreter="latex")
xlabel("$t_1$ [s]",FontSize=20,Interpreter="latex")
ylabel("$\hat{\mathcal{W}}_{2,m}(\mathbf{x}_1,\mathbf{x}_2)$",FontSize=20,Interpreter="latex")
end