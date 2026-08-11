function x = resposta_mma(tempo,forcamento,massa,fator_amort,freq_natural)
    
    menor_passo = tempo(2) - tempo(1);
    fs = 1/menor_passo;
    n_amostras = numel(tempo);

    if fator_amort < 1
        freq_amort = freq_natural*sqrt(1-fator_amort^2);
        resposta_imp = 1/(massa*freq_amort)*exp(-fator_amort*freq_natural*tempo).*sin(freq_amort*tempo);
    elseif fator_amort == 1
        resposta_imp = tempo/massa.*exp(-fator_amort*freq_natural*tempo);
    else
        const_lambda = freq_natural*sqrt(fator_amort^2-1);
        resposta_imp = 1/(2*massa*const_lambda)*exp(-fator_amort*freq_natural*tempo).*(exp(const_lambda*tempo)-exp(-const_lambda*tempo));
    end

    x2 = conv(forcamento,resposta_imp)/fs;
    x = x2(1:n_amostras);

end