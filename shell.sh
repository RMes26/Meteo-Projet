#!/bin/bash

#ajouter -f + --help
#supprimer -d + tous les awk avec date1/2 + tri inversé 
#si mets -t2 et -t1 sa sera le t1 qui l'emportera de meme pour la pression
# si mets --abr et --avl sa sera le abr qui sera pris en compte


# ----------------------------------------------------------------- TEMPERATURE -----------------------------------------------------------------------------------

option=0
mode=0

case $@ in 

    *-t1*) 
    echo ' '
    echo 'Les températures minimales, maximales et moyennes par station dans l’ordre croissant du numéro de station'
    echo ' '
    mode=1
    (( option++ ))
    ;;

    *-t2*)
    echo ' '
    echo 'Les températures moyennes par date/heure, triées dans l’ordre chronologique. La moyenne se fait sur toutes les stations.' 
    echo ' '
    mode=2
    (( option++ ))
    ;;

    *-t3*)
    echo ' '
    echo 'Les températures par date/heure par station. Elles seront triées d’abord par ordre chronologique, puis par ordre croissant de l’identifiant de la station'
    echo ' '
    mode=3
    (( option++ ))
    ;;

    *)
    echo 'Il n y aura pas de données sur la Température qui seront traitées !'
    ;;

esac

# ----------------------------------------------------------------- PRESSION -----------------------------------------------------------------------------------

pression=0

case $@ in 
        *-p1*)
        echo ' '
        echo 'Les pressions minimales, maximales et moyennes par station dans l’ordre croissant du numéro de station.' 
        echo ' '
        pression=1
        (( option++ )) 
    ;;

    *-p2*)
        echo ' '
        echo 'Les pressions moyennes par date/heure, triées dans l’ordre chronologique. La moyenne se fait sur toutes les stations.'
        echo ' '
        pression=2
        (( option++ ))
    ;;

    *-p3*)
        echo ' '
        echo 'Les pressions par date/heure par station. Elles seront triées d’abord par ordre chronologique, puis par ordre croissant de l’identifiant de la station'
        echo ' '
        pression=3
        (( option++ ))
    ;;

    *)
    echo 'Il n y aura pas de données sur la Pression Atmosphérique qui seront traitées !'
    ;;
esac

# ----------------------------------------------------------------- VENT -----------------------------------------------------------------------------------

wind=0
if [[ $@ =~ '-w' ]]; then
    echo ' '
    echo 'L’orientation moyenne et la vitesse moyenne des vents pour chaque station.' 
    echo ' '
    wind=1
    (( option++ ))
else
    echo 'Il n y aura pas de données sur le Vent qui seront traitées !'
fi

# ----------------------------------------------------------------- ALTITUDE -----------------------------------------------------------------------------------

height=0
if [[ $@ =~ '-h' ]]; then
    echo ' '
    echo 'Altitude pour chaque station.'
    echo ' '
    height=1
    (( option++ ))
else
    echo 'Il n y aura pas de données sur l Altitude qui seront traitées !' 
fi

# ----------------------------------------------------------------- HUMIDITE -----------------------------------------------------------------------------------

moisture=0
if [[ $@ =~ '-m' ]]; then
    echo ' ' 
    echo 'Humidité maximale pour chaque station.' 
    echo ' '
    moisture=1
    (( option++ ))
else
    echo 'Il n y aura pas de données sur l Humiditié qui seront traitées !'
fi

# ----------------------------------------------------------------- OPTION -----------------------------------------------------------------------------------

if [ $option == 0 ]; then    
    echo ' '
    echo 'Veuillez ajouter une ou plusieurs options suivantes !!!'
    echo ' '
    echo 'LISTE DES OPTIONS DISPONIBLE :'
    echo ' '
    echo 'Température : -t1 ; -t2 ; -t3'
    echo ' '
    echo 'Préssion Atmosphérique : -p1; -p2; -p3'
    echo ' '
    echo 'Vent : -w'
    echo ' '
    echo 'Humidité : -m'
    echo ' '
    echo 'ALtitude : -h'
    echo ' '
    echo 'Date : -d'
    echo ' '
    echo 'Tri AVL (par défaut) : --avl'
    echo ' '
    echo 'Tri Tableau : --tab'
    echo ' '

    exit; 
fi

# ----------------------------------------------------------------- TRI -----------------------------------------------------------------------------------

tri=''

case $@ in 
    *--tab*)
        echo ' '
        echo 'Tri sera effectué à l’aide d’une structure linéaire'
        echo ' '
        tri='tab'
    ;;

    *--abr*)
        echo ' '
        echo 'Tri sera effectué à l’aide d’une structure de type ABR'
        echo ' '
        tri='abr'
    ;;

    *)
        echo ' '
        echo 'Tri sera effectué à l’aide d’une structure de type AVL'
        echo ' '
        tri='avl'
    ;;

esac

# ----------------------------------------------------------------- REGION -----------------------------------------------------------------------------------

region=''
#copie en supp la premiere ligne explicant les emplacements dans le fichier meteo.csv


case $@ in 
    
    *-F*)
        region='F'
        echo 'Région sélectionnée : France métropolitaine + Corse. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv

        awk '{split($10,f,","); if(f[1] + 0 <= 55 && f[1] + 0 >= 40 && f[2] + 0 >= -10 && f[2] +0 <= 10) print $0;}' FS=";" meteoR.csv > filtre.csv

        echo 'Filtre France appliquée'
        echo ' '
    ;;

    *-G*)
        region='G'
        echo 'Région sélectionnée : Guyane Française. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv

        awk '{split($10,g,","); if(g[1] + 0 <= 10 && g[1] + 0 >= 2 && g[2] + 0 >= -60 && g[2] +0 <= 60) print $0;}' FS=";" meteoR.csv > filtre.csv
       
        echo 'Filtre Guyane appliqué!'
        echo ' '
    ;; 

    *-S*)
        region='S'
        echo 'Région sélectionnée : Saint-Pierre et Miquelon (ile située à l’Est du Canada). Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv

        awk '{split($10,s,","); if(s[1] + 0 <= 47 && s[1] + 0 >= 46 && s[2] + 0 >= -60 && s[2] +0 <= -50) print $0;}' FS=";" meteoR.csv > filtre.csv

        echo 'Filtre Saint-Pierre et Miquelon appliqué!'
        echo ' '
    ;;

    *-A*)
        region='A'
        echo 'Région sélectionnée : Antilles. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv

        awk '{split($10,a,","); if(a[1] + 0 <= 20 && a[1] + 0 >= 10 && a[2] + 0 >= -70 && a[2] +0 <= -55) print $0;}' FS=";" meteoR.csv > filtre.csv
        
        echo 'Filtre Antilles appliqué!'
        echo ' '
    ;;

    *-O*)
        region='O'
        echo 'Région sélectionnée : Océan indien. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv

        awk '{split($10,o,","); if(o[1] + 0 >= -55 && o[1] + 0 <= 20 && o[2] + 0 >= 20 && o[2] +0 s= 135) print $0;}' FS=";" meteoR.csv > filtre.csv

        echo 'Filtre Ocean Indien appliqué!'
        echo ' '
    ;;

    *-Q*)
        region='Q'
        echo 'Région sélectionnée : Antarctique. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv

        awk '{split($10,q,","); if(q[1] + 0 <= -60) print $0;}' FS=";" meteoR.csv > filtre.csv

        echo 'Filtre Antarctique appliqué!'
        echo ' '        
    ;;

    *)
    echo 'Aucune région sélectionée !'
    ;;
esac
    rm meteoR.csv

# ----------------------------------------------------------------- TEMPERATURE 1 -----------------------------------------------------------------------------------

if [[ $mode == 1 ]]; then

    echo 'Mode 1 pour la température'
    
    case $tri in 
        abr)
	        ./ABR.c t1.tmp
            echo 't1 tri abr en cours' 
        ;;

        tab)
	        ./TAB.c t1.tmp
            echo 't1 tri tab...'
        ;;

        *)
	        ./AVL.c t1.tmp

            echo 't1 tri avl...' 
        ;;
    esac

    
    echo 'resultat disponible dans le fichier meteot1.csv'

fi 

# ----------------------------------------------------------------- TEMPERATURE 2 -----------------------------------------------------------------------------------

if [[ $mode == 2 ]]; then
    echo 'Mode 2 pour la température'
    

    case $tri in 
        abr)
            ./ABR.c t2.tmp
            echo 't2 tri abr...'
        ;;

        tab)
            ./TAB.c t2.tmp
            echo 't2 tri tab...'
        ;;

        *)
            
        ;;
    esac

    echo 'resultat disponible dans le fichier meteot2.csv'
fi

# ----------------------------------------------------------------- TEMPERATURE 3 -----------------------------------------------------------------------------------

if [[ $mode == 3 ]]; then
    echo 'Mode 3 pour la température'
    
    echo 'resultat disponible dans le fichier meteot3.csv'
fi

# ----------------------------------------------------------------- PRESSION 1 -----------------------------------------------------------------------------------

if [[ $pression == 1 ]]; then

    echo 'Mode 1 pour la pression'
    
    
    case $tri in 
        abr)
            ./ABR.c p1.tmp
            echo 'tri abr p1'
        ;;

        tab)
            ./TAB.c p1.tmp
            echo 'tri tab...'
        ;;

        *)
            ./AVL.c p1.tmp

            echo ' p1 tri avl...' 
        ;;
    esac


    echo 'resultat disponible dans le fichier meteo1.csv'
fi

# ----------------------------------------------------------------- PRESSION 2 -----------------------------------------------------------------------------------

if [[ $pression == 2 ]]; then
    echo 'Mode 2 pour la pression'
    

    case $tri in 
        abr) 
            ./ABR.c p2.tmp
            echo 'p2 tri abr...'
        ;;

        tab)
            ./TAB.c p2.tmp
            echo 'tri tab...' 
        ;;

        *)
           
            echo 'p2 tri avl...' 
        ;;
    esac


    echo 'resultat disponible dans le fichier trip2.csv'
fi

# ----------------------------------------------------------------- PRESSION 3 -----------------------------------------------------------------------------------

if [[ $pression == 3 ]]; then
    echo 'mode 3 pour la pression'

    echo 'resultat disponible dans le fichier p3.csv'
fi

# ----------------------------------------------------------------- VENT -----------------------------------------------------------------------------------

if [[ $wind == 1 ]]; then
    echo 'Vent !!!!!'
    

    case $tri in
        abr) 
            ./ABR.c vent.tmp
            echo 'vent tri abr...' 
        ;;
        tab)
            ./TAB.c vent.tmp
            echo 'vent tri tab...'
        ;;

        *)
            ./AVL.c vent.tmp
            grep -v "^$" sorted.csv > sorted.tmp
            cat sorted.tmp > sorted.csv
            echo 'vent tri avl...' 
        ;;
    esac

    echo 'resultat disponible dans le fichier triwind.csv'
fi

# ----------------------------------------------------------------- ALTITUDE -----------------------------------------------------------------------------------

if [[ $height == 1 ]]; then
    echo 'Altitude !!!!'
    

    case $tri in
        abr)
            ./ABR.c altitude.tmp
            echo 'tri abr...' 
        ;;

        tab) 
            ./TAB.c altitude.tmp
            echo 'tri tab...'
        ;;
        *)
            ./AVL.c altitude.tmp

            echo 'tri avl...' 
        ;;
    esac
    

fi

# ----------------------------------------------------------------- HUMIDITE -----------------------------------------------------------------------------------

if [[ $moisture == 1 ]]; then
    echo 'Humidite !!!!!'


    case $tri in
        abr)
            ./ABR.c humidité.tmp
            echo 'tri abr...'
        ;;

        tab)
            ./TAB.c humidité.tmp
            echo 'tri tab...'
        ;;

        *)
            ./AVL.c humidité.tmp

            echo 'tri avl...'
        ;;
esac

fi