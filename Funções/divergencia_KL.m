function div_KL = divergencia_KL(histograma1,histograma2,passo)

histograma1 = histograma1 + 10^-10;
histograma2 = histograma2 + 10^-10;

div_KL = sum(histograma1.*log(histograma1./histograma2),"all")*prod(passo);


end