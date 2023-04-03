#include "../include/grRDF.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void grRDF_init(grRDF *gr, double dx, double dy, double dt, int nx, int ny, double (*h)(double x, double y)) {
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

void grRDF_pasCalExpl(grRDF *gr, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y)) {
  double v[(gr->nx + 1) * (gr->ny + 1)];

  // printf("temps: %lf\n", gr->t + gr->dt);
  // boundary conditions
  for (int i = 0; i < gr->nx + 1; i++) {
    v[(gr->nx + 1) * i] = g(gr->t + gr->dt, i * gr->dx, 0);
    v[(gr->nx + 1) * i + gr->ny] = g(gr->t + gr->dt, i * gr->dx, gr->ny * gr->dy);
    // printf("boundary i: %lf %lf %lf\n", i * gr->dx, v[(gr->nx + 1) * i], v[(gr->nx + 1) * i + gr->ny]);
  }
  for (int j = 1; j < gr->ny; j++) {
    v[j] = g(gr->t + gr->dt, 0, j * gr->dy);
    v[(gr->nx + 1) * gr->nx + j] = g(gr->t + gr->dt, gr->nx * gr->dx, j * gr->dy);
    // printf("boundary j: %lf %lf %lf\n", j * gr->dy, v[j], v[(gr->nx + 1) * gr->nx + j]);
  }

  // explicit recurrence
  for (int i = 1; i < gr->nx; i++) {
    for (int j = 1; j < gr->ny; j++) {
      v[(gr->nx + 1) * i + j] = (1 - 2 * gr->mux - 2 * gr->muy) * gr->u[(gr->nx + 1) * i + j] + gr->mux * (gr->u[(gr->nx + 1) * (i + 1) + j] + gr->u[(gr->nx + 1) * (i - 1) + j]) + gr->muy * (gr->u[(gr->nx + 1) * i + j + 1] + gr->u[(gr->nx + 1) * i + j - 1]) + gr->dt * f(gr->t, i * gr->dx, j * gr->dy);
      // printf("recurrence: %lf %lf %lf\n", i * gr->dx, j * gr->dy, v[(gr->nx + 1) * i + j]);
    }
  }

  // we increment the time
  gr->t += gr->dt;

  // copy the components of v to u.
  for (int i = 0; i < (gr->nx + 1) * (gr->ny + 1); i++)
    gr->u[i] = v[i];
}

void grRDF_escriure(grRDF *gr, FILE *fp) {
  fprintf(fp, "# %lf time\n", gr->t);
  for (int i = 0; i < gr->nx + 1; i++) {
    for (int j = 0; j < gr->ny + 1; j++) {
      fprintf(fp, "%lf %lf %lf\n", i * gr->dx, j * gr->dy, gr->u[(gr->nx + 1) * i + j]);
    }
  }
  fprintf(fp, "\n");
}

void grRDF_allib(grRDF *gr) {
  free(gr->u);
  free(gr);
}

void grRDF_pasCalCN(grRDF *gr, double w, double tol, int maxit, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y)) {
}
