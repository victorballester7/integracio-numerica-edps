% ------------------------------------------------------------
% getResults.m
% ------------------------------------------------------------
% Prints all the results of the exercise.
% ------------------------------------------------------------
h = 1/10;
lamb=0.8;
lamb2=1.6;
x0=-1;
x1=3;
t1=2.4;
a=1;
printf("\nFordward-time, Backward-space (lamb = 0.8)\n")
[temp, temp, errL2_1] = ftbs(a,h,lamb,x0,x1,t1);
[temp, temp, errL2_2] = ftbs(a,h/2,lamb,x0,x1,t1);
[temp, temp, errL2_3] = ftbs(a,h/4,lamb,x0,x1,t1);
printf("\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n",h,errL2_1,h/2,errL2_2,h/4,errL2_3);

printf("\nFordward-time, Centered-space (lamb = 0.8)\n")
[temp, temp, errL2_1] = ftcs(a,h,lamb,x0,x1,t1);
[temp, temp, errL2_2] = ftcs(a,h/2,lamb,x0,x1,t1);
[temp, temp, errL2_3] = ftcs(a,h/4,lamb,x0,x1,t1);
printf("\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n",h,errL2_1,h/2,errL2_2,h/4,errL2_3);

printf("\nLax-Friedrichs (lamb = 0.8)\n")
[temp, temp, errL2_1] = lf(a,h,lamb,x0,x1,t1);
[temp, temp, errL2_2] = lf(a,h/2,lamb,x0,x1,t1);
[temp, temp, errL2_3] = lf(a,h/4,lamb,x0,x1,t1);
printf("\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n",h,errL2_1,h/2,errL2_2,h/4,errL2_3);

printf("\nLax-Friedrichs (lamb = 1.6)\n")
[temp, temp, errL2_1] = lf(a,h,lamb2,x0,x1,t1);
[temp, temp, errL2_2] = lf(a,h/2,lamb2,x0,x1,t1);
[temp, temp, errL2_3] = lf(a,h/4,lamb2,x0,x1,t1);
printf("\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n",h,errL2_1,h/2,errL2_2,h/4,errL2_3);

printf("\nLeapfrog (lamb = 0.8)\n")
[temp, temp, errL2_1] = leapfrog(a,h,lamb,x0,x1,t1);
[temp, temp, errL2_2] = leapfrog(a,h/2,lamb,x0,x1,t1);
[temp, temp, errL2_3] = leapfrog(a,h/4,lamb,x0,x1,t1);
printf("\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n\th = %f, errL2 = %g\n",h,errL2_1,h/2,errL2_2,h/4,errL2_3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stable schemes
steps=6;
printf("\nFordward-time, Backward-space\n")
[temp, temp, errL2] = ftbs(a,h,lamb,x0,x1,t1);
printf("\th = %f, errL2 = %g, errL2/errL2Aux = -, orderL2 = -\n",h,errL2);
for i=2:steps
  h=h/2;
  [temp, temp, errL2Aux] = ftbs(a,h,lamb,x0,x1,t1);
  printf("\th = %f, errL2 = %g, errL2/errL2Aux = %g, orderL2 = %g\n",h,errL2Aux,errL2/errL2Aux,log(errL2/errL2Aux)/log(2));
  errL2=errL2Aux;
end

h = 1/10;
printf("\nLax-Friedrichs\n")
[temp, temp, errL2] = lf(a,h,lamb,x0,x1,t1);
printf("\th = %f, errL2 = %g, errL2/errL2Aux = -, orderL2 = -\n",h,errL2);
for i=2:steps
  h=h/2;
  [temp, temp, errL2Aux] = lf(a,h,lamb,x0,x1,t1);
  printf("\th = %f, errL2 = %g, errL2/errL2Aux = %g, orderL2 = %g\n",h,errL2Aux,errL2/errL2Aux,log(errL2/errL2Aux)/log(2));
  errL2=errL2Aux;
end

h = 1/10;
printf("\nLeapfrog\n")
[temp, temp, errL2] = leapfrog(a,h,lamb,x0,x1,t1);
printf("\th = %f, errL2 = %g, errL2/errL2Aux = -, orderL2 = -\n",h,errL2);
for i=2:steps
  h=h/2;
  [temp, temp, errL2Aux] = leapfrog(a,h,lamb,x0,x1,t1);
  printf("\th = %f, errL2 = %g, errL2/errL2Aux = %g, orderL2 = %g\n",h,errL2Aux,errL2/errL2Aux,log(errL2/errL2Aux)/log(2));
  errL2=errL2Aux;
end
