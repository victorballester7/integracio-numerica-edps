% ----------------------------------
% 2D function
% ----------------------------------
% Source term in the PDE
%
% Input:
%   x,y - coordinates 
%
% Output:
%   z - value of the function
% ----------------------------------
function z = f(x,y)
  % z = 2 * (x .^ 2 + y .^ 2 - x - y);
  z = 2 * x .* y .* exp(x + y) .* (x .* y + x + y - 3);
  % z = 2 * x .* (x .^ 3 - x .^ 2 + 6* x .* (y.^2-y) - 3*y.^2+3*y);
end