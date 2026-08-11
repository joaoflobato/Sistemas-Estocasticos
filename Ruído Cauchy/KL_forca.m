mma_ruido_cauchy
%% Cores

meuVerde = [0,176,80]/255;
meuVermelho = [195, 40, 30]/255;
meuPreto = [7, 3, 8]/255;
meuAzul = [51, 51, 179]/255;
meuRoxo = [112,48,160]/255;
meuLaranja = [243,156,18]/255;

minhasCores = [meuVermelho;meuPreto;meuAzul;meuVerde;meuLaranja;meuRoxo];
colororder(minhasCores)
%% Divergência JS


dimensoes = 1:3;
qtd_urnas = 32;
intervalo = 1;
duracao_efetiva = duracao - intervalo;
indices_intervalo = intervalo*fs;
instantes = 0:intervalo:duracao_efetiva-intervalo;



for m_atual = dimensoes

KL = zeros(1,duracao_efetiva);
indice_js = 1;

for instante_atual = instantes
    
    if m_atual == 1
        indices1 = instante_atual*fs+1;
    else
        indices1 = (instante_atual*fs+1)*ones(1,m_atual) + [0:m_atual-1];
    end

    indices2 = indices1 + indices_intervalo-1;

    forcas1 = realizacoes_ruido_cauchy(:,indices1)';
    forcas2 = realizacoes_ruido_cauchy(:,indices2)';

    mins_forca1 = min(forcas1,[],2);
    maxs_forca1 = max(forcas1,[],2);
    
    mins_forca2 = min(forcas2,[],2);
    maxs_forca2 = max(forcas2,[],2);

    mins_gerais = zeros(m_atual,1);
    maxs_gerais = zeros(m_atual,1);

    for indice_dimensao = 1:m_atual
        mins_gerais(indice_dimensao) = min([mins_forca1(indice_dimensao),mins_forca2(indice_dimensao)]);
        maxs_gerais(indice_dimensao) = max([maxs_forca1(indice_dimensao),maxs_forca2(indice_dimensao)]);
    end
    
    [histograma_f1,pos_media_urnas] = gerarPDF(forcas1,qtd_urnas,mins_gerais,maxs_gerais,m_atual);
    [histograma_f2,~] = gerarPDF(forcas2,qtd_urnas,mins_gerais,maxs_gerais,m_atual);

    largura_urnas = pos_media_urnas(:,2) - pos_media_urnas(:,1);
    
    KL1 = abs(divergencia_KL(histograma_f1,histograma_f2,largura_urnas));
    KL2 = abs(divergencia_KL(histograma_f2,histograma_f1,largura_urnas));

    KL(indice_js) = min([KL1,KL2]);
    indice_js = 1 + indice_js;

end

hold on
semilogy(instantes,KL,LineWidth=3)

end


set(gca,'yscale','log','fontsize',15)
ylim([0,3*max(KL)])

title(["$\mathbf{f}$ KL-Divergences for $\Delta t = 1$ s"],FontSize=20,Interpreter="latex")
xlabel("$t_1$ [s]",FontSize=20,Interpreter="latex")
ylabel("$\hat{\textrm{KL}}(\hat{p}_{\mathbf{f}_1},\hat{p}_{\mathbf{f}_2})$",FontSize=20,Interpreter="latex")