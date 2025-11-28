# PL-prediction-db

## Contenu du projet

Ce dépôt contient les fichiers nécessaires pour la prédiction des résultats de la Premier League à l’aide de plusieurs modèles : réseau de neurones à propagation avant (FNN), classificateurs bayésiens, et réseau de neurones de graphes (GCN).

## Organisation des fichiers

- Le dossier `PL_classifier` contient :
  - le notebook principal du modèle FNN,
  - un sous-dossier `bayes_classifier` regroupant les classificateurs bayésiens,
  - un sous-dossier `GCN` pour le modèle de type GCN.
  - le rapport final `rapport final` expliquant les démarches utilisé en détails

## Dépendances

- Le fichier `requirements.txt` situé dans `PL_classifier` contient toutes les dépendances nécessaires pour exécuter les trois modèles (FNN, bayesiens, GCN).
- Il n’est donc pas nécessaire d’installer un fichier de dépendances spécifique pour chaque modèle.

## Détails par dossier

- `PL_classifier/bayes_classifier/` : contient le notebook détaillé de tous les classificateurs bayésiens ainsi que les données utilisées.
- `PL_classifier/GCN/` : contient le notebook détaillé du modèle GCN ainsi que les données utilisées.
