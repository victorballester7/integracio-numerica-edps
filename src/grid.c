#include "../include/grid.h"

void grid_init(Grid *gr, double dx, double dy, double dt, int nx, int ny, double (*h)(double x, double y)) {
  gr->dx = dx;
  gr->dy = dy;
  gr->nx = nx;
  gr->ny = ny;
  gr->dt = dt;
  gr->t = 0;
  gr->mux = dt / (dx * dx);
  gr->muy = dt / (dy * dy);
  gr->u = malloc((nx + 1) * (ny + 1) * sizeof(double));
  if (gr->u == NULL) {
    printf("Error allocating memory.\n");
    exit(1);
  }
  for (int i = 0; i < nx + 1; i++) {
    for (int j = 0; j < ny + 1; j++) {
      gr->u[(nx + 1) * i + j] = h(i * dx, j * dy);
    }
  }
}

void ExplicitStep(Grid *gr, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y)) {
  double v[(gr->nx + 1) * (gr->ny + 1)];

  // boundary conditions
  for (int i = 0; i < gr->nx + 1; i++) {
    v[(gr->nx + 1) * i] = g(gr->t + gr->dt, i * gr->dx, 0);
    v[(gr->nx + 1) * i + gr->ny] = g(gr->t + gr->dt, i * gr->dx, gr->ny * gr->dy);
  }
  for (int j = 1; j < gr->ny; j++) {
    v[j] = g(gr->t + gr->dt, 0, j * gr->dy);
    v[(gr->nx + 1) * gr->nx + j] = g(gr->t + gr->dt, gr->nx * gr->dx, j * gr->dy);
  }

  // explicit recurrence
  for (int i = 1; i < gr->nx; i++) {
    for (int j = 1; j < gr->ny; j++) {
      v[(gr->nx + 1) * i + j] = (1 - 2 * gr->mux - 2 * gr->muy) * gr->u[(gr->nx + 1) * i + j] + gr->mux * (gr->u[(gr->nx + 1) * (i + 1) + j] + gr->u[(gr->nx + 1) * (i - 1) + j]) + gr->muy * (gr->u[(gr->nx + 1) * i + j + 1] + gr->u[(gr->nx + 1) * i + j - 1]) + gr->dt * f(gr->t, i * gr->dx, j * gr->dy);
    }
  }

  // we increment the time
  gr->t += gr->dt;

  // copy the components of v to u.
  memcpy(gr->u, v, (gr->nx + 1) * (gr->ny + 1) * sizeof(double));
  // for (int i = 0; i < (gr->nx + 1) * (gr->ny + 1); i++)
  //   gr->u[i] = v[i];
}

void write_grid(Grid *gr, FILE *fp) {
  fprintf(fp, "# %lf time\n", gr->t);
  for (int i = 0; i < gr->nx + 1; i++) {
    for (int j = 0; j < gr->ny + 1; j++) {
      fprintf(fp, "%lf %lf %lf\n", i * gr->dx, j * gr->dy, gr->u[(gr->nx + 1) * i + j]);
    }
    fprintf(fp, "\n");
  }
  // fprintf(fp, "\n");
}

void free_grid(Grid *gr) {
  free(gr->u);
  free(gr);
}

void CrankNicolsonStep(Grid *gr, double w, double tol, int maxit, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y)) {
  double um[(gr->nx + 1) * (gr->ny + 1)];
  double aux[(gr->nx + 1) * (gr->ny + 1)];
  double error = tol + 1;
  // We use the previous solution as an initial guess
  // The boundary conditions are implicitely copied
  memcpy(um, gr->u, (gr->nx + 1) * (gr->ny + 1) * sizeof(double));

  // SOR method
  for (int m = 1; m < maxit && error > tol; m++) {
    memcpy(aux, um, (gr->nx + 1) * (gr->ny + 1) * sizeof(double));
    for (int i = 1; i < gr->nx; i++) {
      for (int j = 1; j < gr->ny; j++) {
        // we use the same vector to store the new solution
        um[(gr->nx + 1) * i + j] = (1 - w) * um[(gr->nx + 1) * i + j] + w / (1 + gr->mux + gr->muy) * ((1 - gr->mux - gr->muy) * gr->u[(gr->nx + 1) * i + j] + gr->mux / 2 * (um[(gr->nx + 1) * (i + 1) + j] + um[(gr->nx + 1) * (i - 1) + j] + gr->u[(gr->nx + 1) * (i + 1) + j] + gr->u[(gr->nx + 1) * (i - 1) + j]) + gr->muy / 2 * (um[(gr->nx + 1) * i + j + 1] + um[(gr->nx + 1) * i + j - 1] + gr->u[(gr->nx + 1) * i + j + 1] + gr->u[(gr->nx + 1) * i + j - 1]) + gr->dt / 2 * (f(gr->t, i * gr->dx, j * gr->dy) + f(gr->t + gr->dt, i * gr->dx, j * gr->dy)));
      }
    }
    error = 0;
    for (int i = 1; i < gr->nx; i++) {
      for (int j = 1; j < gr->ny; j++)
        error += fabs(um[(gr->nx + 1) * i + j] - aux[(gr->nx + 1) * i + j]);
    }
    error *= gr->dx * gr->dy;
  }

  // we increment the time
  gr->t += gr->dt;

  // copy the components of um back to u.
  memcpy(gr->u, um, (gr->nx + 1) * (gr->ny + 1) * sizeof(double));
}
