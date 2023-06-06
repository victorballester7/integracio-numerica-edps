% ------------------------------------------------------------
% getResults.m
% ------------------------------------------------------------
% Prints all the results of the exercise when repeating the problem n times, each halving the step size
%
% Parameters:
%   h - initial step size
%   n - number of times to repeat the problem
% ------------------------------------------------------------
function getResults(h,n)
  h0=h;
  printf("\n5-points laplacian:\n")
  tic;
  err=solve5(h,0,1,0,1);
  printf("\th = %f, err = %g, err/errAux = -, order = -\n",h,err);
  for i=2:n
    h=h/2;
    errAux=solve5(h,0,1,0,1);
    printf("\th = %f, err = %g, err/errAux = %g, order = %g\n",h,errAux,err/errAux, log(err/errAux)/log(2));
    err=errAux;
  end
  toc;
  h=h0;
  printf("\n9-points laplacian\n")
  tic;
  err=solve9(h,0,1,0,1);
  printf("\th = %f, err = %g, err/errAux = -, order = -\n",h,err);
  for i=2:n
    h=h/2;
    errAux=solve9(h,0,1,0,1);
    printf("\th = %f, err = %g, err/errAux = %g, order = %g\n",h,errAux,err/errAux, log(err/errAux)/log(2));
    err=errAux;
  end
  toc;
end