classdef sistema
    

    properties
        equacao;
        condicoes_iniciais;
        passo_integracao;
        instantes;
        posicoes;
        velocidades;
    end

    methods
        function obj = sistema(eq,CI,intervalo,passo)
            obj.equacao = eq;
            obj.condicoes_iniciais = CI;
            obj.passo_integracao = passo;


            [obj.instantes,X] = ode45(obj.equacao,intervalo(1):obj.passo_integracao:intervalo(2),obj.condicoes_iniciais);

            obj.posicoes = X(:,1);
            obj.velocidades = X(:,2);

        end

        function graficos_tempo(obj,rotulos)
            
            
            figure
            plot(obj.instantes,obj.posicoes)
            
       
            if nargin < 2
                rotulos = nan;
            elseif numel(rotulos) == 1;

                    titulo = rotulos;

                    title(titulo)

            elseif numel(rotulos) == 2;

                    eixo_x = rotulos(1);
                    eixo_y = rotulos(2);

                    xlabel(eixo_x)
                    ylabel(eixo_y)

            elseif numel(rotulos) == 3;

                    titulo = rotulos(1);
                    eixo_x = rotulos(2);
                    eixo_y = rotulos(3);

                    title(titulo)
                    xlabel(eixo_x)
                    ylabel(eixo_y)
            end
            
        end

        function diagrama_fase(obj,rotulos)

            
            figure
            plot(obj.posicoes,obj.velocidades);
            
            
       
            if nargin < 2
                rotulos = nan;
            elseif numel(rotulos) == 1;

                    titulo = rotulos;

                    title(titulo)

            elseif numel(rotulos) == 2;

                    eixo_x = rotulos(1);
                    eixo_y = rotulos(2);

                    xlabel(eixo_x)
                    ylabel(eixo_y)

            elseif numel(rotulos) == 3;

                    titulo = rotulos(1);
                    eixo_x = rotulos(2);
                    eixo_y = rotulos(3);

                    title(titulo)
                    xlabel(eixo_x)
                    ylabel(eixo_y)
            end

        end


    end
end