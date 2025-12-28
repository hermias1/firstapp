# PsychoTest - App de Tests Psychotechniques iOS

## Description du Projet
Application iOS de tests psychotechniques inspirée des PSY0/PSY1 d'Air France. L'objectif est de proposer des mini-jeux d'entraînement cognitif.

## Stack Technique
- **Langage** : Swift 6.1
- **Framework UI** : SwiftUI
- **Xcode** : 26.2+
- **iOS SDK** : iOS 18
- **Deployment Target** : iOS 18.0
- **Architecture** : MVVM (Model-View-ViewModel)

## Structure du Projet
```
PsychoTest/
├── App/
│   └── PsychoTestApp.swift          # Point d'entrée
├── Views/
│   ├── MainMenuView.swift           # Menu principal
│   ├── Games/
│   │   ├── MentalCalculationView.swift
│   │   ├── MemoryNBackView.swift
│   │   ├── SequenceLogicView.swift
│   │   ├── SpatialView.swift
│   │   ├── AttentionView.swift
│   │   └── ReactionTimeView.swift
│   └── Components/
│       ├── GameCard.swift
│       ├── ScoreView.swift
│       └── TimerView.swift
├── ViewModels/
│   ├── GameViewModel.swift
│   └── [Game]ViewModel.swift
├── Models/
│   ├── Game.swift
│   ├── Score.swift
│   └── User.swift
├── Services/
│   └── ScoreManager.swift
└── Resources/
    └── Assets.xcassets
```

## Guidelines Apple App Store
- [ ] Pas de crash ou bugs majeurs
- [ ] UI responsive et accessible
- [ ] Support Dark Mode
- [ ] Icône d'app conforme (1024x1024)
- [ ] Privacy Policy si données collectées
- [ ] Pas de contenu inapproprié
- [ ] Metadata complète sur App Store Connect

## Tests à Implémenter
1. **Calcul Mental** - Opérations mathématiques chronométrées
2. **Mémoire N-Back** - Mémorisation de séquences
3. **Séquences Logiques** - Suites de nombres/lettres
4. **Visualisation Spatiale** - Rotations de formes
5. **Test d'Attention** - Repérage de symboles
6. **Temps de Réaction** - Réflexes

## Commandes Utiles
```bash
# Ouvrir le projet dans Xcode
open PsychoTest.xcodeproj

# Build depuis terminal (optionnel)
xcodebuild -scheme PsychoTest -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Convention de Code
- Nommage en camelCase pour variables/fonctions
- Nommage en PascalCase pour types/structs/classes
- Commentaires en français ou anglais (consistant)
- Utiliser `@Observable` (Swift 6) pour les ViewModels
- Préférer `struct` à `class` quand possible

---

## Guide Xcode pour Débutants

### 1. Ouvrir le Projet
Double-clique sur `PsychoTest.xcodeproj` ou depuis le terminal :
```bash
open PsychoTest.xcodeproj
```

### 2. Interface Xcode
```
┌─────────────────────────────────────────────────────────────┐
│  [▶ Run] [■ Stop]  │  iPhone 16 Pro ▼  │  PsychoTest       │
├──────────┬──────────────────────────────┬───────────────────┤
│ Navigator│         Editor               │    Inspector      │
│ (fichiers)          (code)              │  (propriétés)     │
│          │                              │                   │
│ 📁 Psycho│  import SwiftUI              │                   │
│  ├─ App  │                              │                   │
│  ├─ Views│  struct MainMenuView...      │                   │
│  └─ ...  │                              │                   │
├──────────┴──────────────────────────────┴───────────────────┤
│                     Debug Area (console)                     │
└─────────────────────────────────────────────────────────────┘
```

### 3. Lancer l'App sur Simulateur
1. En haut, sélectionne un simulateur (ex: "iPhone 16 Pro")
2. Clique sur le bouton **▶ (Play)** ou `Cmd + R`
3. Le simulateur démarre et l'app se lance

### 4. Lancer sur Ton iPhone (Physique)
1. Branche ton iPhone avec un câble USB
2. Va dans **Xcode > Settings > Accounts**
3. Ajoute ton Apple ID (compte gratuit OK)
4. Dans le projet, onglet **Signing & Capabilities** :
   - Active "Automatically manage signing"
   - Sélectionne ton "Team" (ton Apple ID)
5. Sur ton iPhone : **Réglages > Général > Gestion appareil** → Fais confiance à ton certificat
6. Sélectionne ton iPhone en haut et clique **▶**

### 5. Raccourcis Utiles
| Action | Raccourci |
|--------|-----------|
| Run | `Cmd + R` |
| Stop | `Cmd + .` |
| Build | `Cmd + B` |
| Clean Build | `Cmd + Shift + K` |
| Ouvrir fichier rapide | `Cmd + Shift + O` |
| Afficher/Masquer Navigator | `Cmd + 0` |
| Prévisualisation SwiftUI | `Cmd + Option + P` |

### 6. Résolution de Problèmes Courants

**"No such module 'SwiftUI'"**
→ Vérifie que le Deployment Target est iOS 18.0

**"Signing requires a development team"**
→ Ajoute ton Apple ID dans Xcode > Settings > Accounts

**L'app ne se lance pas sur iPhone**
→ Vérifie que tu fais confiance au certificat sur l'iPhone

**Build failed**
→ `Cmd + Shift + K` pour nettoyer, puis `Cmd + R`
