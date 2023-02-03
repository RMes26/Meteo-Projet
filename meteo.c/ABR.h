#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct arbre_ABR {
    int e;
    char *valeur;
    struct arbre *gauche;
    struct arbre *droite;
};

struct arbre_ABR* newarbre_ABR(int e, char *valeur);
struct arbre_ABR* insertABR(struct arbre_ABR* noeud, int e, char *valeur);
void parcoursInfixe(struct arbre_ABR *racine, FILE *outfile);
