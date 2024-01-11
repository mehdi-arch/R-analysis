if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}
if (!requireNamespace("tidytuesdayR", quietly = TRUE)) {
  install.packages("tidytuesdayR")
}

# Charger les bibliothèques nécessaires
library(tidyverse)
library(tidytuesdayR)
theme_set(theme_minimal())

# Charger les données TidyTuesday pour la semaine 41 de 2022
donnees_mardi <- tidytuesdayR::tt_load(2022, week = 41)
laine <- donnees_mardi$yarn

# Afficher les données dans une vue
View(laine)

# Analyser la répartition des valeurs manquantes (NA)
moyenne_na_laine <- mean(is.na(laine$max_gauge))
cat("Proportion de valeurs manquantes dans max_gauge :", moyenne_na_laine, "\n")

# Calculer la proportion de valeurs manquantes pour chaque colonne
laine_na_counts <- laine %>%
  summarize(across(everything(), \(x) mean(is.na(x))))
View(laine_na_counts)

# Idée principale : peut-on imputer les valeurs manquantes de min_gauge en utilisant grams et yardage ?

# Analyser les valeurs de yardage, détecter les valeurs aberrantes (zéro)
summary(laine$yardage)
anomalies <- filter(laine, yardage == 0)
View(anomalies)

# Remplacer la valeur de yardage pour Kmart Sayelle par 240
laine[laine$permalink == "kmart-sayelle", "yardage"] <- 240

# Filtrer les valeurs de grams et yardage non nulles
laine_rouge <- laine %>%
  filter(grams > 0, yardage > 0) %>%
  mutate(densite = grams / yardage, etalon_gauge = min_gauge / gauge_divisor)
View(laine_rouge)

# Analyser la relation entre densite et etalon_gauge dans ce sous-ensemble de données
ggplot(laine_red, aes(x = log10(densite), y = log10(etalon_gauge))) + 
  geom_point(alpha = .1)

# Supprimer les zéros de la colonne etalon_gauge
laine_red <- laine_red %>%
  filter(etalon_gauge > 0)

# Analyser à nouveau la relation entre densite et etalon_gauge avec une régression linéaire
ggplot(laine_red, aes(x = log10(densite), y = log10(etalon_gauge))) + 
  geom_point(alpha = .1) +
  geom_smooth(method = "lm")

# Effectuer la modélisation avec une régression linéaire
modele <- lm(log10(etalon_gauge) ~ log10(densite), data = laine_red)
summary(modele)

# Utiliser le modèle pour imputer les valeurs manquantes de etalon_gauge
laine_nouvelle <- laine %>%
  mutate(etalon_gauge_impute = 10 ^ (.495 - .514 * log10(grams / yardage)))

# Visualiser la relation entre min_gauge/gauge_divisor et etalon_gauge_impute
ggplot(laine_nouvelle, aes(x = log10(min_gauge / gauge_divisor), y = log10(etalon_gauge_impute))) + 
  geom_point(alpha = .1)

