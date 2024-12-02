function y = respostaAnalitica(t,cond_iniciais,freq_ang_natural,freq_ang_amort,fator_amort,amplitude_forca_norm,freq_ang_forca)

    posicao_inicial = cond_iniciais(1);
    velocidade_inicial = cond_iniciais(2);
    
    dif_quad_freqs = freq_ang_natural^2 - freq_ang_forca.^2;
    tempo_carac = 2*fator_amort*freq_ang_natural*freq_ang_forca;
    A_den = dif_quad_freqs.^2 + tempo_carac.^2;
    
    K_1 = amplitude_forca_norm./A_den;
    resposta_permanente = K_1.*(dif_quad_freqs.*cos(freq_ang_forca.*t)+tempo_carac.*sin(freq_ang_forca.*t));

    if fator_amort < 1
        
        freq_ang_amort = freq_ang_natural*sqrt(1-fator_amort^2);
        K_2 = posicao_inicial - amplitude_forca_norm.*dif_quad_freqs./A_den;
        
        B_1 = K_2;
        B_2 = velocidade_inicial / freq_ang_amort - tempo_carac.*freq_ang_forca.*amplitude_forca_norm./(freq_ang_amort.*A_den);
        K_3 = fator_amort*freq_ang_natural / freq_ang_amort*B_1 + B_2;

        resposta_transiente = exp(-fator_amort*freq_ang_natural*t).*(K_2.*cos(freq_ang_amort.*t)+K_3.*sin(freq_ang_amort.*t));
    elseif fator_amort == 1

        K_4 = posicao_inicial - K_1.*dif_quad_freqs;
        K_5 = velocidade_inicial - tempo_carac.*freq_ang_forca.*K_1;

        resposta_transiente = (K_4 + K_5.*t).*exp(-freq_ang_natural*t);

    else

        lambda_1 = freq_ang_natural*(-fator_amort + sqrt(fator_amort^2-1));
        lambda_2 = freq_ang_natural*(-fator_amort - sqrt(fator_amort^2-1));

        K_6 = (velocidade_inicial - tempo_carac.*freq_ang_forca.*K_1 - lambda_2.*(posicao_inicial - K_1.*dif_quad_freqs))./(lambda_1-lambda_2);
        K_7 = posicao_inicial - K_1.*dif_quad_freqs - K_6;

        resposta_transiente = K_6.*exp(lambda_1.*t) + K_7.*exp(lambda_2.*t);


    end

    
    
    
    y =  resposta_permanente + resposta_transiente;

end