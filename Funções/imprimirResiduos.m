function imprimirResiduos(contagem_amostras,tolerancia,medias,desv_pads)


if any(size(medias)>1)

    media_forca_exp = medias(1,1);
    media_forca_teo = medias(1,2);

    media_freq_exp = medias(2,1);
    media_freq_teo = medias(2,2);


    desv_pad_forca_exp = desv_pads(1,1);
    desv_pad_forca_teo = desv_pads(1,2);

    desv_pad_freq_exp = desv_pads(2,1);
    desv_pad_freq_teo = desv_pads(2,2);




    residuos_media_forca = abs(media_forca_teo - media_forca_exp);
    residuos_dp_forca = abs(desv_pad_forca_teo - desv_pad_forca_exp);

    residuos_media_freq = abs(media_freq_teo - media_freq_exp);
    residuos_dp_freq = abs(desv_pad_freq_teo - desv_pad_freq_exp);

    fprintf("Contagem de Amostras: %d \nTolerância: %.3f\nResíduos das médias das forças: %.3f\nResíduos das médias das frequências: %.3f\n" + ...
        "Resíduos dos desvios padrões das forças: %.3f\nResíduos dos desvios padrões das frequências: %.3f\n", ...
        contagem_amostras,tolerancia,residuos_media_forca,residuos_media_freq,residuos_dp_forca,residuos_dp_freq)

end


end