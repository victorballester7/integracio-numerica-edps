#include <math.h>

#include "../include/functions.h"
#include "../include/grRDF.h"

int main(int argc, char *argv[]) {
  double dx, dy, dt;
  int nx, ny, nt;
  grRDF gr;
  if (argc != 7 || sscanf(argv[1], "%lf", &dx) != 1 || sscanf(argv[2], "%lf", &dy) != 1 || sscanf(argv[3], "%d", &nx) != 1 || sscanf(argv[4], "%d", &ny) != 1 || sscanf(argv[5], "%lf", &dt) != 1 || sscanf(argv[6], "%d", &nt) != 1) {
    printf("Execute as ./polexpl dx dy nx ny tf dt\n");
    return -1;
  }
  /* Inicialitzo graella (par\`ametres i llesca t=0 */
  grRDF_init(&gr, dx, dy, dt, nx, ny, h_pol);
  /* Escric graella inicial */
  FILE *fp;
  if ((fp = fopen("data/grid.txt", "w")) == NULL) {
    printf("Cannot open the file.\n");
    return 1;
  }

  for (int i = 1; i < nt; i++) {
    grRDF_pasCalExpl(&gr, f_pol, g_pol);
    grRDF_escriure(&gr, fp);
  }

  // Exericici 2
  // double errorL1 = 0;
  // for (int i = 0; i < gr.nx + 1; i++) {
  //   for (int j = 0; j < gr.ny + 1; j++) {
  //     errorL1 += fabs(gr.u[(gr.nx + 1) * i + j] - g_pol(gr.t, i * gr.dx, j * gr.dy));
  //     fprintf(fp, "%lf %lf %lf\n", i * gr.dx, j * gr.dy, gr.u[(gr.nx + 1) * i + j] - g_pol(gr.t, i * gr.dx, j * gr.dy));
  //   }
  // }
  // printf("Error in L1: %lf\n", errorL1);

  fclose(fp);
  return 0;
}
