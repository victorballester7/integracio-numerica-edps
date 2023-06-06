% --------------------------------------------------------------
% Compute the tridiagonal matrix
% --------------------------------------------------------------
% Computes a tridiagonal matrix with the given coefficients
%
% Inputs:
%   n: size of the matrix
%   diag_coeff: coefficient of the diagonal
%   upper_coeff: coefficient of the upper diagonal
%   lower_coeff: coefficient of the lower diagonal  
%
% Outputs:
%   A: tridiagonal matrix
% --------------------------------------------------------------
function A = triDiag(n,diag_coeff,upper_coeff,lower_coeff)
  A = eye(n) * diag_coeff;
  A = A + diag(ones(n-1,1)*upper_coeff,1) + diag(ones(n-1,1)*lower_coeff,-1);
end
    