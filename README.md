# Meteo-Projet

Pour lancer notre programme, il faut tout d'abord télécharger tous les fichier .c,.h ainsi que .sh. Par la suite, il faut (si ce n'est pas fais automatiquement fais) donner tous les droits aux fichiers téléchargé précédemment. 

Il faut ensuite aller dans le terminal et inscire la commande suivante "bash shell.sh" ou "./shell.sh". Attention il faut ajouter des options ainsi que le fichier que vous souhaitez trier sinon le programme s'arretera assez vite et il y aura un message de rappel sur les options disponibles. Il faut au minimum une option (-t1 , -t2, -t3, -p1, -p2 , -p3, -h, -w). A noté qu'il y aura qu'un seul mode de température et préssion qui sera pris en compte. Si vous inscrivez deux mode sur la température/préssion, alors le mode 1 aura la priorité sur le mode 2 et enfin ce dernier sur le mode 3 (exemple de saisi : "./shell.sh -t1 -t2 meteo.csv" ici , le mode sur la température sera 1). De plus, vous pouvez ajouter une Région ( -F, -G, -A, -O, -Q, -S). Celle-ci permettra de selectionnée uniquement la région choisi. Enfin, il a trois type de tris : abr (--abr) , tableau (--tab) et par défaut avl (il n'y a pas d'obligation à mettre --avl).

Exemple de commande : "bash shell.sh -t1 -w -h -F meteo.csv"

Projet réalisé par Mesbahy Rémi et Mathéo Boyeldieu en MI 5.
