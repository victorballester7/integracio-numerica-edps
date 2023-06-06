% ------------------------------------------------------------
% getResults.m
% ------------------------------------------------------------
% Prints all the results of the exercise.
% ------------------------------------------------------------
h = 1/10;
lamb=0.8;
x0=-1;
x1=1;
t1=1.2;
a=1;
printf("\nFordward-time, Backward-space\n")
tic;
[u, errInf, errL2] = ftbs(a,h,lamb,x0,x1,t1);
printf("\th = %f, errL2 = %g, errL2/errL2Aux = -, orderL2 = -, errInf = %g, errInf/errInfAux = -, orderInf = -\n",h,errL2,errInf);
for i=2:4
  h=h/2;
  [u, errInfAux, errL2Aux] = ftbs(a,h,lamb,x0,x1,t1);
  printf("\th = %f, errL2 = %g, errL2/errL2Aux = %g, orderL2 = %g, errInf = %g, errInf/errInfAux = %g, orderInf = %g\n",h,errL2Aux,errL2/errL2Aux,log(errL2/errL2Aux)/log(2),errInf,errInf/errInfAux,log(errInf/errInfAux)/log(2));
  errInf=errInfAux;
  errL2=errL2Aux;
end
toc;
h = 1/10;
printf("\nLax-Wendroff\n")
tic;
[u, errInf, errL2] = lw(a,h,lamb,x0,x1,t1);
printf("\th = %f, errL2 = %g, errL2/errL2Aux = -, orderL2 = -, errInf = %g, errInf/errInfAux = -, orderInf = -\n",h,errL2,errInf);
for i=2:4
  h=h/2;
  [u, errInfAux, errL2Aux] = lw(a,h,lamb,x0,x1,t1);
  printf("\th = %f, errL2 = %g, errL2/errL2Aux = %g, orderL2 = %g, errInf = %g, errInf/errInfAux = %g, orderInf = %g\n",h,errL2Aux,errL2/errL2Aux,log(errL2/errL2Aux)/log(2),errInf,errInf/errInfAux,log(errInf/errInfAux)/log(2));
  errInf=errInfAux;
  errL2=errL2Aux;
end
toc;

