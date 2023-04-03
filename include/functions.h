#define k 0.13
#define c 0.11
#define rho 7.8

// ----------------------------------------------
// f_pol
// ----------------------------------------------
// Purpose:
//   Evaluates the function f(t,x,y) of the mixed problem for the heat equation in the equation u_t - Laplacian(u) = f.
//
// Parameters:
//   t: time
//   x: x coordinate
//   y: y coordinate
//
// Returns:
//   The value of f(t,x,y).
// ----------------------------------------------
double f(double t, double x, double y);

// ----------------------------------------------
// g_pol
// ----------------------------------------------
// Purpose:
//   Evaluates the function g(t,x,y) of the mixed problem for the heat equation which is the condition in the boundary.
//
// Parameters:
//   t: time
//   x: x coordinate
//   y: y coordinate
//
// Returns:
//   The value of g(t,x,y).
// ----------------------------------------------
double g(double t, double x, double y);

// ----------------------------------------------
// h_pol
// ----------------------------------------------
// Purpose:
//   Evaluates the function h(t,x,y) of the mixed problem for the heat equation which is the condition in the boundary.
//
// Parameters:
//   t: time
//   x: x coordinate
//   y: y coordinate
//
// Returns:
//   The value of h(t,x,y).
// ----------------------------------------------
double h(double x, double y);

// ----------------------------------------------
// f_pol
// ----------------------------------------------
// Purpose:
//   Evaluates the function f(t,x,y) of the mixed problem for the heat equation in the equation u_t - Laplacian(u) = f. This is the case when f is a polynomial.
//
// Parameters:
//   t: time
//   x: x coordinate
//   y: y coordinate
//
// Returns:
//   The value of f(t,x,y).
// ----------------------------------------------
double f_pol(double t, double x, double y);

// ----------------------------------------------
// g_pol
// ----------------------------------------------
// Purpose:
//   Evaluates the function g(t,x,y) of the mixed problem for the heat equation which is the condition in the boundary. This is the case when g is a polynomial.
//
// Parameters:
//   t: time
//   x: x coordinate
//   y: y coordinate
//
// Returns:
//   The value of g(t,x,y).
// ----------------------------------------------
double g_pol(double t, double x, double y);

// ----------------------------------------------
// h_pol
// ----------------------------------------------
// Purpose:
//   Evaluates the function h(t,x,y) of the mixed problem for the heat equation which is the condition in the boundary. This is the case when h is a polynomial.
//
// Parameters:
//   t: time
//   x: x coordinate
//   y: y coordinate
//
// Returns:
//   The value of h(t,x,y).
// ----------------------------------------------
double h_pol(double x, double y);