#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct arbre_AVL {
    int e;
    char *valeur;
    struct arbre_AVL *gauche;
    struct arbre_AVL *droite;
    int hauteur;
};

struct arbre_AVL* newarbre_AVL(int e, char *valeur) {
    struct arbre_AVL* noeud = (struct arbre_AVL*) malloc(sizeof(struct arbre_AVL));
    noeud->e = e;
    noeud->valeur = valeur;
    noeud->gauche = NULL;
    noeud->droite = NULL;
    noeud->hauteur = 1;  // new noeud is initially added at leaf
    return noeud;
}

struct arbre_AVL* insert_AVL(struct arbre_AVL* noeud, int e, char *valeur);
int equilibre(struct arbre_AVL *noeud);
int hauteur(struct arbre_AVL *noeud);
int max(int a, int b);
struct arbre_AVL *rotationDroite(struct arbre_AVL *y);
struct arbre_AVL *rotationGauche(struct arbre_AVL *x) ;
void InversionOrdreAVL(struct arbre_AVL *racine->droite, fichier);
void parcours_Infixe(struct arbre_AVL *racine, FILE *fichier);