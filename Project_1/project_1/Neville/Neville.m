% Neville method
% Group 33
% @author: HANWEN LIAO, ZHEN REN, JUNREN ZHU

clear;clc

%test cases:
% fileID = fopen('NevilleTest1.txt','r');
% fileID = fopen('NevilleTest2.txt','r');
% fileID = fopen('NevilleTest3.txt','r');
% fileID = fopen('NevilleTest4.txt','r');
% fileID = fopen('NevilleTest5.txt','r');


% user input
fileID = fopen(file,'r');
userInput = fscanf(fileID,'%f');
fclose(fileID);

% assign first number to n
n = userInput(1);
% assign last number to x0
x0 = userInput(2*(n+2));

% set x zero list and y zero list for next steps
x = zeros(n+1, 1);
y = zeros(n+1, 1);

% assign pairs xi yi to x list and y list
for i=1:n+1
    x(i) = userInput(2*i);
    y(i) = userInput(2*i + 1);
end


% recall the neville function and print results for P(x0)
P = neville(n, x0, x, y);
fprintf('P(');
fprintf('%s',num2str(x0));
fprintf(') = %s', num2str(P));
%fprintf(') = %.2f', P);


% define neville function using the Neville's Method
function P = neville(n,x0,x,y)

    P = zeros(n+1,n+1);
    % set diagonal values
    for i = 1:n+1
        P(i,i) = y(i);
    end

    % calulation using the Neville's Method
    for d = 1:n
        for i = 1:n+1-d
            P(i,d+i) = (P(i+1,d+i)*(x0-x(i)) - P(i,d+i-1)*(x0-x(d+i)))/(x(d+i)-x(i));
        end
    end

    % output
    P = P(1,n+1); 
end

