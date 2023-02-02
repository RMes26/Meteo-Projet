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


/*****************************************************************/  
/*****************************AVL*********************************/
/*****************************************************************/


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


void parcours_Infixe(struct arbre_AVL *racine, FILE *fichier) {
    if (racine != NULL) {
        parcours_Infixe(racine->gauche, fichier);
        fprintf(fichier, "%d,%s",racine->e, racine->valeur);
        parcours_Infixe(racine->droite, fichier);
    }
}


/*************************************************************/
/****************************TABLEAU**************************/
/*************************************************************/


struct Info {
    int e;
    char *valeur;
};

int comparer(const void *a, const void *b) {
    struct Info *info1 = (struct Info *)a;
    struct Info *info2 = (struct Info *)b;
    return info1->e - info2->e;
}


/*************************************************************/
/**************************MAIN*******************************/
/*************************************************************/

int main(int argc, char *argv[]) {
    int cpt = 0;
    int croissant;
    croissant = 1;
    char input[1024];
    char output[1024];
    char tri_type[1024] = "--avl";
    for (cpt=0; cpt<argc; cpt++){
        // Chemin d'entrée du fichier
        if (strcmp(argv[cpt],"-f") == 0){       // comparer deux chaine de caractère 
            strcpy(input,argv[cpt+1]);  
        }
        // Chemin de sortie du fichier
        if(strcmp(argv[cpt],"-o") == 0){ 
            strcpy(output,argv[cpt+1]);
        }

        // Chemin si ascendent ou descendent
        if(strcmp(argv[cpt],"-r") == 0){
            croissant = 0;
        }
        // type de d'algorithme de tri
        if(strcmp(argv[cpt],"--tab") == 0){
            strcpy(tri_type,"--tab");
        }
        if (strcmp(argv[cpt],"--abr") == 0){
            strcpy(tri_type,"--abr");
        }
    }


    /************************AVL Main*********************/

 
   /*if (strcmp(tri_type,"--avl") == 0){                     
        FILE *fichier = fopen(input, "r");
        struct arbre_AVL *racine = NULL;
        char ligne[1024];
        char nom[1024] = "trié_";
        while (fgets(ligne, 1024, fichier)) {
            char *premiere_colone = strtok(ligne, ",");
            int e = atoi(strtok(ligne, ","));
            char *valeur = strdup(ligne + strlen(premiere_colone) + 1);
            racine = insert_AVL(racine, e, valeur);
        }
        fclose(fichier);
        strcat(nom,argv[2]);
        if (croissant == 0){
            saveToCSV_AVL(racine, output, parcours_Infixe);
        }
        else{
        saveToCSV_AVL(racine, output, reverseInOrder_AVL);
        }
        return 0;
    }


    /************************ABR Main*********************/
    /*else if (strcmp(tri_type,"--abr") == 0 ){
        struct arbre_ABR *racine = NULL;
        FILE *fichier = fopen(input, "r");
        char ligne[1024];
        char nom[1024] = "trié_";
        
        while (fgets(ligne, 1024, fichier)) {
            char *premiere_colone = strtok(ligne, ",");
            int e = atoi(premiere_colone);
            char *valeur = strdup(ligne + strlen(premiere_colone) + 1);/
            racine = insertABR(racine, e, valeur);
        }
        strcat(nom,argv[2]);
        saveToCSV_BST(racine, output,croissant);
        fclose(fichier);
        return 0;
    } */

    /*************************************************************/
    /*************************TABLEAU*****************************/
    /*************************************************************/

    else if (strcmp(tri_type,"--tab") == 0 ){
        FILE *fichier = fopen(input, "r");
        char ligne[1024];
        int taille = 0;
        struct Info *info = NULL;
        char *premiere_ligne = NULL;
        char nom[1024] = "trié_";
        int i = 0;
        while (fgets(ligne, 1024, fichier)) {
            if (i == 0) {
                premiere_ligne = strdup(ligne);
                i++;
                continue;
            }
            info = realloc(info, (taille + 1) * sizeof(struct Info));
            char *premiere_colone = strtok(ligne, ",");  //extraire tous les elements un à un 
            int e = atoi(strtok(ligne, ","));            //transformer chaine de caractere en un int 
            char *valeur = strdup(ligne + strlen(premiere_colone) + 1); //duplication de la chaine de caractere 
            info[taille].e = e;
            info[taille].valeur = valeur;
            taille++;
        }
        fclose(fichier); 
        qsort(info, taille, sizeof(struct Info), comparer);
        strcat(nom,argv[2]);                            // concatener deux chaines 
        FILE *outfile = fopen(output, "w");
        fprintf(outfile, "%s", premiere_ligne);
        if (croissant == 0){
            for (int i = taille - 1; i >= 0; i--){
            fprintf(outfile, "%s", info[i].valeur);
            }
        }
        else{
            for (int i = 0; i < taille; i++) {
                fprintf(outfile, "%d,%s",info[i].e,info[i].valeur);
            }
        }
        fclose(outfile);
        return 0;
    }
    else{
        printf("Erreur\n");
        return 3;
    }
}
