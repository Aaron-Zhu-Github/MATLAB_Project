% Horner's Method
% Group 33
% @author: HANWEN LIAO, ZHEN REN, JUNREN ZHU

clear;clc

%test cases:
%fileID = fopen('HornerTest1.txt','r');
%fileID = fopen('HornerTest2.txt','r');
%fileID = fopen('HornerTest3.txt','r'); %  -4.063123 -19.011954
%fileID = fopen('HornerTest4.txt','r');
%fileID = fopen('HornerTest5.txt','r');

%open file
fileID = fopen(file,'r');
scanner = fscanf(fileID,'%f');
fclose(fileID);

n = scanner(1);
x0 = scanner(length(scanner));

%create a list to hold a0 to an
a = [];
for i = 2:length(scanner)-1
    a(end+1) = scanner(i);    
end


%Calculate the value of P(x), 
%and return the a0 to a1 for calculating derivative
a1 = hornerValueOfP(n,a,x0);

%t is the intial time of prime (t = 1 means P'(x), t = 2 means P''(x))
t = 1;
hornerValueOfPPrime(n,a1,x0,t);
%for i = n − 1 downto 1

%This method use  horner to calculate the P(x),
%and return the array to hold a0 to a1 for calculating derivative
%@para: degree is the degree of the poly
%@para: coefficient is a array that hold (a0 to an)
%@para: x0 is the value that we use to calculate P(x)
function coefficientNew = hornerValueOfP(degree,coefficient,X0)
   newC = [];
   newC(end+1) = coefficient(end);
   alpha = coefficient(degree+1);
   %beta  = coefficient(degree+1);        

   for i = degree:-1:1
       alpha = alpha * X0 + coefficient(i);
       newC = [alpha newC];                        
   end 
   coefficientNew = newC;
   fprintf('P(x) = ');
   fprintf('%f\n',alpha);
   %fprintf('%f\n',newC);   
end

%This is a recursive method use horner to calculate the P'(x),P''(x)...Pn(x)
%@para: degree is the degree of the poly
%@para: coefficient is a array that hold (a0 to an)
%@para: x0 is the value that we use to calculate P(x)
%@para: timeOfPrime is time of prime (timeOfPrime = 1 means P'(x), timeOfPrime = 2 means P''(x))
function hornerValueOfPPrime(degree,coefficient,X0,timeOfPrime)
    %P'(x)    
    if(length(coefficient) == 1)
        return;
    end
    %create a array to hold new a0 to an
    newC = [];
    newC(end+1) = coefficient(end);
    beta = coefficient(degree+1);
    for i = degree:-1:2
        beta = beta * X0 + coefficient(i);
        newC = [beta newC];
    end
    coefficient = newC;
    %pn(x) = beta * timeOfPrime!
    result = beta * factorial(timeOfPrime);
    
    %print
    fprintf('P');
    s = repelem("'",1,timeOfPrime) ;
    fprintf('%s',s)
    fprintf('(x) = ');
    fprintf('%f\n',result);
    
    %recursive with updated value
    timeOfPrime = timeOfPrime+1;
    degree = degree - 1;
    hornerValueOfPPrime(degree,coefficient,X0,timeOfPrime);
end




