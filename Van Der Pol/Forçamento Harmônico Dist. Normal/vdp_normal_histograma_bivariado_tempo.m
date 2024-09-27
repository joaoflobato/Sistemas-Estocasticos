vdp_normal_pos_processamento;

%%
%Histograma bivariado

tamanho_vetor_tempo = numel(tempos);
amostras = [repmat(tempos,contagem_amostras,1),reshape(respostas,tamanho_vetor_tempo*contagem_amostras,1)];

figura = figure;
figura.Position = [675,249,940,713];

gerarHistograma(amostras,[round(sqrt(tamanho_vetor_tempo)/2),round(sqrt(contagem_amostras)/2)], ...
    ["Histograma Normalizado";"das Respostas ao Longo do Tempo"], ...
    "Tempo (s)", ...
    "Posição (m)")