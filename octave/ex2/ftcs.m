% ----------------------------------------------------------------------- %
% Implements the forward-time central-space scheme for the 1D wave equation u_t + a u_x = 0 with inital condition u(0,x) = u0(x) and boundary conditions u(t,x0) = 0. Also it prints the error between the numerical solution and the exact solution.
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

function u = ftcs(a, h, lamb, x0, x1, t1)
  x = x0:h:x1;
  u_real = u0(x-t1);
  u = u0(x);
  k = h*lamb;
  n = t1/k;
  for i = 1:n
    u_aux = u;
    u(2:end-1) = u_aux(2:end-1) - a*lamb/2*(u_aux(3:end) - u_aux(1:end-2));
    u(1) = u_aux(1) - a*lamb/2*(u_aux(2) - u_aux(end-1));
    u(end) = u(1);
  end
  errLinf = max(abs(u_real - u));
  errL2 = (sum((u_real(1:end-1) - u(1:end-1)).^2)*h)^0.5; % we do not count the last point because it is the same as the first one
  printf("The error (in norm L^oo) is %f\n", errLinf);
  printf("The error (in norm L^2) is %f\n", errL2);
end