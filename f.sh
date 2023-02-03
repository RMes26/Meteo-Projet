t1
awk -F ";" '$11 != ""' filtre.csv > meteot1.tmp
    sort -t, -k1,1 meteot1.tmp |awk -F';' '{if ($1!=p) {if (NR>1) print p,";",max; p=$1; max=$11} else {if ($11>max) max=$11}} END{print p,";",max}' > t1max.tmp
    sort -t, -k1,1 meteot1.tmp |awk -F';' '{if ($1!=p) {if (NR>1) print p,";",max; p=$1; max=$11} else {if ($11<max) max=$11}} END{print p,";",max}' > t1min.tmp
    join -t ";" -1 1 -2 1 t1max.tmp t1min.tmp > t1.tmp

    avl 
                grep -v "^$" sorted.csv > sorted.tmp
	        cat sorted.tmp > sorted.csv
    
    
cat sorted.csv > meteot1.tmp

t2 
awk -F ";" '$11 != ""' filtre.csv > meteot2.tmp

avl sort -t ';' -k1 t2.tmp > sorted.csv


    cat  sorted.csv > meteot2.csv

t3
sort -t ";" -k2,2 -k1,1 filtre.csv > tridatestation.tmp
    cut -d ";" -f 1,2,11 tridatestation.tmp > meteot3.csv

p1
    awk -F ";" '$7 != ""' filtre.csv > meteop1.tmp
    sort -t, -k1,1 meteop1.tmp |awk -F';' '{if ($1!=p) {if (NR>1) print p,";",max; p=$1; max=$7} else {if ($7>max) max=$7}} END{print p1,";",max}' > p1max.tmp
    sort -t, -k1,1 meteop1.tmp |awk -F';' '{if ($1!=p) {if (NR>1) print p,";",max; p=$1; max=$7} else {if ($7<max) max=$7}} END{print p,";",max}' > p1min.tmp
    join -t ";" -1 1 -2 1 p1max.tmp p1min.tmp > meteop1.tmp

avl
            grep -v "^$" sorted.csv > sorted.tmp
            cat sorted.tmp > sorted.csv

    cat sorted.csv > meteop1.csv

p2 awk -F ";" '$7 != ""' filtre.csv > meteop2.tmp
avl  sort -t ';' -k1 p2.tmp > sorted.csv
    cat sorted.csv > trip2.csv

p3     sort -t ";" -k2,2 -k1,1 filtre.csv > tridatestationpression.csv
    cut -d ";" -f 1,2,7 tridatestationpression.csv > trip3.csv

ventawk -F ";" '$4 != ""' filtre.csv > meteov.tmp
    cut -d ";" -f 1,10 filtre.csv > coordonnees0.tmp
    sed 's/,/;/g' coordonnees0.tmp > coordonnees1.tmp
    sort -t ";" -k1 coordonnees1.tmp > coordonnees2.tmp
    sort coordonnees2.tmp | uniq > coordonnees.tmp
    join -t ";" -1 1 -2 1 dirmoy.tmp vitessemoy.tmp > dirvitmoy.tmp
avl
                grep -v "^$" sorted.csv > sorted.tmp
            cat sorted.tmp > sorted.csv


    cat sorted.csv > triwind.csv
    sed 's/ ;/;/g' triwind.csv > triiiwind.tmp
    sed 's/ ;/;/g' triiiwind.tmp > triiiiwind.tmp
    sort -t ';' -k1 triiiiwind.tmp > triiwind.tmp
    sed 's/ ;/;/g' coordonnees.tmp > coordonneees.tmp

Altitude
sort -t';' -k1 filtre.csv > resheight.tmp
    awk -F ";" '!a[$1]++' resheight.tmp > resheight2.tmp
    cut -d ";" -f 1,14 resheight2.tmp > resheightfinal.tmp
    sort -t ';' -k2nr  resheightfinal.tmp > triheight.csv
    cut -d ";" -f 1,10 filtre.csv > coordonnees0.tmp
    sed 's/,/;/g' coordonnees0.tmp > coordonnees1.tmp
    sort -t ";" -k1 coordonnees1.tmp > coordonnees2.tmp
    sort coordonnees2.tmp | uniq > coordonnees.tmp
    sed 's/ ;/;/g' triheight.csv > triiheight.tmp
avl 
            grep -v "^$" sorted.csv > sorted.tmp
            cat sorted.tmp > sorted.csv
        
            cat sorted.csv > triiiheight.tmp
    sed 's/ ;/;/g' coordonnees.tmp > coordonneees.tmp

Humiditié
    awk -F ";" '$6 != ""' filtre.csv > meteoh.tmp
    cut -d ";" -f 1,10 filtre.csv > coordonnees0.tmp
    sed 's/,/;/g' coordonnees0.tmp > coordonnees1.tmp
    sort -t ";" -k1 coordonnees1.tmp > coordonnees2.tmp
    sort coordonnees2.tmp | uniq > coordonnees.tmp
    awk -F ";" '!a[$1]++' maxmoisture.tmp > maxmoisture2.tmp
    sort -t ";" -k2nr maxmoisture.csv > trimoisture.csv
    sed 's/ ;/;/g' trimoisture.csv > triimoisture.tmp

    avl
                grep -v "^$" sorted.csv > sorted.tmp
            cat sorted.tmp > sorted.csv
    
    
    cat sorted.csv > triiimoisture.tmp
    sed 's/ ;/;/g' coordonnees.tmp > coordonneees.tmp
