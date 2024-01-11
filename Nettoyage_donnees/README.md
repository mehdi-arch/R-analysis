# Analyse de donnees - Laine
Le script R utilise les librairies <strong>tidyverse</strong> et <strong>tidytuesdayR</strong>, si elles ne sont pas installés sur votre machine, une fonction vous l'installera au début du script.
## Objectif de l'analyse
L'objectif etait d'explorer les donnees de ce TidyTuesday comportant sur un stock de fils de laine avec toutes leur caracteritiques (grammage, ect).
Le probleme etait qu'il y avait des valeurs manquantes dans ce jeu de donnees, le but etait de traiter ce jeu de donner afin d'avoir des donnees homogenes,
pour pouvoir plus tard appliquer des algorithmes d'apprentissage (IA).
Les donnees ici sont issues du TidyTuesday de la semaine 41 de 2022.
## Exploration des donnees
Premierement, on examine la repartition des valeurs manquantes dans la variable <strong>max_gauge</strong> et etablir un resume du taux de valeurs maquantes dans les autres colonnes.
## Traitement des valeurs abberantes
On traite avec grande attention les valeurs abberantes qui peuvent fausser toute conclusion/algorithme. Plus particulierement, les valeurs de <strong>yardage</strong>.
Leurs valeurs aberrantes (zeros) sont identifies et corrigées.
## Filtrage des donnees
Les donnees sont filtrees pour exclure les valeurs nulles de <strong>grams</strong> et <strong>yardage</strong>. Une nouvelle variable <strong>dens</strong> est cree en calculant le ratio <strong>grams / yardage</strong>, une autre variable <strong>gauge\_std</strong> est calcule par le ratio <strong>min_gauge / gauge_divisor</strong>.
## Analyse de la relation entre dens et gauge_std
Une visualisation à été realisée pour explorer la relation entre les deux variables.
Un nuage de points ainsi qu'une regression lineaire ont été representées pour évaluer la tendance.
![Représentation graphique des donneées](imgs/corr_dens_etalon_gauge_nettoye.png)
## Imputation des valeurs manquantes avec un modele lineaire
Un modèle linéaire est ajusté pour imputer les valeurs manquantes de <strong>gauge\_std</strong> en fonction de dens. Les résultats du modèle sont examinés, et une nouvelle variable <strong>gauge\_std\_imputed</strong> est créée en utilisant le modèle.
## Visualisation des donnees
La dernière partie du script consiste en une visualisation comparant les valeurs imputées de <strong>gauge\_std</strong> avec les valeurs réelles en utilisant un graphique en nuage de points.
![Repreésentation graphique des résultats finaux](imgs/comparaison_data.png)
## Conclusion
Ce script fournit une approche méthodique pour explorer, nettoyer et analyser les données sur la laine. Il met particulièrement l'accent sur l'imputation des valeurs manquantes et offre une visualisation claire des relations entre les différentes variables. 
