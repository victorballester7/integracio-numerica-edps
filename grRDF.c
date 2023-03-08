#include "grRDF.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void grRDF_init(grRDF *gr, double dx, double dy, double dt, int nx, int ny, double (*h)(double x, double y)) {
  gr->dx = dx;
  gr->dy = dy;
  gr->dt = dt;
  gr->nx = nx;
  gr->ny = ny;
  gr->mux = dt / (dx * dx);
  gr->muy = dt / (dy * dy);
  for (int i = 0; i < nx; i++) {
    for (int j = 0; j < ny; j++) {
      // gr->u;
    }
  }
}

void grRDF_pasCalExpl(grRDF *gr, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y)) {
}

void grRDF_escriure(grRDF *gr, FILE *fp) {
}

void grRDF_allib(grRDF *gr) {
}

int grRDF_pasCalCN(grRDF *gr, double w, double tol, int maxit, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y)) {
}
