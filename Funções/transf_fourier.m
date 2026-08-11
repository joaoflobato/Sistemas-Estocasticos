function [varredura_freq,espectro] = transf_fourier(tempo,sinal)

    delta_t = diff(tempo);
    delta_t = delta_t(1);
    amostragem = delta_t^-1;
    duracao = tempo(end);
    
    
    tamanho_sinal = numel(sinal);
    varredura_freq = linspace(-amostragem/2,amostragem/2,tamanho_sinal);
    
    
    espectro = abs(fftshift(fft(sinal)))*8*pi^2/(amostragem*duracao);

end