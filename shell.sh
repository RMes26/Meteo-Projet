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
    echo 'Il n y aura pas de données sur la Pression atmosphérique qui seront traitées !'
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

# ----------------------------------------------------------------- REGION -----------------------------------------------------------------------------------

region=''
#copie en supp la premier ligne explicant les emplacements dans le fichier meteo.csv
tail -n +2 meteo.csv > filtre.csv

case $@ in 
    
    *-F*)
        region='F'
        echo ' '
        echo ' Région sélectionnée : France métropolitaine + Corse. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv
        awk -F';' '$15 ~ /^[01-95]/ && $15 < 96000 {print}' meteoR.csv > filtre.csv
        echo 'Filtre France appliquée'
        echo ' '
    ;;

    *-G*)
        region='G'
        echo ' '
        echo 'Région sélectionnée : Guyane Française. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv
        awk -F';' '$15 ~ /^973/ {print}' meteoR.csv > filtre.csv
        echo 'Filtre Guyane appliqué!'
        echo ' '
    ;; 

    *-S*)
        region='S'
        echo ' '
        echo 'Région sélectionnée : Saint-Pierre et Miquelon (ile située à l’Est du Canada). Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv
        awk -F';' '$15 ~ /^975/ {print}' meteoR.csv > filtre.csv
        echo 'Filtre Saint-Pierre et Miquelon appliqué!'
        echo ' '
    ;;

    *-A*)
        region='A'
        echo ' '
        echo 'Région sélectionnée : Antilles. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv
        awk -F';' '$15 ~ /^971/ {print}' meteoR.csv > filtre.csv
        awk -F';' '$15 ~ /^972/ {print}' meteoR.csv >> filtre.csv
        awk -F';' '$15 ~ /^978/ {print}' meteoR.csv >> filtre.csv
        awk -F';' '$15 ~ /^977/ {print}' meteoR.csv >> filtre.csv
        echo 'Filtre Antilles appliqué!'
        echo ' '
    ;;

    *-O*)
        region="O"
        echo ' '
        echo 'Région sélectionnée : Océan indien. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv
        awk -F';' '$15 ~ /^974/ {print}' meteoR.csv > filtre.csv
        awk -F';' '$15 ~ /^976/ {print}' meteoR.csv >> filtre.csv
        echo 'Filtre Ocean Indien appliqué!'
        echo ' '
    ;;

    *-Q*)
        region='Q'
        echo ' '
        echo 'Région sélectionnée : Antarctique. Filtrage en cours.'
        tail -n +2 meteo.csv > meteoR.csv
        awk 'BEGIN {FS=";"}{if (($10<"-91") && ($10>"-59")) print }' meteoR.csv > filtre.csv
        echo 'Filtre Antarctique appliqué!'
        echo ' '        
    ;;

    *)
    echo 'Aucune région sélectionée !'
    ;;
esac

# ----------------------------------------------------------------- TRI -----------------------------------------------------------------------------------

option=0
tri=''

case $@ in 
    *--tab*)
        echo ' '
        echo 'Tri sera effectué à l’aide d’une structure linéaire'
        echo ' '
        tri='tab'
        (( option++ ))
    ;;

    *--abr*)
        echo ' '
        echo 'Tri sera effectué à l’aide d’une structure de type ABR'
        echo ' '
        tri='abr'
        (( option++ ))
    ;;

    *)
        echo ' '
        echo 'Tri sera effectué à l’aide d’une structure de type AVL'
        echo ' '
        tri='avl'
        (( option++))
    ;;

esac


# ----------------------------------------------------------------- TEMPERATURE 1 -----------------------------------------------------------------------------------

if [[ $mode == 1 ]]; then

    echo 'Mode 1 pour la température'
    awk -F ";" '$11 != ""' filtre.csv > meteot1.tmp
    sort -t, -k1,1 meteot1.tmp |awk -F';' '{if ($1!=p) {if (NR>1) print p,";",max; p=$1; max=$11} else {if ($11>max) max=$11}} END{print p,";",max}' > t1max.tmp
    sort -t, -k1,1 meteot1.tmp |awk -F';' '{if ($1!=p) {if (NR>1) print p,";",max; p=$1; max=$11} else {if ($11<max) max=$11}} END{print p,";",max}' > t1min.tmp
    join -t ";" -1 1 -2 1 t1max.tmp t1min.tmp > t1.tmp

    case $tri in 
        abr)
	        ./ABR.c.c t1.tmp
            echo 't1 tri abr en cours' 
        ;;

        tab)
	        ./TAB.c.c t1.tmp
            echo 't1 tri tab...'
        ;;

        *)
	        ./AVL.c.c t1.tmp
            grep -v "^$" sorted.csv > sorted.tmp
	        cat sorted.tmp > sorted.csv
            echo 't1 tri avl...' 
        ;;
    esac

    cat sorted.csv > meteot1.tmp
    echo 'resultat disponible dans le fichier meteot1.csv'

fi 

# ----------------------------------------------------------------- TEMPERATURE 2 -----------------------------------------------------------------------------------

if [[ $mode == 2 ]]; then
    echo 'Mode 2 pour la température'
    awk -F ";" '$11 != ""' filtre.csv > meteot2.tmp

    case $tri in 
        abr)
            ./ABR.c moy_date.tmp
            echo 't2 tri abr...'
        ;;

        tab)
            ./TAB.c moy_date.tmp
            echo 't2 tri tab...'
        ;;

        *)
            sort -t ';' -k1 moy_date.tmp > sorted.csv
        ;;
    esac

    cat  sorted.csv > meteot2.csv
    echo 'resultat disponible dans le fichier meteot2.csv'
fi

# ----------------------------------------------------------------- TEMPERATURE 3 -----------------------------------------------------------------------------------

if [[ $mode == 3 ]]; then
    echo 'Mode 3 pour la température'
    sort -t ";" -k2,2 -k1,1 filtre.csv > tridatestation.tmp
    cut -d ";" -f 1,2,11 tridatestation.tmp > meteot3.csv
    echo 'resultat disponible dans le fichier meteot3.csv'
fi

# ----------------------------------------------------------------- PRESSION 1 -----------------------------------------------------------------------------------

if [[ $pression == 1 ]]; then

    echo 'Mode 1 pour la pression'
    awk -F ";" '$7 != ""' filtre.csv > meteop1.tmp
    sort -t, -k1,1 meteop1.tmp |awk -F';' '{if ($1!=p) {if (NR>1) print p,";",max; p=$1; max=$7} else {if ($7>max) max=$7}} END{print p1,";",max}' > p1max.tmp
    sort -t, -k1,1 meteop1.tmp |awk -F';' '{if ($1!=p) {if (NR>1) print p,";",max; p=$1; max=$7} else {if ($7<max) max=$7}} END{print p,";",max}' > p1min.tmp
    join -t ";" -1 1 -2 1 p1max.tmp p1min.tmp > meteop1.tmp
    
    case $tri in 
        abr)
            ./ABR.c pfin.tmp
            echo 'tri abr p1'
        ;;

        tab)
            ./TAB.c pfin.tmp
            echo 'tri tab...'
        ;;

        *)
            ./AVL.c pfin.tmp
            grep -v "^$" sorted.csv > sorted.tmp
            cat sorted.tmp > sorted.csv
            echo ' p1 tri avl...' 
        ;;
    esac

    cat sorted.csv > meteop1.csv
    echo 'resultat disponible dans le fichier meteo1.csv'
fi

# ----------------------------------------------------------------- PRESSION 2 -----------------------------------------------------------------------------------

if [[ $pression == 2 ]]; then
    echo 'Mode 2 pour la pression'
    awk -F ";" '$7 != ""' filtre.csv > meteop2.tmp

    case $tri in 
        abr) 
            ./ABR.c moypression.tmp
            echo 'p2 tri abr...'
        ;;

        tab)
            ./TAB.c moypression.tmp
            echo 'tri tab...' 
        ;;

        *)
            sort -t ';' -k1 moypression.tmp > sorted.csv
            echo 'p2 tri avl...' 
        ;;
    esac

    cat sorted.csv > trip2.csv
    echo 'resultat disponible dans le fichier trip2.csv'
fi

# ----------------------------------------------------------------- PRESSION 3 -----------------------------------------------------------------------------------

if [[ $pression == 3 ]]; then
    echo 'mode 3 pour la pression'
    sort -t ";" -k2,2 -k1,1 filtre.csv > tridatestationpression.csv
    cut -d ";" -f 1,2,7 tridatestationpression.csv > trip3.csv
    echo 'resultat disponible dans le fichier trip3.csv'
fi

# ----------------------------------------------------------------- VENT -----------------------------------------------------------------------------------

if [[ $wind == 1 ]]; then
    echo 'Vent !!!!!'
    awk -F ";" '$4 != ""' filtre.csv > meteov.tmp
    cut -d ";" -f 1,10 filtre.csv > coordonnees0.tmp
    sed 's/,/;/g' coordonnees0.tmp > coordonnees1.tmp
    sort -t ";" -k1 coordonnees1.tmp > coordonnees2.tmp
    sort coordonnees2.tmp | uniq > coordonnees.tmp
    join -t ";" -1 1 -2 1 dirmoy.tmp vitessemoy.tmp > dirvitmoy.tmp

    case $tri in
        abr) 
            ./ABR.c dirvitmoy.tmp
            echo 'vent tri abr...' 
        ;;
        tab)
            ./TAB.c dirvitmoy.tmp
            echo 'vent tri tab...'
        ;;

        *)
            ./AVL.c dirvitmoy.tmp
            grep -v "^$" sorted.csv > sorted.tmp
            cat sorted.tmp > sorted.csv
            echo 'vent tri avl...' 
        ;;
    esac

    cat sorted.csv > triwind.csv
    sed 's/ ;/;/g' triwind.csv > triiiwind.tmp
    sed 's/ ;/;/g' triiiwind.tmp > triiiiwind.tmp
    sort -t ';' -k1 triiiiwind.tmp > triiwind.tmp
    sed 's/ ;/;/g' coordonnees.tmp > coordonneees.tmp
    echo 'resultat disponible dans le fichier triwind.csv'
fi

# ----------------------------------------------------------------- ALTITUDE -----------------------------------------------------------------------------------

if [[ $height == 1 ]]; then
    echo 'Altitude !!!!'
    sort -t';' -k1 filtre.csv > resheight.tmp
    awk -F ";" '!a[$1]++' resheight.tmp > resheight2.tmp
    cut -d ";" -f 1,14 resheight2.tmp > resheightfinal.tmp
    sort -t ';' -k2nr  resheightfinal.tmp > triheight.csv
    cut -d ";" -f 1,10 filtre.csv > coordonnees0.tmp
    sed 's/,/;/g' coordonnees0.tmp > coordonnees1.tmp
    sort -t ";" -k1 coordonnees1.tmp > coordonnees2.tmp
    sort coordonnees2.tmp | uniq > coordonnees.tmp
    sed 's/ ;/;/g' triheight.csv > triiheight.tmp

    case $tri in
        abr)
            ./ABR.c triiheight.tmp
            echo 'tri abr...' 
        ;;

        tab) 
            ./TAB.c triiheight.tmp
            echo 'tri tab...'
        ;;
        *)
            ./AVL.c triiheight.tmp
            grep -v "^$" sorted.csv > sorted.tmp
            cat sorted.tmp > sorted.csv
            echo 'tri avl...' 
        ;;
    esac
    
    cat sorted.csv > triiiheight.tmp
    sed 's/ ;/;/g' coordonnees.tmp > coordonneees.tmp
fi

# ----------------------------------------------------------------- HUMIDITE -----------------------------------------------------------------------------------

if [[ $moisture == 1 ]]; then
    echo 'Humidite !!!!!'
    awk -F ";" '$6 != ""' filtre.csv > meteoh.tmp
    cut -d ";" -f 1,10 filtre.csv > coordonnees0.tmp
    sed 's/,/;/g' coordonnees0.tmp > coordonnees1.tmp
    sort -t ";" -k1 coordonnees1.tmp > coordonnees2.tmp
    sort coordonnees2.tmp | uniq > coordonnees.tmp
    awk -F ";" '!a[$1]++' maxmoisture.tmp > maxmoisture2.tmp
    sort -t ";" -k2nr maxmoisture.csv > trimoisture.csv
    sed 's/ ;/;/g' trimoisture.csv > triimoisture.tmp

    case $tri in
        abr)
            ./ABR.c triimoisture.tmp
            echo 'tri abr...'
        ;;

        tab)
            ./TAB.c triimoisture.tmp
            echo 'tri tab...'
        ;;

        *)
            ./AVL.c triimoisture.tmp
            grep -v "^$" sorted.csv > sorted.tmp
            cat sorted.tmp > sorted.csv
            echo 'tri avl...'
        ;;
esac
    
    cat sorted.csv > triiimoisture.tmp
    sed 's/ ;/;/g' coordonnees.tmp > coordonneees.tmp
fi
