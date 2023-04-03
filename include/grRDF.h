#include <stdio.h>

// ----------------------------------------------
// grRDF
// ----------------------------------------------
// Purpose:
//  Represents a section in the time integration of a finite difference scheme.
//
// Members:
//  dx, dy: grid spacing in x and y directions
//  nx, ny: number of grid points in x and y directions
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
} grRDF;

// ----------------------------------------------
// grRDF_init
// ----------------------------------------------
// Purpose:
//  Initializes a grRDF object allocating memory for the solution array and setting the parameters to the grRDF object.
//
// Parameters:
//  gr: pointer to the grRDF object to be initialized
//  dx, dy: grid spacing in x and y directions
//  dt: time step
//  nx, ny: number of grid points in x and y directions
//  h: function that returns the initial value of the solution at a given point
// ----------------------------------------------
void grRDF_init(grRDF *gr, double dx, double dy, double dt,
                int nx, int ny, double (*h)(double x, double y));

// ----------------------------------------------
// grRDF_pasCalExpl
// ----------------------------------------------
// Purpose:
//  Computes the next time step of the solution using the explicit finite difference scheme for the heat equation.
//
// Parameters:
//  gr: pointer to the grRDF object
//  f: function that returns the value of f(t,x,y) at a given point (source term)
//  g: function that returns the value of g(t,x,y) at a given point (boundary condition)
// ----------------------------------------------
void grRDF_pasCalExpl(grRDF *gr,
                      double (*f)(double t, double x, double y),
                      double (*g)(double t, double x, double y));

/*!
 * \brief Escriu un objecte grRDF, en aquest format:
 * \verbatim
 * # t <valor de t>
 * <x> <y> <u(x,y)>
 * ...
 * \endverbatim
 * Recorre la graella per files, insertant un salt de l\'{\i}nia
 * a cada canvi de fila, i dos salts de l\'{\i}nia un cop
 * completada la graella
 */

// ----------------------------------------------
// grRDF_escriure
// ----------------------------------------------
// Purpose:
//  Writes the solution to a file with the format:
//    # t <value of t>
//    <x> <y> <u(x,y)>
//    ...
//
// Parameters:
//  gr: pointer to the grRDF object
//  fp: pointer to the file where the solution will be written
// ----------------------------------------------
void grRDF_escriure(grRDF *gr, FILE *fp);

// ----------------------------------------------
// grRDF_allib
// ----------------------------------------------
// Purpose:
//  Frees the memory allocated for the solution array.
//
// Parameters:
//  gr: pointer to the grRDF object
// ----------------------------------------------
void grRDF_allib(grRDF *gr);

// ----------------------------------------------
// grRDF_pasCalCN
// ----------------------------------------------
// Purpose:
//  Computes the next time step of the solution using the Crank-Nicolson finite difference scheme for the heat equation.
//
// Parameters:
//  gr: pointer to the grRDF object
//  w: relaxation parameter
//  tol: tolerance for the iterative method
//  maxit: maximum number of iterations for the iterative method
//  f: function that returns the value of f(t,x,y) at a given point (source term)
//  g: function that returns the value of g(t,x,y) at a given point (boundary condition)
// ----------------------------------------------
void grRDF_pasCalCN(grRDF *gr, double w, double tol, int maxit,
                    double (*f)(double t, double x, double y),
                    double (*g)(double t, double x, double y));
