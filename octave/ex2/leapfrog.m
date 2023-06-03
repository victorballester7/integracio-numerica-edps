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

function u = leapfrog(a, h, lamb, x0, x1, t1)
  x = x0:h:x1;
  u_real = u0(x-t1);
  u = u0(x);
  k = h*lamb;
  n = t1/k;
  % u_1 = u0(x-k);
  u_1 = ftbs(a, h, lamb, x0, x1, k);
  % printf('\033[1A\033[1A') % Move cursor one line up (in order to remove the printf of the ftcs function)
  u_2 = u;
  for i = 1:n
    u(2:end-1) = u_2(2:end-1) - a*lamb*(u_1(3:end) - u_1(1:end-2));
    u(1) = u_2(1) - a*lamb*(u_1(2) - u_1(end-1));
    u(end) = u(1); % periodic boundary conditon
    % u(1) = u(end) = u_1(end-1);
    % disp(norm(u));

    u_2 = u_1;
    u_1 = u;
  end
  errLinf = max(abs(u_real - u));
  errL2 = (sum((u_real(1:end-1) - u(1:end-1)).^2)*h)^0.5; % we do not count the last point because it is the same as the first one
  % printf("The error (in norm L^oo) is %f\n", errLinf);
  printf("The error (in norm L^2) is %f\n", errL2);
end
% function u = leapfrog(a, h, lamb, x0, x1, t1)
%     % Compute initial solution at time step n-1 using FTCS method
%     dx = h;
%     dt = lamb*dx/abs(a);
%     x = x0:dx:x1;
%     t = 0:dt:2*t1; % need to go up to 2*t1 for FTCS
%     nt = length(t);
%     nx = length(x);
%     u = zeros(nt,nx);
%     u(1,:) = u0(x);
%     for i = 2:nx-1
%         u(2,i) = u(1,i) - a*dt/(2*dx)*(u(1,i+1) - u(1,i-1));
%     end
    
%     % Use leapfrog method to compute solution at time step n+1
%     for n = 2:nt-1
%         for i = 2:nx-1
%             u(n+1,i) = u(n-1,i) - a*dt/dx*(u(n,i+1) - u(n,i-1));
%         end
%     end
    
%     % Extract solution at time t1
%     t_idx = find(t <= t1, 1, 'last');
%     u = u(t_idx,:);
% end