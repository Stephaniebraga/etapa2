//Exercício de Simulação
//Disciplina: Sistemas de Comunicação II
//Nome: Stéphanie Braga 
//Questão 2: Gerar sinalização M-aria (8pam)
//obs.:pulso retangular 

clc;
close;
clear;

M=8;
fator=log2(M);
//gera sinal
N=5*fator;
b=rand(1,N); //Gera matriz com valores N aleatórios entre 0 e 1.
x=round(b);  //arredonda os valores para 0 ou 1.

//x=[1 0 0 0 0 0 0 1 1 0 1 1];

nx=size(x,2);//retorna o número de colunas de x

bitResolution=10; //numero de amostras por cada simbolo da sequencia
bitTime=1;  //Tempo de bit

//matriz de 4 linhas que indica o pulso a ser usado em cada simbolo. 
p=[ones(1,bitResolution)*-7;ones(1,bitResolution)*-5;ones(1,bitResolution)*-3;ones(1,bitResolution)*-1;ones(1,bitResolution);ones(1,bitResolution)*3;ones(1,bitResolution)*5;ones(1,bitResolution)*7];

//pre-atribuição para y. Matriz de 1 linha e nx*bitResolution colunas.
y=zeros(1,(nx*bitResolution)/fator);

//n=20; //quantidade de bits da sequancia a serem plotados no gráfico
//Nshow=n*bitResolution;

//eixo de tempo para plotagem
timeAxis=[0:size(y,2)-1]*(bitTime/bitResolution);

//gera Sequencia 4-pam
i=1;j=1;
while j< nx+1
    start = 1+(bitResolution*(i-1));
    fim = i*bitResolution;
    
    if (x(1,j)==1)
        if ( x(1,j+1)==1)
            if ( x(1,j+1)==1)
                y(1,start:fim) = p(8,:);
            else
                y(1,start:fim) = p(7,:);
            end
        else
            if ( x(1,j+1)==1)
                y(1,start:fim) = p(6,:);
            else
                y(1,start:fim) = p(5,:);
            end
        end
        
    else
        if ( x(1,j+1)==1)
            if ( x(1,j+1)==1)
                y(1,start:fim) = p(4,:);
            else
                y(1,start:fim) = p(3,:);
            end
        else
            if ( x(1,j+1)==1)
                y(1,start:fim) = p(2,:);
            else
                y(1,start:fim) = p(1,:);
            end
        end
    end
    i=i+1;
    j=j+fator;
end

//**Plotagens**//

//mostra os n primeiros bits do codigo de linha On-Off NRZ
figure;
title('Sinal 4-PAM');
plot(timeAxis,y, "-o");
xgrid;
