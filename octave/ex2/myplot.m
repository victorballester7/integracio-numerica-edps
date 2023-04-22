% ------------------------------------------------------------
% Plots the analytic and numerical solutions of the 1D wave equation
% 
% Parameters:
%   a: wave speed
%   lamb: wave length
%   H: step size for plotting the analytic solutions
%   x0: initial x value
%   x1: final x value
%   t0: initial time
%   t1: final time
%   v: numerical solution
% ------------------------------------------------------------
function myplot(a, lamb, H, x0, x1, t1, scheme, mytitle)
  x = x0:H:x1;
  h1=1/10;h2=1/20;h3=1/40;h4=1/80;
  x_num1 = x0:h1:x1;
  x_num2 = x0:h2:x1;
  x_num3 = x0:h3:x1;
  x_num4 = x0:h4:x1;
  v1 = scheme(a,h1,lamb,x0,x1,t1);
  v2 = scheme(a,h2,lamb,x0,x1,t1);
  v3 = scheme(a,h3,lamb,x0,x1,t1);
  v4 = scheme(a,h4,lamb,x0,x1,t1);
  u = u0(x - t1);
  u_0 = u0(x);
  plot(x, u, 'g', x_num1, v1, 'color', [1 0.6 0.6], x_num2, v2, 'color', [1 0 0], x_num3, v3,'color', [0.6 0 0], x_num4, v4,'color', [0.2 0 0], x, u_0, 'b');
  legend(sprintf('Analytic solution at time t = %s',num2str(t1)), sprintf('Numerical solution at time t = %s with h = %s',num2str(t1), num2str(h1)), sprintf('Numerical solution at time t = %s with h = %s',num2str(t1), num2str(h2)), sprintf('Numerical solution at time t = %s with h = %s',num2str(t1), num2str(h3)), sprintf('Numerical solution at time t = %s with h = %s',num2str(t1), num2str(h4)),'Initial condition', 'Location', 'southoutside');
  title(mytitle);
  xlabel('t');
  ylabel('x');
end