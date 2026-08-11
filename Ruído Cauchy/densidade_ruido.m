mma_ruido_cauchy
%% Cores

meuVerde = [9,133,66]/255;
meuVermelho = [195, 40, 30]/255;
meuPreto = [7, 3, 8]/255;
meuAzul = [51, 51, 179]/255;
meuRoxo = [150,30,119]/255;
meuLaranja = [243,156,18]/255;

minhasCores = [meuVermelho;meuPreto;meuAzul;meuVerde;meuLaranja;meuRoxo];
%% Correlação

n_amostras = fs-1;
if mod(n_amostras,2) == 0
    
    n_amostras = n_amostras - 1;
    
end
realizacoes_ruido_cauchy = realizacoes_ruido_cauchy(:,1:n_amostras);

correlacao_forcamentos = 1/qtd_realizacoes*(realizacoes_ruido_cauchy'*realizacoes_ruido_cauchy);
correlacao_forcamentos_diag = diag(flip(correlacao_forcamentos,2));

%% Densidade espectral

varredura_freq = linspace(-fs/2,fs/2,n_amostras);
espectro = abs(fftshift(fft(correlacao_forcamentos_diag)));

plot(varredura_freq,espectro,Color=meuVermelho,LineWidth=3)
%stem(varredura_freq,espectro,"filled",Color=meuVermelho)
set(gca,'fontsize',15)

xlim([-1.1*fs/2,1.1*fs/2])
ylim([0,2*max(espectro)])
xticks(linspace(-fs/2,fs/2,5))

title("$\mathbf{f}$ Spectral Density for $t \in [0,1]$ s",FontSize=20,Interpreter="latex")
xlabel("Frequency [Hz]",FontSize=20,Interpreter="latex")
ylabel("$\mathcal{F}(\omega)$",FontSize=20,Interpreter="latex")