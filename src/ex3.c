#include "../include/functions.h"
#include "../include/grid.h"

int main(int argc, char *argv[]) {
  double dx, dy, dt, tf;
  int nx, ny, nt;
  Grid gr;

  if (argc != 7 || sscanf(argv[1], "%lf", &dx) != 1 || sscanf(argv[2], "%lf", &dy) != 1 || sscanf(argv[3], "%d", &nx) != 1 || sscanf(argv[4], "%d", &ny) != 1 || sscanf(argv[5], "%lf", &dt) != 1 || sscanf(argv[6], "%lf", &tf) != 1) {
    printf("Execute as ./bin/main dx dy nx ny dt tf\n");
    return -1;
  }
  nt = (int)ceil(tf / dt) + 1;

  // initialize grid
  grid_init(&gr, dx, dy, dt, nx, ny, h);

  // open file
  FILE *fp;
  if ((fp = fopen("data/grid.txt", "w")) == NULL) {
    printf("Cannot open the file.\n");
    return 1;
  }

  // compute the solution
  write_grid(&gr, fp);
  for (int i = 1; i < nt; i++) {
    fprintf(fp, "\n");  // To avoid gnuplot detecting an extra datablock.
    ExplicitStep(&gr, f, g);
    write_grid(&gr, fp);
  }

  // Exercice 3b
  printf("\nIn order to show the inestability of the scheme when 1 - 2 * mu_x - 2 * mu_y < 0, execute with: ./bin/main 0.01 0.01 5 5 0.01 10\n");
  printf("In that case, we will obtain large negative values which are physically impossible because the temperature at the plate is at 0ºC at the beginning and we are heating (not cooling) the plate!\n\n");

  // Exercice 3c
  // we need a to impose 10^-4 = dx^2 ==> dx = 0.01 ==> dt < 0.0001 to impose the condition of stability.
  printf("\nIf we want to obtain a precision of 1.e-4 execute with: ./bin/main 1.e-4 1.e-4 1000 1000 1.e-9 1\n");
  printf("It takes to much time... :(\n\n");

  fclose(fp);
  return 0;
}
