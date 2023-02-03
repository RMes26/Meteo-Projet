#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int  main ( int argc, char *argv[]) {
    int cpt = 0 ;
    int croissant;
    croissant = 1 ;
    char donnee  [ 1024 ] ;
    char reslutats  [ 1024 ] ;
    char tri_type[ 1024 ] = " --avl " ;
    for (cpt= 0 ; cpt<argc; cpt++){
        // entrée du fichier
        if ( strcmp (argv[cpt], " -f " ) == 0 ){  //compare deux chaines de caracteres 
            strcpy (donnee,argv[cpt+ 1 ]);        //copier le contenue d'une chaine de caracteres dans une autre 
        }
        // sortie du fichier
        if ( strcmp (argv[cpt], " -o " ) == 0 ){
            strcpy (reslutats,argv[cpt+ 1 ]);
        }

        // si ascendant ou descendant
        if ( strcmp (argv[cpt], " -r " ) == 0 ){
            croissant = 0 ;
        }
        // type de tri abr ou tab 
        if ( strcmp (argv[cpt], " --tab " ) == 0 ){
            strcpy (tri_type, " --tab " );
        }
        if ( strcmp (argv[cpt], " --abr " ) == 0 ){
            strcpy (tri_type, " --abr " );
        }
    }
}

    //AVL principal 

 
    if (strcmp(tri_type,"--avl") == 0){                     
        FILE *fichier = fopen(input, "r");                            //ouverture du flux
        struct arbre_AVL *racine = NULL;
        char ligne[1024] ;
        char nom[1024] = "trié_" ;
        while (fgets(ligne, 1024, fichier)) {                         //lire une chaine de caracteres a partir d'un flux
            char *premiere_colone = strtok(ligne, ",");
            int e = atoi(strtok(ligne, ","));                         //transformer un char en int et extraire tous les caracteres un a un 
            char *valeur = strdup(ligne + strlen(premiere_colone) + 1);
            racine = insert_AVL(racine, e, valeur);
        }
        fclose(fichier);                                              // fermeture du flux
        strcat(nom,argv[2]);                                          //concatener deux chaines de caracetres 
        if (croissant == 0){
            sauvegarde_AVL(racine, reslutats, parcours_Infixe);
        }
        else{
        sauvegarde_AVL(racine, reslutats, InversionOrdreAVL);
        }
        return 0 ;
    }
    // ABR principal 

     else if (strcmp(tri_type,"--abr") == 0 ){
        struct arbre_ABR *racine = NULL;
        FILE *fichier = fopen(input, "r");
        char ligne[1024] ;
        char nom[1024] = "trié_" ;
        
        while (fgets(ligne, 1024, fichier)) {
            char *premiere_colone = strtok(ligne, ",");
            int e = atoi(premiere_colone);
            char *valeur = strdup(ligne + strlen(premiere_colone) + 1); // duplication des chaines de caracteres 
            racine = insertABR(racine, e, valeur);
        }
        strcat(nom,argv[2]);
        sauvegarde_ABR(racine, reslutats, croissant);
        fclose(fichier);
        return 0; }


    // TAB


    else if ( strcmp (tri_type, " --tab " ) == 0 ){
        FILE *fichier = fopen (donnee, " r " );
        char ligne[ 1024 ] ;
        int taille = 0 ;
        struct Info *info = NULL ;
        char *première_ligne = NULL ;
        char nom[ 1024 ] = " trié_ " ;
        int i = 0 ;
        while ( fgets (ligne, 1024 , fichier)) {
            if (i == 0 ){
                premiere_ligne = strdup (ligne);
                i++ ;
                continue ;
            }
            info = realloc (info, (taille + 1 ) * sizeof ( struct Info));
            char *premiere_colone = strtok (ligne, " , " );
            int e = atoi ( strtok (ligne, " , " ));
            char *valeur = strdup (ligne + strlen (premiere_colone) + 1 );
            info[taille]. e = e;
            info[taille]. valeur = valeur;
            taille++;
        }
        fclose (fichier);
        qsort (info, taille, sizeof ( struct Info), comparer);   //tri du tableau
        strcat (nom,argv[ 2 ]);
        FILE *outfile = fopen (reslutats, " w " );
        fprintf (outfile, " %s " , premiere_ligne);
        if (croissant == 0 ){
            for ( int je = taille - 1 ; je >= 0 ; je--){
            fprintf (outfile, " %s " , info[i]. valeur );
            }
        }
        else {
            for ( int je = 0 ; je < taille; je++) {
                fprintf (outfile, " %d , %s " ,info[i]. e ,info[i]. valeur );
            }
        }
        fclose (outfile);
        return  0 ;
    }
    else {
        printf ( " Erreur \n " );
        return 3;
}
