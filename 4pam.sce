//Exercício de Simulação
//Disciplina: Sistemas de Comunicação II
//Nome: Stéphanie Braga 
//Questão 1: Gerar sinalização M-aria (4pam)
//obs.:pulso retangular 

clc;
close;
clear;

//gera sinal
N=1000;
b=rand(1,N); //Gera matriz com valores N aleatórios entre 0 e 1.
x=round(b);  //arredonda os valores para 0 ou 1.

//x=[1 0 0 0 0 0 0 1 1 0];

nx=size(x,2);//retorna o número de colunas de x

bitResolution=10; //numero de amostras por cada simbolo da sequencia
bitTime=1;  //Tempo de bit
M=4;

//matriz de 4 linhas que indica o pulso a ser usado em cada simbolo. 
p=[ones(1,bitResolution)*-3;ones(1,bitResolution)*-1;ones(1,bitResolution);ones(1,bitResolution)*3];

//pre-atribuição para y. Matriz de 1 linha e nx*bitResolution colunas.
fator=log2(M);
y=zeros(1,(nx*bitResolution)/fator);
y2=zeros(1,(nx*bitResolution)/fator);

//n=20; //quantidade de bits da sequancia a serem plotados no gráfico
//Nshow=n*bitResolution;

//eixo de tempo para plotagem
timeAxis=[0:size(y,2)-1]*(bitTime/bitResolution);

//Gera AWGN
sig = 1; // Standard deviation of the white gaussian noise
noise = sig*rand(1,size(y,2)/bitResolution,"normal");


simb = zeros(1, nx/fator);
simb2 = zeros(1, nx/fator);

disp(size(noise,2));

//gera Sequencia 4-pam
i=1;j=1;
while j< nx+1
    start = 1+(bitResolution*(i-1));
    fim = i*bitResolution;
    
    if (x(1,j)==1)
        if ( x(1,j+1)==1)
            y(1,start:fim) = p(4,:);
            simb(i) = 3;
        else
            y(1,start:fim) = p(3,:);
            simb(i) = 1;
        end
        
    else
        if ( x(1,j+1)==1)
            y(1,start:fim) = p(2,:);
            simb(i) = -1;
        else
            y(1,start:fim) = p(1,:);
            simb(i) = -3;
        end
    end
    
    y2(1,start:fim) = y(1,start:fim) + noise(i);
    simb2(i) = simb(1) + noise(i);
    
    i=i+1;
    j=j+2;
end

poty = variance(simb);
disp(poty);

potn = variance(noise);
disp(potn);

snr = 10*log10(poty/potn);
disp(snr);

//detecção

i=1;erro=0;
while i< size(simb,2)+1
    if(abs(simb2(i)) >=2)
        sfinal(i)= 3* sign(simb2(i));
    else
        sfinal(i)= 1*sign(simb2(i));
    end
    
    if(sfinal(i) == simb(i))
    else
        erro = erro+1;
    end
    i=i+1;      
          
end

disp(erro);

//**Plotagens**//

//mostra os n primeiros bits do codigo de linha On-Off NRZ
figure;
subplot(2,1,1)
title('Sinal 4-PAM');
plot(timeAxis,y, "-o");
xgrid;


subplot(2,1,2)
title('Sinal 4-PAM com ruído');
plot(timeAxis,y2, "-o");
xgrid;



//Mostra o Diagrama de olho do sinal depois do canal
//subplot(3,1,2);
//title('Diag. de olho - sinal depois do canal');
//l1 = 1; l2 = 3; dif=l2-l1;
//t1=l1;t2=l2;
//lim=floor(N/l2);
//for k=1:lim
//    plot(t1:t2,y(l1:l2));
//    l1 = l2; l2 = l1 + dif;
//end
