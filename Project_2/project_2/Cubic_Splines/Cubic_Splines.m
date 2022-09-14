%import data 
file = fopen('CS_test_1.txt','r');
data = fscanf(file,'%f\n');

%assign first number corresponds to the number of points
n = data(1);

%assign x, y to array
p = zeros(n,2);
count = 1;
for i = 2:2:n*2 + 1    
    p(count,1) = data(i);
    p(count,2) = data(i+1);
    count = count + 1;
end

%assign (h0 - hx)
h = zeros(n-1,1);
for i = 1:n-1
    h(i) = p(i+1,1) - p(i,1);
end

%create matrix
m = zeros(n,n);
m(1,1) = 1;
m(n,n) = 1;
for i = 1:n
    if i == 1
        m(i+1,i) = h(i);
        continue;
    end
    if i == n
        m(n-1,n) = h(i-1);
    else
        m(i,i) = 2*(h(i)+h(i-1));
        m(i-1,i) = h(i-1);
        m(i+1,i) = h(i);
    end
end

m(1,2) = 0;
m(n,n-1) = 0;

%assign vector
v = zeros(n,1);
for i = 2:n-1
    v(i) = 3*((p(i+1,2)-p(i,2))/h(i) - (p(i,2)-p(i-1,2))/h(i-1));
end

%get 'c'
c = linsolve(m,v);

%get 'b'
b = zeros(n-1,1);

%get 'd'
d = zeros(n-1,1);

for i = 1:n-1
    d(i) = (c(i+1)-c(i))/(3*h(i));
    b(i) = ((p(i+1,2)-p(i,2))/h(i)) - h(i)*((2*c(i)+c(i+1))/3);
end

%get coefficients
for i = 1:n-1
    fprintf('%f ',p(i,2));
    fprintf('%f ',b(i));
    fprintf('%f ',c(i));
    fprintf('%f\n',d(i));
end

%draw graph
for i = 1:n-1
    x = linspace(p(i,1),p(i+1,1),20);
    y = p(i,2) + b(i)*(x-p(i,1)) + c(i)*(x-p(i,1)).^2 + d(i)*(x-p(i,1)).^3;
    plot(x,y);
    hold on;
end
hold off

fclose(file);