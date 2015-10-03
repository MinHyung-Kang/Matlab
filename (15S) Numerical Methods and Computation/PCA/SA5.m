clear all;

%Read the data
load dat.mat;


%Get the dimension
%n = number of pixels in each image
%m = number of images
[n,m] = size(D);

%Cast for computation
D=im2double(D);    

%Make the data center around zero
mu = mean(D')';
Dnew = zeros(n,m);
for i = 1:m
    Dnew(:,i) = (D(:,i) - mu);
end

%Since n>>m, We compute the covariance Matrix of M'M, and get its
%eigenvectors
SmallerC = Dnew.' * Dnew;

[V,E] = eig(SmallerC); 
%Get the eigenvectors of desired covariance matrix
Eigen = Dnew*V;

%Normalize all the eigenvectors
for i = 1:m
    Norm = norm(Eigen(:,i));
    Eigen(:,i) = Eigen(:,i) / Norm; 
end

%Sort the eigenvalues and corresponding eigenvectors, 
%Get three largest eigenvalue eigenvectors
[a,b]=sort(diag(E),'descend');
Eigen = Eigen(:,b);
Max3Eigen = Eigen(:,1:3);
display(a(1:3));

%Reshape the max 3 eigen vectors in square matrix form and display them
%to see what they look like

first = reshape(Max3Eigen(:,1),256,256);
second = reshape(Max3Eigen(:,2),256,256);
third = reshape(Max3Eigen(:,3),256,256);
Ifirst = mat2gray(first);
Isecond = mat2gray(second);
Ithird = mat2gray(third);
imshow(Ifirst);
title('First Maximum eigenvector');
pause;
imshow(Isecond);
title('Second Maximum eigenvector');
pause;
imshow(Ithird);
title('Third Maximum eigenvector');
pause;

%Project onto three dimensions
%Each column represents a three dimensional representation of image
DProject = Max3Eigen.' * Dnew;

%Compute center of mass
COM = [mean(DProject(1,:));mean(DProject(2,:));mean(DProject(3,:))];
display(COM);

%Compute Euclidean Distance
Norm = zeros(1,m);
for i=1:m
   Norm(1,i) = norm(DProject(:,i) - COM) ;
end

%Show the image furthest from the COM
[Max,I] = max(Norm);
result = reshape(D(:,I),256,256);
str = sprintf('Image %d',I);
imshow(result);
title(str);

