% -------------------------------------------------
%  laplace5Matrix.m
% -------------------------------------------------
%  This function creates the matrix A of the scheme with 9 points of the laplace operator. We have chosen the order of variables, from lef to right and from bottom to top.
%
% Inputs:
%   n: number of points of the grid in the x direction
%   m: number of points of the grid in the y direction
% 
% Outputs:
%   A: matrix of the scheme with 9 points of the laplace operator
% -------------------------------------------------
function A = laplace9Matrix(n, m)
% A = zeros(n*m, n*m);
A = sparse(n*m, n*m);
A(1:n,1:n) = triDiag(n,-20,4,4); % first block of the matrix (Note: I separate the first block because this way I can remove an if in the loop)
for i = 2:m
  A((i-1)*n+1:i*n, (i-1)*n+1:i*n) = triDiag(n,-20,4,4);
  A((i-1)*n+1:i*n, (i-2)*n+1:(i-1)*n) = triDiag(n,4,1,1);
  A((i-2)*n+1:(i-1)*n, (i-1)*n+1:i*n) = triDiag(n,4,1,1);
end