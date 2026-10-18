# client/ · Front-end Waygo

Règles du projet dans `../CLAUDE.md`. Ce fichier ne couvre que le front.

## Stack

- React 18 + TypeScript (strict) + Vite 5
- Tailwind CSS 3 (**Preflight désactivé** pour ne pas casser Leaflet) + shadcn/ui (Radix)
- Icônes `lucide-react` uniquement
- Carte : Leaflet + React-Leaflet sur OpenStreetMap
- Alias `@/` → `src/`, utilitaire `cn()` dans `@/lib/utils`

## Commandes (depuis `client/`)

```bash
npm install
npm run dev            # http://localhost:5173
npm run build          # tsc + build Vite, sert aussi de vérification de types
npm run build:single   # un seul fichier dist/index.html (aperçu partageable)
npm run preview
VITE_BASEMAP=osm npm run dev   # tuiles OSM au lieu du fond « Atlas »
```

**Vérification avant de finir une tâche :** `npm run build` passe sans erreur.

## Structure

```
src/
  styles/tokens.css     tokens du design system (source de vérité)
  styles/app.css        composants et responsive (bottom sheet sous 768 px)
  components/ui/        composants shadcn/ui (button, badge, dropdown-menu, input…)
  components/           TopBar, MapView, AtlasBasemap, PlanPanel, StopItem, PlaceCard, Legend, Icons
  data/trip.ts          types (Trip, Stop, Category) et voyage d'exemple
  data/*.json           fond de carte et réseau routier GÉNÉRÉS, ne pas éditer ni lire en entier (plusieurs Mo)
  lib/routing.ts        itinéraire côté navigateur (Dijkstra sur le graphe OSM)
  lib/schedule.ts       calcul des horaires et des jours
```

## Comportements à préserver

- Liste et carte **synchronisées** : sélectionner une étape d'un côté la sélectionne de l'autre.
- Ajouter une étape l'insère à la position qui allonge le moins le trajet.
- MVP : sauvegarde en **localStorage** uniquement, via un seul module d'accès aux données.

## Design system

Référence complète : `DESIGN.md` (design system v3). Si `DESIGN.md` et `src/styles/tokens.css` divergent, **le code gagne** et `DESIGN.md` doit être corrigé.

**Couleurs**
- Garder `#F4EBDD` (Papier).
- Interface claire : fonds Lin `#F8F6EF` → Surface `#FAF8F5` → Relief `#FFFFFF`, pour laisser les accents ressortir.
- Accents : Orange `#FF5938` (action principale, **jamais de texte blanc dessus**, texte `#1F150F`), Electric Blue `#3454FF` (itinéraire, liens, focus), Lime `#D5F542` (sélection), Rose `#EE75B8`.
- Jamais d'hex en dur dans un composant : tokens CSS ou classes Tailwind (`bg-lin`, `bg-surface`, `bg-raised`, `text-ink`, `text-muted`…).

**Formes et élévation**
- Pas de bordures noires ou foncées, pas de halo, pas d'ombre colorée.
- Boutons arrondis (pilule), **sans bordure ni halo**, élévation par ombres `shadow-e1` à `shadow-e4`.
- État : repos = niveau N, survol = N+1, pressé = à plat (`shadow-none translate-y-px`).
- Rayons 6 / 12 / 20 / pilule, espacements 4 / 8 / 12 / 16 / 24 / 32 px uniquement.
- Une seule action orange par zone.

**Composants**
- Réutiliser `@/components/ui/*` avant d'en créer un. Bouton : `primary`, `blue`, `secondary`, `tonal`, `ghost`, `danger`, `danger-ghost`.
- Icônes via `<Icon name="…" />` de `@/components/Icons`, `strokeWidth={1.75}`.
- Polices : Space Grotesk (titres), DM Sans (texte), IBM Plex Mono (km, durées, heures).

**Accessibilité (non négociable)**
- Contraste ≥ 4,5:1, focus clavier bleu toujours visible, cibles ≥ 40 px (44 px mobile).
- Bouton icône seul = `aria-label` obligatoire. La sélection ne repose jamais sur la couleur seule.
- Respecter `prefers-reduced-motion`.

## Carte

- Toujours afficher l'attribution « © contributeurs OpenStreetMap ».
- Pas de `tile.openstreetmap.org` en production (politique d'usage OSM) : passer par un fournisseur de tuiles gratuit dédié.
- Itinéraire en Electric Blue avec liseré Surface ; marqueur sélectionné agrandi, lime, contour Encre.
