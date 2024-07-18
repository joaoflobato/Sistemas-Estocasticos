function [varredura_freq,espectro] = transf_fourier(tempo,sinal)

    delta_t = mean(diff(tempo));
    tempo = 0:delta_t:2;
    freq = delta_t^-1;
    
    
    tamanho_sinal = numel(sinal);
    varredura_freq = linspace(-freq/2,freq/2,tamanho_sinal);
    
    
    espectro = abs(fftshift(fft(sinal)));

end