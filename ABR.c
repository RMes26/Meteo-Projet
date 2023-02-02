#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct arbre_ABR {
    int e;
    char *valeur;
    struct arbre *gauche;
    struct arbre *droite;
};

struct arbre_ABR* newarbre_ABR(int e, char *valeur) {
    struct arbre_ABR* noeud = (struct arbre_ABR*)malloc(sizeof(struct arbre_ABR));
    noeud->e = e;
    noeud->valeur = valeur;
    noeud->gauche = noeud->droite = NULL;
    return noeud;
}

struct arbre_ABR* insertABR(struct arbre_ABR* noeud, int e, char *valeur) {
    if (noeud == NULL) return newarbre_ABR(e, valeur);
    if (e < noeud->e){
        noeud->gauche = insertABR(noeud->gauche, e, valeur);
    }
    else if (e > noeud->e){
        noeud->droite = insertABR(noeud->droite, e, valeur);
    }
    return noeud;
}

void parcoursInfixe(struct arbre_ABR *racine, FILE *outfile) { 
    if (racine != NULL) {
        parcoursInfixe(racine->gauche, outfile);
        fprintf(outfile, "%d,%s", racine->e, racine->valeur);
        parcoursInfixe(racine->droite, outfile);
    }
}
