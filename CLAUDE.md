# CLAUDE.md · Waygo

Waygo est une application web de planification de road trips **en voiture** : une carte vivante et un carnet d'itinéraire « Mon itinéraire ».
Concept visuel : *Analog spirit, digital freedom*, un carnet de voyage papier posé sur une carte.

## Organisation du dépôt

```
client/   front-end React + TypeScript + Vite      → voir client/CLAUDE.md
server/   back-end (FastAPI + PostgreSQL, v1.1)    → voir server/CLAUDE.md
```

- Chaque dossier a son propre `CLAUDE.md`, chargé quand tu travailles dedans. Ce fichier-ci ne contient que ce qui vaut pour tout le projet.
- Les commandes `npm` se lancent dans `client/`, les commandes Python dans `server/`. Ne jamais installer une dépendance à la racine.
- Une tâche ne touche qu'un côté sauf si elle concerne le contrat d'API entre les deux. Dans ce cas, modifier le client et le serveur dans le même changement.

## Contexte du projet

- **Projet portfolio et d'apprentissage**, solo (Cynthia).
- **Budget zéro** : uniquement des services gratuits ou open source (free tiers, OpenStreetMap). Signaler toute option payante comme telle.
- **Voiture uniquement.** Marche, vélo et transports en commun sont exclus.
- **Pas de deadline**, développement itératif par versions.
- **Langue** : interface et échanges en français. Code, noms de variables, commentaires et messages de commit en anglais.

## Feuille de route

| Version | Contenu | Côté concerné |
|---|---|---|
| **MVP** | Carte, voyage, étapes, planning, sauvegarde, mobile | `client/` seul, site statique + **localStorage** |
| v1.1 | Comptes et sauvegarde en ligne | `server/` (FastAPI + PostgreSQL, free tier) |
| v1.2 | Suggestions de lieux | Données OpenStreetMap |
| v1.3 | Budget | Carburant via prix-carburants.gouv.fr, péages estimés depuis les tags OSM, dépenses manuelles |
| v2.0 | À définir | |

Tant qu'on est sur le MVP, le client ne doit **dépendre d'aucun serveur**. L'accès aux données reste isolé dans un module du client pour que le passage à l'API en v1.1 soit simple.

## Règles métier (communes client et serveur)

- Le planning (heures d'arrivée, de départ, jours) est **calculé** à partir des durées de trajet et du temps passé sur place.
- Une étape **Hébergement** termine la journée : la route reprend le lendemain à `morningStart`.
- L'heure saisie à la main sur une étape (`fixed_time`) est **optionnelle et informative** (ex. réservation à 12:00). Elle ne verrouille jamais le planning ; au plus, on signale un conflit.
- Les durées de trajet sont des **estimations** (vitesses moyennes par type de route, sans trafic) et sont présentées comme telles.
- Catégories d'étape : `restaurant`, `visite`, `hebergement`, `activite`, `autre`.

## Gestion de projet

- Cahier des charges : page Notion « Waygo - Cahier des charges ».
- Tickets : base Notion « Tickets Waygo », identifiants `WAY-xx` (user story, critères d'acceptation, dépendances). MVP réparti en sprints 0 à 5.
- Citer le ticket dans le commit ou la PR quand il y en a un, au format Conventional Commits avec le côté en scope : `feat(client): add stop markers (WAY-xx)`, `feat(server): add trips endpoint (WAY-xx)`.

## Façon de travailler avec moi

- Je code aussi pour apprendre : explique brièvement les choix techniques non évidents et les alternatives quand il y a un vrai compromis.
- Propose avant de changer l'architecture, d'ajouter une dépendance ou de modifier le design system.
- Préfère des changements petits et ciblés, cohérents avec le code existant.
- Avant de dire qu'une tâche est finie, lance les vérifications du dossier concerné (voir son `CLAUDE.md`).
- Réponses concises, en français, sans tirets cadratins.
