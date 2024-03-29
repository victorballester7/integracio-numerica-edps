#include "../include/grid.h"

#include "../include/functions.h"

void grid_init(Grid *gr, double dx, double dy, double dt, int nx, int ny, double (*h)(double x, double y)) {
  DX = dx;
  DY = dy;
  NX = nx;
  NY = ny;
  T = 0;
  DT = dt;
  MUX = DT / (DX * DX);
  MUY = DT / (DY * DY);
  gr->u = malloc((NX + 1) * (NY + 1) * sizeof(double));
  aux = malloc((NX + 1) * (NY + 1) * sizeof(double));
  if (gr->u == NULL || aux == NULL) {
    printf("Error allocating memory.\n");
    exit(1);
  }
  // initial condition (t = 0)
  for (int i = 0; i < NX + 1; i++) {
    for (int j = 0; j < NY + 1; j++)
      U(j, i) = h(i * DX, j * DY);
  }
}

void ExplicitStep(Grid *gr, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y)) {
  //   double v[(NX + 1) * (NY + 1)];
  // #define v(j, i) v[(NX + 1) * (j) + (i)]

  // boundary conditions
  for (int i = 0; i < NX + 1; i++) {
    AUX(0, i) = g(T + DT, i * DX, 0);
    AUX(NY, i) = g(T + DT, i * DX, NY * DY);
  }
  for (int j = 1; j < NY; j++) {
    AUX(j, 0) = g(T + DT, 0, j * DY);
    AUX(j, NX) = g(T + DT, NX * DX, j * DY);
  }

  // explicit recurrence
  for (int i = 1; i < NX; i++) {
    for (int j = 1; j < NY; j++) {
      AUX(j, i) = (1 - 2 * MUX - 2 * MUY) * U(j, i) + MUX * (U(j, i + 1) + U(j, i - 1)) + MUY * (U(j + 1, i) + U(j - 1, i)) + DT * f(T, i * DX, j * DY);
    }
  }

  // increment time
  T += DT;

  // copy v to u
  memcpy(gr->u, aux, (NX + 1) * (NY + 1) * sizeof(double));

  // #undef v
}

void write_grid(Grid *gr, FILE *fp) {
  fprintf(fp, "# \u03C4 = %.4lf\n", T * c * rho / k);  // \u03C4 = tau, and we rescale the time
  for (int i = 0; i < NX + 1; i++) {
    for (int j = 0; j < NY + 1; j++)
      fprintf(fp, "%lf %lf %lf\n", i * DX, j * DY, U(j, i));
    fprintf(fp, "\n");
  }
  // fprintf(fp, "\n");
}

void free_grid(Grid *gr) {
  free(gr->u);
  free(aux);
  free(gr);
}

void CrankNicolsonStep(Grid *gr, double w, double tol, int maxit, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y)) {
  // double um[(NX + 1) * (NY + 1)];
  double tmp;
  double errorLoo = tol + 1;
  // #define um(j, i) um[(NX + 1) * (j) + (i)]

  // We use the previous solution as an initial guess
  memcpy(aux, gr->u, (NX + 1) * (NY + 1) * sizeof(double));

  // Boundary conditions
  for (int i = 0; i < NX + 1; i++) {
    AUX(0, i) = g(T + DT, i * DX, 0);
    AUX(NY, i) = g(T + DT, i * DX, NY * DY);
  }
  for (int j = 1; j < NY; j++) {
    AUX(j, 0) = g(T + DT, 0, j * DY);
    AUX(j, NX) = g(T + DT, NX * DX, j * DY);
  }

  // SOR method
  // int M = 0;
  for (int m = 1; m < maxit && errorLoo > tol; m++) {
    // M = m;
    errorLoo = 0;
    for (int i = 1; i < NX; i++) {
      for (int j = 1; j < NY; j++) {
        tmp = AUX(j, i);
        // we use the same vector to store the new solution
        AUX(j, i) = (1 - w) * AUX(j, i) + w / (1 + MUX + MUY) * ((1 - MUX - MUY) * U(j, i) + MUX / 2 * (AUX(j, i + 1) + AUX(j, i - 1) + U(j, i + 1) + U(j, i - 1)) + MUY / 2 * (AUX(j + 1, i) + AUX(j - 1, i) + U(j + 1, i) + U(j - 1, i)) + DT / 2 * (f(T, i * DX, j * DY) + f(T + DT, i * DX, j * DY)));
        errorLoo = MAX(errorLoo, fabs(AUX(j, i) - tmp));
      }
    }
  }
  // printf("Number of iterations: %d\n", M);
  if (errorLoo > tol) {  // i.e. m == maxit
    printf("Warning: maximAUX nAUXber of iterations reached.\n");
    exit(1);
  }
  // increment time
  T += DT;

  // copy aux to u
  memcpy(gr->u, aux, (NX + 1) * (NY + 1) * sizeof(double));

  // #undef um
}
