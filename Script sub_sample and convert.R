### Importation des données 

data <- read.csv("Data_initial_23sites.csv", header = T, sep = ",")

# Dossier de sortie où enregistrer les fichiers
dossier_sortie <- "C:/Users/bonni/OneDrive/Université/Thèse/Dicorynia guianensis/Article Strucuture Angélique/Analyses/STRUCTURE (23 sites)/10 inds_sites_alea/Sous_ech_23sites/fichiers_10inds_alea_csv"

# Nombre de répétitions
nombre_repetitions <- 10

# Boucle pour effectuer le script 10 fois
for (i in 1:nombre_repetitions) {
  
  # Initialisation d'une liste pour stocker les échantillons pour chaque valeur unique de "Pop"
  echantillons_par_pop <- list()
  
  # Obtenir les valeurs uniques de la colonne "Pop"
  valeurs_pop <- unique(data$Pop)
  
  # Nombre cible de lignes à échantillonner pour chaque valeur de "Pop"
  taille_echantillon = 10
  
  # Boucle à travers les valeurs uniques de "Pop"
  for (valeur_pop in valeurs_pop) {
    # Sous-ensemble du dataframe pour la valeur de "Pop" en cours
    sous_ensemble <- data[data$Pop == valeur_pop, ]
    
    # Vérifier combien de lignes sont disponibles pour cette valeur de "Pop"
    lignes_disponibles = nrow(sous_ensemble)
    
    # Échantillonner toutes les lignes disponibles
    if (lignes_disponibles <= taille_echantillon) {
      echantillon <- sous_ensemble
    } else {
      echantillon <- sous_ensemble[sample(nrow(sous_ensemble), taille_echantillon), ]
    }
    
    # Ajouter l'échantillon à la liste
    echantillons_par_pop[[as.character(valeur_pop)]] <- echantillon
  }
  
  
  # Chemin du fichier CSV de sortie
  chemin_fichier <- "echantillons_par_pop.csv"
  
  # Créer un dataframe vide pour stocker tous les échantillons
  echantillons_tous <- data.frame()
  
  # Itérer à travers les échantillons par valeur de "Pop"
  for (valeur_pop in valeurs_pop) {
    echantillon <- echantillons_par_pop[[as.character(valeur_pop)]]
    echantillons_tous <- rbind(echantillons_tous, echantillon)
  }
  
  nom_fichier_sortie <- file.path(dossier_sortie, paste0("echantillons_", i, ".csv"))
  
  # Écrire l'ensemble des échantillons dans un fichier CSV
  write.csv(echantillons_tous, nom_fichier_sortie, row.names = FALSE)
}



