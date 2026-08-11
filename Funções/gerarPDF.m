function [contagem_normalizada,pos_media_urnas] = gerarPDF(amostra,qtd_urnas,mins_amostra,maxs_amostra,m)

n_r = size(amostra,2);
pos_urnas = zeros(m,qtd_urnas+1);

for dimensao = 1:m

    pos_urnas(dimensao,:) = linspace(mins_amostra(dimensao),maxs_amostra(dimensao),qtd_urnas+1);

end


largura_urnas = pos_urnas(:,2)-pos_urnas(:,1);
fator_normalizacao = n_r*prod(largura_urnas);

if m == 1

    urnas = zeros(1,qtd_urnas);
elseif m == 2
    urnas = zeros(qtd_urnas,qtd_urnas);
elseif m == 3
    urnas = zeros(qtd_urnas,qtd_urnas,qtd_urnas);
else
    error("Dimensão inválida")
end

for i = 1:n_r

    realizacao = amostra(:,i);
    
    indices_urna = zeros(1,m);
    for dimensao = 1:m
        
        realizacao_norm = (realizacao(dimensao) - mins_amostra(dimensao))/largura_urnas(dimensao);

        indices_urna(dimensao) = floor(realizacao_norm)+1;
        if indices_urna(dimensao) > qtd_urnas
            indices_urna(dimensao) = qtd_urnas;
        end
    end


    
    if m == 1
            urnas(indices_urna) = 1 + urnas(indices_urna);
    elseif m == 2
            urnas(indices_urna(1),indices_urna(2)) = 1 + urnas(indices_urna(1),indices_urna(2));
    elseif m == 3
            urnas(indices_urna(1),indices_urna(2),indices_urna(3)) = 1 + urnas(indices_urna(1),indices_urna(2),indices_urna(3));
    else
            error("Dimensão inválida")
    end


end

contagem_normalizada = urnas/fator_normalizacao;
pos_media_urnas = (pos_urnas(:,1:end-1) + pos_urnas(:,2:end))/2;

end