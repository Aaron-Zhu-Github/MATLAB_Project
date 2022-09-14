% Newton with horner method
% Group 33
% @author: HANWEN LIAO, ZHEN REN, JUNREN ZHU

clear;clc

%test cases:
% fileID = fopen("NewtonWithHornerTest1.txt",'r');
% fileID = fopen("NewtonWithHornerTest2.txt",'r');
% fileID = fopen("NewtonWithHornerTest3.txt",'r');
% fileID = fopen("NewtonWithHornerTest4.txt",'r');
% fileID = fopen("NewtonWithHornerTest5.txt",'r');

%open file
fileID = fopen(file,'r');
scanner = fscanf(fileID,'%f');
fclose(fileID);
%read degree from file
n = scanner(1);
%read x0 from file
x0 = scanner(length(scanner)-2);
%read epsilon from file
epsilon = scanner(length(scanner)-1);
%read N from file
N = scanner(length(scanner));
%creat a list to hold a0 to a1
a = [];
for i = 2:length(scanner)-3
    a(end+1) = scanner(i);   
end

%Newton with horner, loop of maximum iteration
for i = 1:N    
    %use horner to calculate x1
    x1 = x0 - honer(n,a,x0);
    %check error
    error = abs(x0-x1);
    %return root, if error < epsilon
    if error <= epsilon        
        root = x1;
        fprintf('P(x) = %f\n',root);
        break
    else
        x0 = x1;
    end
    %no-solution demo: i reach max while error > epsilon
    if i ==N
        if error > epsilon
            fprintf('Solution was not found');
        end
    end
end

%horner method that return p(x)/p'(x)
function Q = honer(degree,coefficient,X0)
    
    %intialize alpha and beta as an
    alpha = coefficient(degree+1);
    beta  = coefficient(degree+1);
    
    %for i = n − 1 downto 1
    for i = degree:-1:1
        %calculate alpha
        alpha = alpha * X0 + coefficient(i);
        if i > 1
            %calculate beta
            beta  = beta * X0 + alpha;
        end
    end
    Q = alpha/beta;

end