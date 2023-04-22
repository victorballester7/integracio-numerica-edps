% ------------------------------------------------------------
% Plots the analytic and numerical solutions of the 1D wave equation
% 
% Parameters:
%   h: spatial step size
%   H: spatial step size for analytic solution
%   x0: initial x value
%   x1: final x value
%   t0: initial time
%   t1: final time
%   v: numerical solution
% ------------------------------------------------------------
function myplotdiv(h, H, x0, x1, t1, v, mytitle)
  x = x0:H:x1;
  x_num = x0:h:x1;
  u = u0(x - t1);
  u_0 = u0(x);
  plot(x, u, 'g', x_num, v, 'r', x, u_0, 'b');
  legend(sprintf('Analytic solution at time t = %s',num2str(t1)), sprintf('Numerical solution at time t = %s with h = %s',num2str(t1), num2str(h)), 'Initial condition', 'Location', 'southoutside');
  title(mytitle);
  xlabel('t');
  ylabel('x');
end