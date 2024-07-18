function graficoEnvelope(tempo,media,borda,legendas)

%Se for vetor coluna, converter para vetor linha
if size(tempo,1) == numel(tempo)
    tempo = tempo';
end

if size(media,1) == numel(media)
    media = media';
end

if size(borda,1) == numel(borda)
    borda = borda';
end

topo = media+borda;
base = media-borda;
hold on
    h1 = plot(tempo,media,'b','LineWidth',2);
    h2 = fill([tempo fliplr(tempo)],[topo fliplr(base)],[0.7 0.9 1.0]);
hold off

uistack(h1,'top');

title(legendas(1),FontSize=20)
xlabel(legendas(2),FontSize=20);
ylabel(legendas(3),FontSize=20);
leg = legend(legendas(4),legendas(5));
grid on

end