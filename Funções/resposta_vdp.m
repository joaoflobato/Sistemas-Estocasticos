function x = resposta_vdp(tempo,forcamento,massa,alpha,rigidez,cond_iniciais)
    
    menor_passo = tempo(2) - tempo(1);
    fs = 1/menor_passo;
    

    forca = @(t) forcamento(round(fs*t+1));

    funcao_acel = @(t,vetor_x) [vetor_x(2);1/massa*(forca(t)+alpha*(1-vetor_x(1)^2)*vetor_x(2)-rigidez*vetor_x(1))];
    [~,X] = ode45(funcao_acel,tempo,cond_iniciais);

    x = X(:,1)';



end