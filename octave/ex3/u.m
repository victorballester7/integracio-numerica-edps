% --------------------------------------------------------------
% u(x,y)
% --------------------------------------------------------------
% Solution to the problem u_xx + u_yy = f with homogeneous Dirichlet boundary conditions
% 
% Input:
%  x,y - coordinates
%
% Output:
%  u(x,y)
% --------------------------------------------------------------
function sol = u(x, y)
% sol = x .* (1 - x) .* y .* (1 - y);
sol = x .* (1 - x) .* y .* (1 - y) .* exp(x + y);
% sol = x .* (1 - x) .* y .* (1 - y) .* x .^ 2;
end