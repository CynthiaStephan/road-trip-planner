# server/ · Back-end Waygo

Règles du projet dans `../CLAUDE.md`. Ce fichier ne couvre que le back.

> Le back-end sert à partir de la **v1.1**. Pendant le MVP, ne pas ajouter de fonctionnalité dont le client dépendrait.

## Rôle

- Comptes utilisateurs et sauvegarde des voyages en ligne (remplace le localStorage du MVP).
- Plus tard : suggestions de lieux OSM (v1.2), données de budget (v1.3, prix des carburants depuis prix-carburants.gouv.fr).
- Le calcul d'itinéraire et du planning reste côté client tant que ce n'est pas décidé autrement.

## Stack

- Python **>= 3.14**, dépendances gérées avec **Poetry** (`pyproject.toml`, `poetry.lock`)
- **FastAPI** + **uvicorn**, point d'entrée `app.main:app`
- **SQLModel** (modèles de tables et schémas Pydantic) sur **PostgreSQL** via `psycopg2-binary` (accès synchrone)
- **Alembic** pour les migrations
- Configuration : **pydantic-settings** + `python-dotenv` (fichier `.env`)
- Authentification : `python-jose` (JWT), `passlib` + `bcrypt` (hachage des mots de passe)
- Tests : `pytest`, `pytest-asyncio`, `pytest-cov`
- Tâches : **poethepoet** (`[tool.poe.tasks]` dans `pyproject.toml`)
- Hébergement et base sur des **free tiers** uniquement (budget zéro)

## Commandes (depuis `server/`)

```bash
poetry install                          # dépendances, groupe dev inclus
poetry run uvicorn app.main:app --reload  # serveur de dev, http://localhost:8000/docs
poetry run poe dev                      # même chose via poe
poetry run poe test                     # pytest
poetry run poe test_cov                 # pytest --cov=app
poetry run poe db_upgrade               # alembic upgrade head
poetry run poe db_revision -m "message" # nouvelle migration autogénérée
poetry run poe db_downgrade             # annule la dernière migration
```

- Ajouter une dépendance : `poetry add <paquet>` (ou `poetry add --group dev <paquet>`), jamais `pip install`, et ne jamais modifier `poetry.lock` à la main.
- **Vérification avant de finir une tâche :** `poetry run poe test` passe.
- Ne lance pas `db_upgrade` ni `db_downgrade` sans me demander : ils modifient ma base locale.

## Conventions

- Typage complet. Les entrées et sorties d'API passent par des modèles SQLModel / Pydantic dédiés (`TripCreate`, `TripRead`…), jamais la table brute avec ses champs internes (ex. `hashed_password`).
- Routes REST en anglais et au pluriel (`/trips`, `/trips/{id}/stops`), JSON en `snake_case`.
- Les noms de champs suivent les types du client (`Trip`, `Stop`, `fixed_time`, `stay_min`…). Tout changement du contrat d'API se fait en même temps dans `client/`.
- Toute modification du schéma passe par une migration Alembic : après `db_revision`, **relire le fichier généré** avant de l'appliquer (l'autogénération rate certains changements, comme les renommages).
- Toute la configuration passe par la classe `Settings` (pydantic-settings), pas de `os.getenv` dispersé.
- Secrets dans `.env` (non versionné), avec un `.env.example` à jour. Ne jamais lire ni afficher le contenu de `.env`.
- Tests : base de test séparée, jamais la base de dev.
