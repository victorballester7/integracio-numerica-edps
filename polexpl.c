#include "grRDF.h"
/*!
 * \brief Funcio f del problema mixt per l'equaci\'o de la
 * calor, imposant que la soluci\'o sigui un polinomi.
 */
double f_pol (double t, double x, double y) {
/* ... */
}

/*!
 * \brief Funcio g del problema mixt per l'equaci\'o de la
 * calor, imposant que la soluci\'o sigui un polinomi.
 */
double g_pol (double t, double x, double y) {
/* ... */
}

/*!
 * \brief Funcio h del problema mixt per l'equaci\'o de la
 * calor, imposant que la soluci\'o sigui un polinomi.
 */
double h_pol (double x, double y) {
/* ... */
}

/*!\brief Implementa l'algorisme 1.1 per al punt 2 del gui\'o. */
int main (int argc, char *argv[]) {    //Aqui podriais introducir por pantalla largo de x, largo de y, puntos en x, puntos en y, tiempo final y puntos en t
   /* ... declaracions diverses ... */
/* Objecte graella */
   grRDF gr;
   /* ... llegir par\`ametres ... */
/* Inicialitzo graella (par\`ametres i llesca t=0 */
   grRDF_init(&gr,dx,dy,dt,nx,ny,h_pol);
/* Escric graella inicial */
   grRDF_escriure(&gr,stdout);
/*
 * Bucle en temps:
 * A cada pas crida grRDF_pasCalExpl(&gr,f_pol,g_pol)
 * i escriu graella mitjan\c{c}ant crida a grRDF_escriure(&gr,stdout)
 */
   /* ... el bucle en temps ... */
/* Tot fet! */
   return 0;
}
