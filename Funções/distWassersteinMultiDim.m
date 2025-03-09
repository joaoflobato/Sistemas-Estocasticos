function W = distWassersteinMultiDim(amostras,dimensao,ordem)

if dimensao == 1
    W = distanciasWasserstein(amostras,ordem);
  
elseif dimensao > 1 && mod(dimensao,1) == 0 %Checar se é um número inteiro

passos_tempo= size(amostras,1);
tamanho_amostra = size(amostras,2);

W = zeros(passos_tempo - 2*dimensao+1,1);

for i = 2*dimensao:passos_tempo

    indices_instante_atual = linspace(i+1-dimensao,i,dimensao);
    indices_instante_anterior = indices_instante_atual - dimensao;

    amostras_instante_atual = amostras(indices_instante_atual,:)';
    amostras_instante_anterior = amostras(indices_instante_anterior,:)';

    copia_inst_atual = amostras_instante_atual;
    copia_inst_anterior = amostras_instante_anterior;

    distancia_total_1 = 0;

    for j = 1:passos_tempo
        ponto_instante_atual = amostras_instante_atual(j,:);

        distancia_ponto_instante_anterior = sum(abs(ponto_instante_atual - copia_inst_anterior).^ordem,2);

        [menor_dist,pos_menor_dist] = min(distancia_ponto_instante_anterior);
        distancia_total_1 = distancia_total_1 + menor_dist;

        copia_inst_anterior(pos_menor_dist,:) = [];

    end

    distancia_total_2 = 0;

    for j = 1:passos_tempo
        ponto_instante_anterior = amostras_instante_anterior(j,:);

        distancia_ponto_instante_atual = sum(abs(ponto_instante_anterior - copia_inst_atual).^ordem,2);

        [menor_dist,pos_menor_dist] = min(distancia_ponto_instante_atual);
        distancia_total_2 = distancia_total_2 + menor_dist;

        copia_inst_atual(pos_menor_dist,:) = [];

    end
    
    menor_dist_total = min([distancia_total_1,distancia_total_2]);

    W(i+1-2*dimensao) = nthroot(menor_dist_total/tamanho_amostra,ordem);

end

else
    error("Dimensão inválida")

end


end