#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int  main ( int argc, char *argv[]) {
    cpt entier = 0 ;
    int croissant;
    croissant = 1 ;
    entrée char [ 1024 ] ;
    sortie char [ 1024 ] ;
    char tri_type[ 1024 ] = " --avl " ;
    pour (cpt= 0 ; cpt<argc; cpt++){
        // Chemin d'entrée du fichier
        si ( strcmp (argv[cpt], " -f " ) == 0 ){
            strcpy (entrée,argv[cpt+ 1 ]);
        }
        // Chemin de sortie du fichier
        si ( strcmp (argv[cpt], " -o " ) == 0 ){
            strcpy (sortie,argv[cpt+ 1 ]);
        }

        // Chemin si ascendant ou descendant
        si ( strcmp (argv[cpt], " -r " ) == 0 ){
            croissant = 0 ;
        }
        // type d'algorithme de tri
        si ( strcmp (argv[cpt], " --tab " ) == 0 ){
            strcpy (tri_type, " --tab " );
        }
        si ( strcmp (argv[cpt], " --abr " ) == 0 ){
            strcpy (tri_type, " --abr " );
        }
    }


    /* *********************** AVL principal ******************** */

 
   /* si (strcmp(tri_type,"--avl") == 0){                     
        FICHIER *fichier = fopen(input, "r");
        struct arbre_AVL *racine = NULL;
        char ligne[1024] ;
        char nom[1024] = "trié_" ;
        tandis que (fgets(ligne, 1024, fichier)) {
            char *premiere_colone = strtok(ligne, ",");
            int e = atoi(strtok(ligne, ","));
            char *valeur = strdup(ligne + strlen(premiere_colone) + 1);
            racine = insert_AVL(racine, e, valeur);
        }
        fermer(fichier);
        strcat(nom,argv[2]);
        si (croissant == 0){
            saveToCSV_AVL(racine, output, parcours_Infixe);
        }
        autre{
        saveToCSV_AVL(racine, sortie, reverseInOrder_AVL);
        }
        renvoie 0 ;
    }
    /************************ ABR principal ******************** */
    /* sinon si (strcmp(tri_type,"--abr") == 0 ){
        struct arbre_ABR *racine = NULL;
        FICHIER *fichier = fopen(input, "r");
        char ligne[1024] ;
        char nom[1024] = "trié_" ;
        
        tandis que (fgets(ligne, 1024, fichier)) {
            char *premiere_colone = strtok(ligne, ",");
            int e = atoi(premiere_colone);
            char *valeur = strdup(ligne + strlen(premiere_colone) + 1);
            racine = insertABR(racine, e, valeur);
        }
        strcat(nom,argv[2]);
        saveToCSV_BST(racine, sortie, croissant);
        fermer(fichier);
        renvoie 0 ;
    } */


    /* ******************TAB*************************** */


    sinon  si ( strcmp (tri_type, " --tab " ) == 0 ){
        FICHIER *fichier = fopen (entrée, " r " );
        char ligne[ 1024 ] ;
        int taille = 0 ;
        struct Info *info = NULL ;
        char *première_ligne = NULL ;
        char nom[ 1024 ] = " trié_ " ;
        entier je = 0 ;
        tandis que ( fgets (ligne, 1024 , fichier)) {
            si (je == 0 ) {
                premiere_ligne = strdup (ligne);
                je++ ;
                continuer ;
            }
            info = realloc (info, (taille + 1 ) * sizeof ( struct Info));
            char *premiere_colone = strtok (ligne, " , " );
            int e = atoi ( strtok (ligne, " , " ));
            char *valeur = strdup (ligne + strlen (premiere_colone) + 1 );
            info[taille]. e = e;
            info[taille]. valeur = valeur;
            taille++;
        }
        fermer (fichier);
        qsort (info, taille, sizeof ( struct Info), comparer);
        strcat (nom,argv[ 2 ]);
        FICHIER *outfile = fopen (sortie, " w " );
        fprintf (outfile, " %s " , premiere_ligne);
        si (croissant == 0 ){
            for ( int je = taille - 1 ; je >= 0 ; je--){
            fprintf (outfile, " %s " , info[i]. valeur );
            }
        }
        sinon {
            for ( int je = 0 ; je < taille; je++) {
                fprintf (outfile, " %d , %s " ,info[i]. e ,info[i]. valeur );
            }
        }
        fclose (fichier de sortie);
        retourne  0 ;
    }
    sinon {
        printf ( " Erreur \n " );
        retour  3 ;
    }
}