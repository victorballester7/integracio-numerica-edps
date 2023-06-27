#ifndef GRID_H
#define GRID_H

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DX gr->dx
#define DY gr->dy
#define NX gr->nx
#define NY gr->ny
#define T gr->t
#define DT gr->dt
#define MUX gr->mux
#define MUY gr->muy
#define U(j, i) gr->u[(NX + 1) * (j) + (i)]  // we store the array by rows. The indexes are: i = column counter in X axis (rightwards) and j = row counter in Y axis (downwards)

// ----------------------------------------------
// Grid
// ----------------------------------------------
// Purpose:
//  Represents a section in the time integration of a finite difference scheme.
//
// Members:
//  dx, dy: Grid spacing in x and y directions
//  nx, ny: number of Grid points in x and y directions
//  t: current time
//  dt: time step
//  mux, muy: dt / (dx * dx) and dt / (dy * dy)
//  u: array of size (nx + 1) * (ny + 1) containing the values of the solution
// ----------------------------------------------
typedef struct {
  double dx;
  double dy;
  int nx;
  int ny;
  double t;
  double dt;
  double mux;
  double muy;

  double *u;
} Grid;

// ----------------------------------------------
// grid_init
// ----------------------------------------------
// Purpose:
//  Initializes a Grid object allocating memory for the solution array and setting the parameters to the Grid object.
//
// Parameters:
//  gr: pointer to the Grid object to be initialized
//  dx, dy: Grid spacing in x and y directions
//  dt: time step
//  nx, ny: number of Grid points in x and y directions
//  h: function that returns the initial value of the solution at a given point
// ----------------------------------------------
void grid_init(Grid *gr, double dx, double dy, double dt, int nx, int ny, double (*h)(double x, double y));

// ----------------------------------------------
// ExplicitStep
// ----------------------------------------------
// Purpose:
//  Computes the next time step of the solution using the explicit finite difference scheme for the heat equation.
//
// Parameters:
//  gr: pointer to the Grid object
//  f: function that returns the value of f(t,x,y) at a given point (source term)
//  g: function that returns the value of g(t,x,y) at a given point (boundary condition)
// ----------------------------------------------
void ExplicitStep(Grid *gr, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y));

// ----------------------------------------------
// write_grid
// ----------------------------------------------
// Purpose:
//  Writes the solution to a file with the format:
//    # t <value of t>
//    <x> <y> <u(x,y)>
//    ...
//
// Parameters:
//  gr: pointer to the Grid object
//  fp: pointer to the file where the solution will be written
// ----------------------------------------------
void write_grid(Grid *gr, FILE *fp);

// ----------------------------------------------
// free_grid
// ----------------------------------------------
// Purpose:
//  Frees the memory allocated for the solution array.
//
// Parameters:
//  gr: pointer to the Grid object
// ----------------------------------------------
void free_grid(Grid *gr);

// ----------------------------------------------
// CrankNicolsonStep
// ----------------------------------------------
// Purpose:
//  Computes the next time step of the solution using the Crank-Nicolson finite difference scheme for the heat equation.
//
// Parameters:
//  gr: pointer to the Grid object
//  w: relaxation parameter
//  tol: tolerance for the iterative method
//  maxit: maximum number of iterations for the iterative method
//  f: function that returns the value of f(t,x,y) at a given point (source term)
//  g: function that returns the value of g(t,x,y) at a given point (boundary condition)
// ----------------------------------------------
void CrankNicolsonStep(Grid *gr, double w, double tol, int maxit, double (*f)(double t, double x, double y), double (*g)(double t, double x, double y));
#endif
