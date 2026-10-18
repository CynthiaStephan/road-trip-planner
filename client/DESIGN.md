# Waygo · Design system v3

> **À lire avant de créer ou modifier un écran Waygo.**
> Concept : *Analog spirit, digital freedom*. Un carnet de voyage papier, posé sur une carte vivante.
> Sources de vérité, dans cet ordre : `src/styles/tokens.css` (valeurs), `tailwind.config.js` (classes), puis ce document. Si ce document et le code divergent, **le code gagne** et ce fichier doit être corrigé.
> Figma : planche « Design system » du fichier `wrSybu63QouytO4XSqqcK5` (variables `color/*`, styles d'effet `Élévation/*`). Un token qui change se change dans Figma **et** dans le code.

---

## 1. Principes

1. **Clair et lumineux.** Fonds papier très légers pour laisser les accents s'exprimer. Pas de fond foncé, sauf bandeaux temporaires (ex. mode « ajout de point »).
2. **L'élévation par l'ombre, pas par le trait.** Aucune bordure noire, aucun halo coloré, aucun contour décoratif. La hiérarchie vient des surfaces (Lin → Surface → Relief) et des ombres e1 à e4.
3. **La carte domine.** Desktop : carte ≈ 62 %, carnet « Mon itinéraire » ≈ 38 % à droite. Mobile (< 768 px) : carte plein écran, carnet en bottom sheet.
4. **Liste et carte synchronisées.** Sélectionner une étape dans la liste la sélectionne sur la carte, et inversement.
5. **Accessible par défaut.** Contraste AA minimum, cibles 40 px (44 px mobile), focus clavier toujours visible.

---

## 2. Couleurs

Toujours passer par une classe Tailwind ou une variable CSS. **Jamais d'hex en dur dans un composant.**

### Surfaces (du plus bas au plus haut)

| Nom | Hex | Variable CSS | Tailwind | Usage |
|---|---|---|---|---|
| Lin | `#F8F6EF` | `--color-paper-secondary`, `--bg-app` | `bg-lin` | Fond de l'application |
| Surface | `#FAF8F5` | `--color-surface`, `--bg-panel` | `bg-surface` | Carnet (panneau droit), bottom sheet |
| Relief | `#FFFFFF` | `--color-raised`, `--bg-raised` | `bg-raised` | Ce qui flotte : cartes, menus, boutons secondaires, contrôles carte |
| Papier | `#F4EBDD` | `--color-paper` | `bg-paper` | Zones mises en avant : chiffres clés, bouton tonal |
| Séparateur | `#ECE4D6` | `--color-border`, `--line` | `bg-divider` | **Uniquement** les filets entre éléments d'une liste |
| Bord de champ | `#E0D6C4` | `--line-strong` | `border-line-strong` | Champs de formulaire |


### Texte

| Nom | Hex | Variable | Tailwind | Usage |
|---|---|---|---|---|
| Encre | `#29362F` | `--text` | `text-ink` | Texte principal |
| Texte secondaire | `#5E6759` | `--text-muted` | `text-muted` | Petit texte lisible (5,6:1) |
| Terrain | `#778071` | `--text-faint` | `text-faint` | Désactivé ou décoratif **seulement** |

### Accents « riso »

| Nom | Hex | Tailwind | Rôle | Texte posé dessus |
|---|---|---|---|---|
| Orange | `#FF5938` (survol `#F04A29`, pressé `#DB3D1E`) | `bg-orange`, `bg-orange-hover`, `bg-orange-press` | Action principale, départ | `text-on-accent` `#1F150F` (7,4:1). **Jamais de blanc sur orange.** |
| Electric Blue | `#3454FF` (survol `#2442E6`) | `bg-blue`, `text-blue`, `bg-blue-hover` | Itinéraire, liens, focus, action secondaire forte | Blanc (6,0:1) |
| Lime | `#D5F542` | `bg-lime` | Sélection (badge, étape active, marqueur) | Encre |
| Rose | `#EE75B8` | `bg-pink` | Activités | Encre |
| Danger | `#C7361B` | `bg-danger`, `text-danger` | Suppression | Blanc |

### Catégories d'étape (puce = fond 50 + texte 700)

| Catégorie (`Category`) | Fond | Texte | Icône Lucide | `<Badge tone>` |
|---|---|---|---|---|
| `restaurant` | `#FFE9E2` | `#B33A1E` | `Utensils` | `orange` |
| `hebergement` | `#E6EAFF` | `#2238C2` | `BedDouble` | `blue` |
| `activite` | `#FBE3F0` | `#9C2F6B` | `Sunset` | `pink` |
| `visite` | `#F4FBD3` | `#4E5B0C` | `Landmark` | `ink` |
| `autre` | `#F4FBD3` | `#4E5B0C` | `MapPin` | `ink` |

Le tone `ink` du Badge correspond au fond lime-50 et texte lime-800. Le tone `lime` (fond Lime plein) est réservé à la **sélection**.

---

## 3. Élévation (ombres teintées encre, jamais colorées)

| Niveau | Tailwind | Pour |
|---|---|---|
| e1 | `shadow-e1` | Boutons au repos, cartes d'étape |
| e2 | `shadow-e2` | Survol, contrôles flottants sur la carte |
| e3 | `shadow-e3` | Menus déroulants, popovers, étape sélectionnée |
| e4 | `shadow-e4` | Bottom sheet mobile, modales |

Valeurs exactes dans `tokens.css` (`--e1` à `--e4`).

**Règle d'état :** repos = niveau N · survol = N+1 · pressé = à plat (`shadow-none` + `translate-y-px`).
Sur la carte, les éléments flottants peuvent utiliser le fond verre `--bg-glass` (blanc 90 %).

**Seules lignes autorisées :**
- l'anneau de focus clavier bleu 2 px (`outline-focus`, offset 3 px) ;
- le contour Encre du marqueur **sélectionné** sur la carte ;
- les champs de formulaire (`border-line-strong`, bleu au focus) ;
- les filets Séparateur entre éléments d'une même liste.

---

## 4. Typographie

| Rôle | Police | Taille | Classe |
|---|---|---|---|
| Titre écran | Space Grotesk 600-700 | `clamp(32px, 2.6vw, 40px)` (`--fs-title`) | `font-display` |
| Titre panneau | Space Grotesk | 22 px, 20 px mobile (`--fs-panel`) | `font-display` |
| Nom de lieu | DM Sans 600 | 16 px | `font-body` |
| Corps, boutons | DM Sans | 14 px | `font-body` |
| Données (km, durées, heures) | IBM Plex Mono | 13 px, chiffres tabulaires | `font-mono tabular-nums` |
| Légendes, puces | IBM Plex Mono | 11 à 11,5 px, `tracking-[0.03em]` | `font-mono` |

Polices chargées depuis Google Fonts : `Space Grotesk`, `DM Sans`, `IBM Plex Mono`. Garder les piles de repli de `tokens.css`. Pas d'autre police.

---

## 5. Forme et espacement

- **Rayons :** 6 (`rounded-sm`), 12 (`rounded-md`), 20 (`rounded-lg`), pilule (`rounded-pill`).
  Boutons = pilule · bouton tonal et cartes = 12 · panneaux = 20 · champs = 10 (exception volontaire, dans `fieldClass`).
- **Espacements :** 4 / 8 / 12 / 16 / 24 / 32 px (`--space-1` à `--space-8`, soit `1`, `2`, `3`, `4`, `6`, `8` en Tailwind). Pas de valeur hors échelle.
- **Cibles :** `--hit` = 40 px desktop, 44 px mobile (`min-h-hit`, `w-hit`).
- **Barre du haut :** 56 px desktop, 52 px mobile (`--topbar-h`).
- **Point de rupture mobile :** `max-width: 767px`.

---

## 6. Composants

Stack : React 18 + TypeScript, Tailwind 3 avec **Preflight désactivé** (sinon Leaflet casse ; le reset de base est dans `app.css`), shadcn/ui sur Radix, `lucide-react`. Alias `@/` → `src/`. Fusion de classes avec `cn()` de `@/lib/utils`.

**Réutiliser `@/components/ui/*` avant de créer un composant.** Un nouveau composant shadcn s'ajoute dans `src/components/ui/` puis s'adapte aux tokens ci-dessus (retirer bordures et anneaux par défaut).

### Bouton · `@/components/ui/button`

| `variant` | Aspect | Quand |
|---|---|---|
| `primary` | Orange, texte `on-accent`, e1 | **Une seule** action principale par zone (« Ajouter un point ») |
| `blue` | Bleu, texte blanc, e1 | Action forte secondaire |
| `secondary` (défaut) | Relief blanc, e1 | Actions courantes (« Modifier ») |
| `tonal` | Papier, rayon 12, sans ombre au repos | « Ajouter une étape » dans le carnet |
| `ghost` | Transparent, Papier au survol | Barres d'outils, monter / descendre |
| `danger` / `danger-ghost` | Rouge plein / texte rouge | Suppression |

Tailles : `default` (hauteur `--hit`), `sm` (34 px), `icon`, `icon-sm`. Pilule, `border-0`, pas de halo. Un bouton icône seul **doit** avoir un `aria-label`.

### Autres composants
- **Badge** (`tone` : `orange`, `blue`, `pink`, `ink`, `lime`) pour catégories et sélection. Puce de catégorie prête à l'emploi : `<CategoryChip category=… />`.
- **Input, Textarea, NativeSelect, Label** : partagent `fieldClass` (rayon 10, bord `line-strong`, bleu au focus). Les listes restent des `<select>` natifs (sélecteur système sur mobile).
- **DropdownMenu** (Radix) : `bg-raised shadow-e3 rounded-md`, `z-[2000]` pour passer au-dessus de la carte, item `tone="danger"` pour supprimer.
- **Contrôles de carte** (zoom, recentrer) : boutons Relief ronds, e2.

### Icônes
- **Lucide uniquement**, via `<Icon name="…" />` de `@/components/Icons` (jamais d'import SVG à la main). Un nouveau pictogramme s'ajoute dans l'objet `ICONS`.
- Interface : 18 px, `strokeWidth={1.75}`. Puces : 13 px. Marqueurs de carte : 14 px, trait 2, via `iconSvg()` (HTML pour Leaflet).
- Sans `label`, l'icône est décorative (`aria-hidden`). Avec `label`, elle est annoncée.
- Correspondances : restaurant `Utensils`, visite `Landmark`, hébergement `BedDouble`, activité `Sunset`, autre `MapPin`, départ `Play`, arrivée `Flag`, ajout de point `MapPinPlus`, modifier `Pencil`, supprimer `Trash2`, menu `EllipsisVertical`, recentrer `LocateFixed`, trajet `Route`, navigation `Navigation`, note `NotebookPen`, poignée `GripVertical`.

---

## 7. Carte

- Leaflet + React-Leaflet. Fond « Atlas » par défaut (vectoriel, sans serveur) ou tuiles OSM avec `VITE_BASEMAP=osm`.
- Couleurs de carte dans `tokens.css` (`--map-*`) : mer `#DDEAEE`, terre `#FAF5EC`, forêts `#E4EBD5`, zones urbaines `#F2E9DA`, eau `#CFE1E6`, rivières `#A5C7CF`, autoroutes `#FFD6A3`, routes principales blanches, bordures de route `#D3CAB8`.
- **Itinéraire :** trait Electric Blue `--map-route` avec liseré Surface.
- **Marqueurs :** pastille de la couleur de catégorie + icône Lucide ; départ orange (`Play`), arrivée (`Flag`). Le marqueur sélectionné grossit (36 px), passe en Lime (départ et arrivée restent orange) et prend un contour Encre doublé d'un anneau Surface.
- Attribution « © contributeurs OpenStreetMap » toujours visible.
- Pas de `tile.openstreetmap.org` en production (politique d'usage OSM).

---

## 8. Accessibilité (non négociable)

- Contraste texte ≥ 4,5:1 (≥ 3:1 pour icônes et grands textes). Vérifier tout nouveau couple de couleurs.
- Focus clavier : anneau bleu 2 px visible sur tout élément interactif. Jamais `outline: none` sans remplaçant.
- Cibles ≥ 40 px (44 px mobile).
- La sélection ne repose jamais sur la couleur seule : badge + contour foncé + `aria-pressed` sur l'étape.
- Liste du carnet et marqueurs utilisables au clavier ; marqueurs avec libellé accessible (nom + catégorie).
- Respecter `prefers-reduced-motion` pour les animations de carte et de sheet.

---

## 9. À faire / à éviter

**À faire**
- Tokens et classes Tailwind ci-dessus, rien d'autre.
- Une seule action orange par zone.
- Monter d'un niveau d'ombre au survol, revenir à plat à l'appui.
- Proposer la modification avant de toucher à un token, puis mettre à jour `tokens.css`, `tailwind.config.js`, ce fichier et Figma ensemble.

**À éviter**
- Bordures noires ou foncées, halos colorés, ombres colorées.
- Fonds plus foncés que Lin.
- Texte blanc sur orange ; texte Terrain `#778071` pour du contenu lisible.
- Nouvelles polices, nouveaux rayons, icônes hors Lucide.

**Dette connue** (à corriger quand on y touche) : `button.tsx` contient deux hex en dur pour les survols (`tonal` `#F0E5D4`, `danger` `#A92C14`). Les passer en tokens (`--paper-hover`, `--danger-hover`) plutôt que d'en ajouter d'autres.
