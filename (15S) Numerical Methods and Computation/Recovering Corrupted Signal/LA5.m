clear all;

%Load the data
load dat.mat;

%Get the size of the signal
n=(size(g));
n=n(1,1);

%Get the convolution Matrix
clear A;
A=convmtx(h,n);
A=A(:,3:n+2);

%Plot the corrupted Signal
X=(1:1024);
subplot(4,1,1);
plot(X,g(1:1024,:),'g');
title('Corrupted Signal');
drawnow;


%-------------Least Square Method-------------
f_LS = (A'*A)\(A'*g);

subplot(4,1,2);
plot(X,f_LS(1:1024,:),'b');
title('Least Squares');
drawnow;
clear f_LS;

%-------------Steepest Descent Method-------------
b_SD = A'*g;
A_SD = A'*A;
x_i = zeros(n,1);

subplot(4,1,3);
i=0;
while 1
    r_i = b_SD - A_SD*x_i;
    a_i = (r_i'*r_i)/(r_i'*A_SD*r_i);
    x_prev = x_i;
    x_i = x_i + a_i * r_i;
    i=i+1;
    
    plot(X,x_i(1:1024,:),'r');
    title(sprintf('Steepest Descent (%d)',i));
    drawnow;
    
    if mean(abs(x_i - x_prev)) < 1e-5
        break
    end
    
end

clear A_SD;
clear b_SD;


%-------------Conjugate Gradient Method-------------
f_CG = zeros(n,1);
bs = A' * g;
As = A' * A;

%Initial Setup
ui = zeros(n,1);
di = bs - As*ui;
ri = di;

%Loop through this procedure
subplot(4,1,4);
i=0;
while(1) 
    alphai = (ri'*ri) / (di'*As*di);
    uPrev  = ui;
    ui     = ui + alphai*di;
    rPrev  = ri;
    ri     = ri - alphai*As*di;
    betaj  = (ri'*ri) / (rPrev'*rPrev);
    di     = ri + betaj*di;
    
    %Plot
    i=i+1;
    plot(X,ui(1:1024,:),'c');
    title(sprintf('Conjugate Gradient (%d)',i));
    drawnow;
    
    if( mean(abs(uPrev - ui)) < 1e-5 )
        break;
    end
    

end

f_CG = ui;

%-------------Estimating the value of h-------------
f= f_CG;

%Construct matrix to use LS
f1 = [0;0;f(1:n-2,:)];
f2 = [0;f(1:n-1,:)];
f4 = [f(2:n,:);0];
f5 = [f(3:n,:);0;0];

%Use LS to estimate h
F=[f1,f2,f,f4,f5];
h_est = pinv(F'*F)*F'*g;
display(h_est');

%Compare with the actual given h
display(h);
