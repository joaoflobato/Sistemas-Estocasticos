function limites_ponderados = urnas_cauchy(minimo,maximo,x0,qtd_urnas)

limites_ponderados = x0*ones(1,qtd_urnas+1);
limites_ponderados([1,end]) = [minimo,maximo];

indice_metade = round((qtd_urnas+1)/2);



for indice_atual = 2:indice_metade-1

    lim_inferior = limites_ponderados(indice_atual - 1);
    lim_superior = limites_ponderados(indice_atual + 1);

    limites_ponderados(indice_atual) = (lim_inferior + lim_superior)/2;

end

for indice_atual = qtd_urnas:-1:indice_metade

    lim_inferior = limites_ponderados(indice_atual - 1);
    lim_superior = limites_ponderados(indice_atual + 1);

    limites_ponderados(indice_atual) = (lim_inferior + lim_superior)/2;

end


end