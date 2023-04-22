#include "../include/functions.h"

double f(double t, double x, double y) {
  return ((x - 0.5) * (x - 0.5) + (y - 0.5) * (y - 0.5) < 0.2 * 0.2) ? (100. / k) : 0;
}

double g(double t, double x, double y) {
  return 0;
}

double h(double x, double y) {
  return 0;
}

double f_pol(double t, double x, double y) {
  return -3 - 6 * x;
}

double g_pol(double t, double x, double y) {
  return 1 + t + x * x + x * x * x + y * y;
}

double h_pol(double x, double y) {
  return 1 + x * x + x * x * x + y * y;
}
