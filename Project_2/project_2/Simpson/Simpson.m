% Newton with horner method
% Group 33
% @author: HANWEN LIAO, ZHEN REN, JUNREN ZHU

clear;clc
%open file
%test cases:
scanner = readlines("SimpsonTest5.txt");
% scanner = readlines("SimpsonTest2.txt");
% scanner = readlines("SimpsonTest3.txt");
% scanner = readlines("SimpsonTest4.txt");
% scanner = readlines("SimpsonTest5.txt");

%read f(x) from file
eqs = inline(scanner(1),'x');
%read a & b from file
a = str2num(scanner(2));
b = str2num(scanner(3));
%read n from file
n = str2num(scanner(length(scanner)));
%h
h = (b - a) / n;
%k
k = n / 2;

%hold xi(even) from i= 1 to n-1
x_even = [];
for i = 1:(n-1)
    if (mod(i,2) == 0)
        x_even(end+1) = a + i * h;
    end
end
%sount sum
sum_even = 0;
for i = 1:length(x_even)
    sum_even = sum_even + feval(eqs,x_even(i));
end

%hold xi(odd) from i= 1 to n-1
x_odd = [];
for i = 1:n
    if (mod(i,2) == 1)
        x_odd(end+1) = a + i * h;
    end
end
%count sum
sum_odd = 0;
for i = 1:length(x_odd)
    sum_odd = sum_odd + feval(eqs,x_odd(i));
end

%result = (h/3) * (f(x0) + 2 * sum of f(even) + 4sum of f(odd) +f(xn) )
result = (h/3) * (feval(eqs,a) + 2 * sum_even + 4 * sum_odd + feval(eqs,b));
%print
fprintf('The approximate value of f(x) = ');
fprintf('%f\n',result);
