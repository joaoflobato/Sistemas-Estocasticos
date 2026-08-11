vdp_ruido_cauchy
%% Cores

meuVerde = [0,176,80]/255;
meuVermelho = [195, 40, 30]/255;
meuPreto = [7, 3, 8]/255;
meuAzul = [51, 51, 179]/255;
meuRoxo = [112,48,160]/255;
meuLaranja = [243,156,18]/255;

minhasCores = [meuVermelho;meuPreto;meuAzul;meuVerde;meuLaranja;meuRoxo];
%% Divergência JS


dimensoes = 1:3;
qtd_urnas = 32;
intervalo = 1;
duracao_efetiva = duracao - intervalo;
indices_intervalo = intervalo*fs;
instantes = 0:intervalo:duracao_efetiva-intervalo;



for m_atual = dimensoes

JS = zeros(1,duracao_efetiva);
indice_js = 1;

for instante_atual = instantes
    
    if m_atual == 1
        indices1 = instante_atual*fs+1;
    else
        indices1 = (instante_atual*fs+1)*ones(1,m_atual) + [0:m_atual-1];
    end

    indices2 = indices1 + indices_intervalo-1;

    respostas1 = realizacoes_respostas(:,indices1)';
    respostas2 = realizacoes_respostas(:,indices2)';

    mins_resp1 = min(respostas1,[],2);
    maxs_resp1 = max(respostas1,[],2);
    
    mins_resp2 = min(respostas2,[],2);
    maxs_resp2 = max(respostas2,[],2);

    mins_gerais = zeros(m_atual,1);
    maxs_gerais = zeros(m_atual,1);

    for indice_dimensao = 1:m_atual
        mins_gerais(indice_dimensao) = min([mins_resp1(indice_dimensao),mins_resp2(indice_dimensao)]);
        maxs_gerais(indice_dimensao) = max([maxs_resp1(indice_dimensao),maxs_resp2(indice_dimensao)]);
    end
    
    [histograma_x1,pos_media_urnas] = gerarPDF(respostas1,qtd_urnas,mins_gerais,maxs_gerais,m_atual);
    [histograma_x2,~] = gerarPDF(respostas2,qtd_urnas,mins_gerais,maxs_gerais,m_atual);

    largura_urnas = pos_media_urnas(:,2) - pos_media_urnas(:,1);

    JS(indice_js) = divergencia_JS(histograma_x1,histograma_x2,largura_urnas);
    indice_js = 1 + indice_js;

end

hold on
semilogy(instantes,JS,LineWidth=3,Color=minhasCores(m_atual,:))

end


set(gca,'yscale','log','fontsize',15)
ylim([0,1.5*max(JS)])

title(["$\mathbf{x}$ JS-Divergences for $\Delta t = 1$ s and $\zeta = 0.05$"],FontSize=20,Interpreter="latex")
xlabel("$t_1$ [s]",FontSize=20,Interpreter="latex")
ylabel("$\hat{\textrm{JS}}(\hat{p}_{\mathbf{x}_1},\hat{p}_{\mathbf{x}_2})$",FontSize=20,Interpreter="latex")