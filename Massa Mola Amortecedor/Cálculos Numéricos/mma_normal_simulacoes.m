clc
clear all
close all

addpath("../../Classes","../../Funções/")
%%
%Parâmetros do sistema

massa = 1;
const_mola = 1;
const_amortecedor = 0.1;

freq_ang_natural = sqrt(const_mola/massa);
amortecimento_crit = 2*massa*freq_ang_natural;
fator_amortecimento = const_amortecedor/amortecimento_crit;

%%
%Parâmetros da integração (Runge-Kutta)

condicoes_iniciais_mma = [0;0];
tempo_inicial = 0;
tempo_final = 150;
intervalo = [tempo_inicial , tempo_final];
passo = 0.02;

%%
%Parâmetros de Monte Carlo

media_teorica = 1;
desvio_padrao_teorico = 1/3;

amplitude_forca_teorica = [media_teorica ; desvio_padrao_teorico];
frequencia_forca_teorica = [media_teorica ; desvio_padrao_teorico]/(2*pi);

forcamentos = [];
respostas = [];
forcas_maximas_amostral = [];

vetor_media_forcas = [];
vetor_dp_forcas = [];

vetor_media_frequencias = [];
vetor_dp_frequencias = [];

frequecia_forcas_amostral = [];



tolerancia = 2*10^-3;
limite_minimo_amostras = 1000;
limite_maximo_amostras = 5000;
%%
%Simulações

contagem_amostras = 0;
vetor_qtd_amostras = [];
tic;

rng('default')      %Garante reprodutibilidade

while true
    
    intensidade_forca = random('Normal',media_teorica,desvio_padrao_teorico);
    freq_forca = random('Normal',media_teorica/(2*pi),desvio_padrao_teorico/(2*pi));

    forca_ext = @(t) intensidade_forca*cos(2*pi*freq_forca*t);

    equacao_mma = @(t,X) [0,1;-const_mola/massa,-const_amortecedor/massa]*X + [0;forca_ext(t)/massa];

    
    sist_mma = sistema(equacao_mma , condicoes_iniciais_mma , intervalo , passo);
    
    tempos = sist_mma.instantes;

    forcamento = forca_ext(tempos');

    forcamentos = [forcamentos;forcamento];

    forcas_maximas_amostral = [forcas_maximas_amostral,intensidade_forca];
    vetor_media_forcas = [vetor_media_forcas,mean(forcas_maximas_amostral)];
    vetor_dp_forcas = [vetor_dp_forcas,std(forcas_maximas_amostral)];

    frequecia_forcas_amostral = [frequecia_forcas_amostral,freq_forca];
    vetor_media_frequencias = [vetor_media_frequencias,mean(frequecia_forcas_amostral)];
    vetor_dp_frequencias = [vetor_dp_frequencias,std(frequecia_forcas_amostral)];

    respostas = [respostas,sist_mma.posicoes];

    
    contagem_amostras = 1 + contagem_amostras;
    vetor_qtd_amostras = [vetor_qtd_amostras,contagem_amostras];
    
    clc
    imprimirResiduos(contagem_amostras,tolerancia, ...
        [vetor_media_forcas(end),media_teorica;vetor_media_frequencias(end),media_teorica/(2*pi)], ...
        [vetor_dp_forcas(end),desvio_padrao_teorico;vetor_dp_frequencias(end),desvio_padrao_teorico/(2*pi)])

    %Mais de 1000 amostras, e convergência das médias dentro da tolerância.

    condicoes_parada = numel(forcas_maximas_amostral) >= limite_minimo_amostras;

    condicoes_parada = [condicoes_parada , abs(mean(forcas_maximas_amostral) - media_teorica) <= tolerancia];
    condicoes_parada = [condicoes_parada , abs(std(forcas_maximas_amostral) - desvio_padrao_teorico) <= tolerancia];

    condicoes_parada = [condicoes_parada , abs(mean(frequecia_forcas_amostral) - frequencia_forca_teorica(1)) <= tolerancia];
    condicoes_parada = [condicoes_parada , abs(std(frequecia_forcas_amostral) - frequencia_forca_teorica(2)) <= tolerancia];

    

    if all(condicoes_parada)

        fprintf("Todas as estatísticas convergiram em %d iterações\n",contagem_amostras)
        
        break
    elseif contagem_amostras > limite_maximo_amostras


        posicao_nao_convergencia = find(condicoes_parada == false);


        if any(posicao_nao_convergencia == 2)
            
            disp("Média das amplitudes não convergiu");

        end

        
        if any(posicao_nao_convergencia == 3)
            
            disp("Desvio padrão das amplitudes não convergiu");

        end

        if any(posicao_nao_convergencia == 4)
            
            disp("Média das frequências não convergiu");

        end

        if any(posicao_nao_convergencia == 5)
            
            disp("Desvio padrão das frequências não convergiu");

        end

        break
    end
    

end
tempo_execucao = toc;
fprintf("Tempo de execução: %.3f s\n",tempo_execucao)

save("Variáveis/variaveis mma normal.mat");