function dist = distanciasEng(amostras)

    passos_tempo= size(amostras,1);
    dist = zeros(passos_tempo - 1,1);

    for i = 2:passos_tempo
        
        media_instante_atual = mean(amostras(i,:));
        media_instante_anterior = mean(amostras(i-1,:));

        dist(i-1) = abs(media_instante_atual - media_instante_anterior);

    end

end