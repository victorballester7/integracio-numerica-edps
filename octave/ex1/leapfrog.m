% ----------------------------------------------------------------------- %
% Implements the leapfrog scheme for the 1D wave equation u_t + a u_x = 0 with inital condition u(0,x) = u0(x) and boundary conditions u(t,x0) = 0. Also it prints the error between the numerical solution and the exact solution.
%
% Parameters:
%   a: wave speed
%   h: spatial step size
%   lamb: k / h, where k is the time step size
%   x0: left boundary of the spatial domain
%   x1: right boundary of the spatial domain
%   t0: initial time
%   t1: final time
%
% Returns:
%   u: the numerical solution at time t1
% ----------------------------------------------------------------------- %

function [u, errLinf, errL2] = leapfrog(a, h, lamb, x0, x1, t1)
  x = x0:h:x1;
  u_real = u0(x-t1);
  u = u0(x);
  k = h*lamb;
  n = t1/k;
  u_1 = ftcs(a, h, lamb, x0, x1, k);
  % printf('\033[1A\033[1A') % Move cursor 2 line up (in order to remove the printf's of the ftcs function)
  u_2 = u;
  for i = 2:n
    u(2:end-1) = u_2(2:end-1) - a*lamb*(u_1(3:end) - u_1(1:end-2));
    u(1) = 0;
    u(end) = u(end-1);
    u_2 = u_1;
    u_1 = u;
  end
  errLinf = max(abs(u_real - u));
  errL2 =  (sum((u_real(1:end-1) - u(1:end-1)).^2)*h)^0.5; 
  % printf("The error (in norm L^oo) is %f\n", errLinf);
  % printf("The error (in norm L^2) is %f\n", errL2);
end