% ----------------------------------------
%  solve5
% ----------------------------------------
%  Solves the Laplace equation using the 5-point laplacian on the grid [0,1]x[0,1] with homogeneous Dirichlet boundary conditions
%
% Input:
%  h: grid size in both directions
%  x0: left boundary in the x-direction
%  x1: right boundary in the x-direction
%  y0: bottom boundary in the y-direction
%  y1: top boundary in the y-direction
%
% ----------------------------------------
function err = solve9(h, x0, x1, y0, y1)
  n = (x1-x0)/h - 1; % number of interior grid points in the x-direction
  m = (y1-y0)/h - 1; % number of interior grid points in the y-direction
  printf("dim matrix: %d x %d\n", n*m, n*m);
  % printf("n = %d, m = %d\n", n, m);
  % printf("Creating matrix %d x %d...\n", n*m, n*m);
  % tic;
  A = laplace9Matrix(n,m); % create the matrix
  % toc;
  % printf("Creating right hand side vector...\n");
  % tic;
  % --------------------------
  % this way is more efficient, but tedious
  n = n+1; m = m+1; % number of grid points in each direction - 1
  Px=(0:n)';
  Py=(0:m);
  Qx=Px(:,ones(m+1,1));
  Qy=Py(ones(n+1,1),:);
  R=Qx(:)'; % vector of row indices 1 2 3 4 ... n 1 2 3 4 ... n 1 2 3 4 ... n ... 1 2 3 4 ... n
  S=Qy(:)'; % vector of column indices 1 1 1 1 ... 2 2 2 2 ... 3 3 3 3 ... m m m m
  R=R*h; S=S*h; % scale the indices to the grid
  g = f(R,S); % evaluate the function at the grid points
  n = n+1; m = m+1; % number of grid points in each direction
  b = h^2/2*(8 * g + [0 g(1:end-1)] + [g(2:end) 0] + [zeros(1,n) g(1:end-n)] + [g(n+1:end) zeros(1,n)]); % create the right hand side vector
  b = reshape(b, n, m); % reshape the right hand side vector into a matrix
  b = b(2:n-1, 2:m-1); % extract the interior grid points
  b = b(:); % reshape the right hand side vector into a column vector
  % b
  % c = b(n+2:2*n-1); 
  % for i = 2:m-1 
  %   printf("i = %d, %d\n", i*n+2, (i+1)*n-1);
  %   c = [c, b(i*n+2:(i+1)*n-1)];
  % end
  % c
  % b = c';
  % --------------------------
  % [R,S] = meshgrid(x0 + h:h:x1 - h, y0 + h:h:y1 - h);
  % b = h^2*f(R,S); % create the right hand side vector
  % b = b(:); % reshape the right hand side vector into a column vector
  % --------------------------
  % toc;
  % printf("Solving system...\n");
  % tic;
  u_approx = (A\b)'; % solve the system
  % toc;
  n = n-2; m = m-2; % number of grid points in each direction - 1
  Px=(1:n)';
  Py=(1:m);
  Qx=Px(:,ones(m,1));
  Qy=Py(ones(n,1),:);
  R=Qx(:)'; % vector of row indices 1 2 3 4 ... n 1 2 3 4 ... n 1 2 3 4 ... n ... 1 2 3 4 ... n
  S=Qy(:)'; % vector of column indices 1 1 1 1 ... 2 2 2 2 ... 3 3 3 3 ... m m m m
  R=R*h; S=S*h; % scale the indices to the grid
  u_real=u(R, S); % extract the solution at the grid points
  err = sqrt(h)*norm(u_approx-u_real(:)',2); % compute the error in L2 norm
  % printf("Error in L2: %g\n", err);
end