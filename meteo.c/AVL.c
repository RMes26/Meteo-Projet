
# include  < stdio.h >
# include  < stdlib.h >
# include  < chaîne.h >

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
    noeud->hauteur = 1;  // le nouveau noeud est une feuille 
    return noeud;
}

struct arbre_AVL* insert_AVL(struct arbre_AVL* noeud, int e, char *valeur) {
    if (noeud == NULL){
        return newarbre_AVL(e, valeur);
    }
    if (e < noeud->e){
        noeud->gauche = insert_AVL(noeud->gauche, e, valeur);
    }
    else if (e > noeud->e){
        noeud->droite = insert_AVL(noeud->droite, e, valeur);
    }
    else
        return noeud;
    noeud->hauteur = 1 + max(hauteur(noeud->gauche), hauteur(noeud->droite));
    int balance = equilibre(noeud);
    if (balance > 1 && e < noeud->gauche->e){
        return rotationDroite(noeud);
    }
    if (balance < -1 && e > noeud->droite->e){
        return rotationGauche(noeud);
    }
    if (balance > 1 && e > noeud->gauche->e) {
        noeud->gauche = rotationGauche(noeud->gauche);
        return rotationDroite(noeud);
    }
    if (balance < -1 && e < noeud->droite->e) {
        noeud->droite = rotationDroite(noeud->droite);
        return rotationGauche(noeud);
    }
    return noeud;
}

int equilibre(struct arbre_AVL *noeud) {
    if (noeud == NULL){
        return 0;
    }
    return hauteur(noeud->gauche) - hauteur(noeud->droite);
}

int hauteur(struct arbre_AVL *noeud) {
    if (noeud == NULL){
        return 0;
    }
    return noeud->hauteur;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

struct arbre_AVL *rotationDroite(struct arbre_AVL *y) {
    struct arbre_AVL *x = y->gauche;
    struct arbre_AVL *T2 = x->droite;

    x->droite = y;
    y->gauche = T2;

    y->hauteur = max(hauteur(y->gauche), hauteur(y->droite)) + 1;
    x->hauteur = max(hauteur(x->gauche), hauteur(x->droite)) + 1;

    return x;
}

struct arbre_AVL *rotationGauche(struct arbre_AVL *x) {
    struct arbre_AVL *y = x->droite;
    struct arbre_AVL *T2 = y->gauche;

    y->gauche = x;
    x->droite = T2;

    x->hauteur = max(hauteur(x->gauche), hauteur(x->droite)) + 1;
    y->hauteur = max(hauteur(y->gauche), hauteur(y->droite)) + 1;

    return y;
}

void InversionOrdreAVL(struct arbre_AVL *racine, FILE){
    if (racine!= NULL){
        InversionOrdreAVL(racine->droite,fichier);
        fprintf(file,"%d,%s",racine->e , racine->valeur);
        InversionOrdreAVL(racine->gauche, fichier);
    }
}

void parcours_Infixe(struct arbre_AVL *racine, FILE *fichier) {
    if (racine != NULL) {
        parcours_Infixe(racine->gauche, fichier);
        fprintf(fichier, "%d,%s",racine->e, racine->valeur);
        parcours_Infixe(racine->droite, fichier);
    }
}
