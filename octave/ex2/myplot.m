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
  [v1, temp, temp] = scheme(a,h1,lamb,x0,x1,t1);
  [v2, temp, temp] = scheme(a,h2,lamb,x0,x1,t1);
  [v3, temp, temp] = scheme(a,h3,lamb,x0,x1,t1);
  [v4, temp, temp] = scheme(a,h4,lamb,x0,x1,t1);
  u = u0(x - t1);
  u_0 = u0(x);
  xlim([0.6,0.8]);
  lineW=3;
  plot(x, u, 'g', "linewidth", lineW, x_num1, v1, 'color', [1 0.6 0.6], "linewidth", lineW, x_num2, v2, 'color', [1 0 0],"linewidth", lineW, x_num3, v3,'color', [0.6 0 0],"linewidth", lineW, x_num4, v4,'color', [0.2 0 0],"linewidth", lineW, x, u_0, 'b',"linewidth", lineW);
  l=legend(sprintf('Analytic solution at time t = %s',num2str(t1)), sprintf('Numerical solution at time t = %s with h = %s',num2str(t1), num2str(h1)), sprintf('Numerical solution at time t = %s with h = %s',num2str(t1), num2str(h2)), sprintf('Numerical solution at time t = %s with h = %s',num2str(t1), num2str(h3)), sprintf('Numerical solution at time t = %s with h = %s',num2str(t1), num2str(h4)),'Initial condition', 'Location', 'southoutside');
  t = title(mytitle);
  size = 25;
  Y = xlabel('t');
  X = ylabel('x');
  set (l, "fontsize", size);
  set (t, "fontsize", size);
  set (X, "fontsize", size);
  set (Y, "fontsize", size);
  set(gca, "linewidth", lineW, "fontsize", size)
end