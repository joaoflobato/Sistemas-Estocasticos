function div_JS = divergencia_JS(histograma1,histograma2,largura_urnas)


    histograma_medio = (histograma1+histograma2)/2;

    div_JS = (divergencia_KL(histograma1,histograma_medio,largura_urnas) + divergencia_KL(histograma2,histograma_medio,largura_urnas))/2;

end