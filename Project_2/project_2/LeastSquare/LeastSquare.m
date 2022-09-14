% Least Square method
% Group 33
% @author: HANWEN LIAO, ZHEN REN, JUNREN ZHU

clear;clc

fileID = fopen('LeastSquare.txt','r');
%fileID = fopen('LeastSquare1.txt','r');
%fileID = fopen('LeastSquare2.txt','r');
%fileID = fopen('LeastSquare3.txt','r');
%fileID = fopen('LeastSquare4.txt','r');

scanner = fscanf(fileID,'%f');
fclose(fileID);

numOfPoints = scanner(1);
degree = scanner(2);

%put the x y in order to A and B
%x=[0;1;2;3;4;5;6;7;8;9];
%y=[45.13;51.71;60.17;64.83;65.24;65.17;67.65;79.8;96.13;115.19];
Awithzeros = [];
Bwithzeros = [];
count = 1;
for i = 3:2:numOfPoints*2 + 1
    Awithzeros(i)= scanner(i);
end

for i = 4:2:numOfPoints*2 + 2
    Bwithzeros(i) = scanner(i);
end

%clear all zeros 
A = nonzeros(Awithzeros);
B = nonzeros(Bwithzeros);

a = 0; 
k = 0; 
A = [A(1:k,:); a; A(k+1:end,:)];


%set up matrix M
%M=[10, sum(x), sum(x.^2), sum(x.^3);
%sum(x), sum(x.^2), sum(x.^3), sum(x.^4);
%sum(x.^2), sum(x.^3), sum(x.^4), sum(x.^5);
%sum(x.^3), sum(x.^4), sum(x.^5), sum(x.^6)];
%MatrixA = zeros(degree+1,degree+1);

for i = 1:1
    for j = 1:degree+1
        if(i == 1 && j == 1)
            MatrixA(1,1) = numOfPoints;
        else
            MatrixA(i,j) = sum(A.^count);
            count = count + 1;
        end
    end
end

for i = 2:degree+1
    count = i - 1;
    for j = 1:degree+1
        if(i == 1 && j == 1)
            MatrixA(1,1) = numOfPoints;
        else
            MatrixA(i,j) = sum(A.^count);
            count = count + 1;
        end
    end
end

%set up matrix B
%sumy, sumy*x^1, sumyx^2.... sumy^x^n
%b=[sum(y);sum(y.*x);sum(y.*(x.^2));sum(y.*(x.^3))];
countB = 0;
MatrixB = zeros(degree+1,1);  
for i = 1:degree +1
    MatrixB(i) = sum(B.*(A.^countB));
    countB = countB + 1;
end

% get the Coefficients
% a=inv(M)*b;
Coefficients = MatrixA\MatrixB;
for i = 1:degree+1
    fprintf('%f ',Coefficients(i))
end

%graph
%xx=[0:0.1:9];
%yy=a(1) + a(2)*xx + a(3)*xx.^2 + a(4)*xx.^3;
%plot(xx,yy,x,y,%*’);
CountC = 0;
xx = A(1):0.1:numOfPoints;
yy = 0;
for i = 1:degree +1
    yy = yy + Coefficients(i)*xx.^CountC;
    CountC  = CountC + 1;
end

plot(xx,yy,A,B,'*');