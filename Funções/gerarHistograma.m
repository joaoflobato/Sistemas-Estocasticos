function gerarHistograma(dados,divisoes,titulo,legenda_x,legenda_y)

    if any(size(dados)==1)

        histogram(dados,divisoes,Normalization="pdf")

        title(titulo,FontSize=20)
        xlabel(legenda_x,FontSize=20)
        ylabel(legenda_y,FontSize=20)
    else
        if size(dados,1)==1
            dados = dados';
        end
        
        if numel(divisoes) == 1
            divisoes = divisoes*ones(1,2);
        end

        histogram2(dados(:,1),dados(:,2),NumBins=divisoes,Normalization="pdf")

        title(titulo,FontSize=20)
        xlabel(legenda_x,FontSize=20)
        ylabel(legenda_y,FontSize=20)
        zlabel("Frequência Relativa",FontSize=20)

    end

end