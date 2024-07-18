function W = distanciasWasserstein(amostras,p)

    passos_tempo= size(amostras,1);
    W = zeros(passos_tempo - 1,1);

    for i = 2:passos_tempo
        
        amostras_instante_atual = sort(amostras(i,:));
        amostras_instante_anterior = sort(amostras(i-1,:));

        W(i-1) = nthroot(mean(abs(amostras_instante_atual-amostras_instante_anterior).^p),p);

    end

end