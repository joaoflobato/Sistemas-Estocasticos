function [valores_norm,suporte] = tabela_contagens(dados,qtd_urnas)
    
    
    if any(size(dados)==1)

        figure (1000)
        histograma = histogram(dados,qtd_urnas,Normalization="pdf");
        urnas = histograma.BinEdges;
        valores_norm = histograma.Values;
        close Figure 1000
    
        suporte = urnas(1:end-1);
    else
        if numel(qtd_urnas)==1
            vetor_urnas = qtd_urnas*ones(1,2);
        else
            vetor_urnas = qtd_urnas;
        end
        
        figure (2000)
        histograma = histogram2(dados(:,1),dados(:,2),NumBins=vetor_urnas,Normalization="pdf");
        close Figure 2000


    end


end