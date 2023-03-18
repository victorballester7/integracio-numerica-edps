#include <math.h>

#include "grRDF.h"

/*!
 * \brief Funcio f del problema mixt per l'equaci\'o de la
 * calor, imposant que la soluci\'o sigui un polinomi.
 */
double f_pol(double t, double x, double y) {
  return 1 - 2 * (x + y);
}

/*!
 * \brief Funcio g del problema mixt per l'equaci\'o de la
 * calor, imposant que la soluci\'o sigui un polinomi.
 */
double g_pol(double t, double x, double y) {
  return t + x * x + y * y;
}

/*!
 * \brief Funcio h del problema mixt per l'equaci\'o de la
 * calor, imposant que la soluci\'o sigui un polinomi.
 */
double h_pol(double x, double y) {
  return x * x + y * y;
}

/*!\brief Implementa l'algorisme 1.1 per al punt 2 del gui\'o. */
int main(int argc, char *argv[]) {  // Aqui podriais introducir por pantalla largo de x, largo de y, puntos en x, puntos en y, tiempo final y puntos en t
  double dx, dy, dt;
  int nx, ny, nt;
  /* Objecte graella */
  grRDF gr;
  if (argc != 7 || sscanf(argv[1], "%lf", &dx) != 1 || sscanf(argv[2], "%lf", &dy) != 1 || sscanf(argv[3], "%d", &nx) != 1 || sscanf(argv[4], "%d", &ny) != 1 || sscanf(argv[5], "%lf", &dt) != 1 || sscanf(argv[6], "%d", &nt) != 1) {
    printf("Execute as ./polexpl dx dy nx ny tf dt\n");
    return -1;
  }
  /* Inicialitzo graella (par\`ametres i llesca t=0 */
  grRDF_init(&gr, dx, dy, dt, nx, ny, h_pol);
  /* Escric graella inicial */
  FILE *fp;
  if ((fp = fopen("grid.txt", "w")) == NULL) {
    printf("Cannot open the file.\n");
    return 1;
  }

  // printf("mux=%lf\nmuy=%lf\ndt=%lf\n", gr.mux, gr.muy, gr.dt);

  for (int i = 1; i < nt; i++) {
    grRDF_pasCalExpl(&gr, f_pol, g_pol);
    grRDF_escriure(&gr, fp);
  }

  double errorL1 = 0;
  for (int i = 0; i < gr.nx + 1; i++) {
    for (int j = 0; j < gr.ny + 1; j++) {
      errorL1 += fabs(gr.u[(gr.nx + 1) * i + j] - g_pol(gr.t, i * gr.dx, j * gr.dy));
      fprintf(fp, "%lf %lf %lf\n", i * gr.dx, j * gr.dy, gr.u[(gr.nx + 1) * i + j] - g_pol(gr.t, i * gr.dx, j * gr.dy));
    }
  }
  printf("Error in L1: %lf\n", errorL1);
  fclose(fp);
  return 0;
}
