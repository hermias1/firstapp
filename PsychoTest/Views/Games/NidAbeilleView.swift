import SwiftUI

// MARK: - Modèle

/// Un thème et les six mots qui le composent.
struct AlveoleTheme: Equatable {
    let nom: String
    let mots: [String]
}

/// Une ruche à compléter.
///
/// ATTENTION — Adaptation assumée. L'épreuve « nid d'abeille » existe bien au
/// PSY0 depuis 2022, mais ses règles exactes ne sont documentées nulle part :
/// ni les préparateurs ni les forums de candidats ne les décrivent. On sait
/// seulement qu'on y place des mots dans des hexagones, que l'exercice est noté
/// sur 5, et que la difficulté vient des moments où plusieurs mots semblent
/// convenir. Cet exercice reprend ces principes sans prétendre reproduire le
/// test officiel.
struct NidPuzzle {
    let theme: AlveoleTheme
    /// Les neuf mots proposés : les six du thème et trois intrus crédibles.
    let proposes: [String]
    var solution: [String] { theme.mots }
}

enum NidGenerator {
    static let themes: [AlveoleTheme] = [
        AlveoleTheme(nom: "Outils de bricolage", mots: ["Marteau", "Tournevis", "Tenaille", "Scie", "Perceuse", "Rabot"]),
        AlveoleTheme(nom: "Instruments de mesure", mots: ["Thermomètre", "Baromètre", "Chronomètre", "Balance", "Manomètre", "Hygromètre"]),
        AlveoleTheme(nom: "Fournitures scolaires", mots: ["Cartable", "Gomme", "Cahier", "Trousse", "Crayon", "Taille-crayon"]),
        AlveoleTheme(nom: "Boissons chaudes", mots: ["Café", "Thé", "Tisane", "Infusion", "Cappuccino", "Grog"]),
        AlveoleTheme(nom: "Produits laitiers", mots: ["Lait", "Beurre", "Yaourt", "Crème", "Fromage", "Mascarpone"]),
        AlveoleTheme(nom: "Pièces d'une voiture", mots: ["Volant", "Pare-brise", "Moteur", "Pneu", "Rétroviseur", "Embrayage"]),
        AlveoleTheme(nom: "Métaux", mots: ["Fer", "Cuivre", "Zinc", "Plomb", "Étain", "Nickel"]),
        AlveoleTheme(nom: "Ustensiles de pâtisserie", mots: ["Fouet", "Moule", "Rouleau", "Spatule", "Tamis", "Douille"]),
        AlveoleTheme(nom: "Parties d'un livre", mots: ["Couverture", "Préface", "Chapitre", "Sommaire", "Index", "Reliure"]),
        AlveoleTheme(nom: "Pièces d'un navire", mots: ["Voile", "Ancre", "Quille", "Hublot", "Mât", "Gouvernail"]),
        AlveoleTheme(nom: "Nuances de couleur", mots: ["Ocre", "Turquoise", "Pourpre", "Indigo", "Émeraude", "Écarlate"]),
        AlveoleTheme(nom: "Monnaies du monde", mots: ["Euro", "Dollar", "Yen", "Roupie", "Peso", "Dirham"]),
        AlveoleTheme(nom: "Roches et minéraux", mots: ["Granit", "Basalte", "Calcaire", "Ardoise", "Marbre", "Gypse"]),
        AlveoleTheme(nom: "Parties du visage", mots: ["Front", "Joue", "Menton", "Sourcil", "Narine", "Paupière"]),
        AlveoleTheme(nom: "Parties d'un avion", mots: ["Fuselage", "Aileron", "Cockpit", "Hélice", "Empennage", "Réacteur"]),
        AlveoleTheme(nom: "Objets du courrier", mots: ["Timbre", "Enveloppe", "Colis", "Lettre", "Carte postale", "Cachet"]),
        AlveoleTheme(nom: "Récipients", mots: ["Bol", "Verre", "Carafe", "Seau", "Bocal", "Tonneau"]),
        AlveoleTheme(nom: "Unités de temps", mots: ["Seconde", "Minute", "Heure", "Semaine", "Mois", "Siècle"]),
        AlveoleTheme(nom: "Le cirque", mots: ["Chapiteau", "Clown", "Jongleur", "Acrobate", "Dompteur", "Funambule"]),
        AlveoleTheme(nom: "Le tribunal", mots: ["Juge", "Avocat", "Procès", "Verdict", "Greffier", "Plaidoirie"]),
        AlveoleTheme(nom: "La ferme", mots: ["Étable", "Grange", "Tracteur", "Silo", "Clôture", "Moisson"]),
        AlveoleTheme(nom: "Le jeu d'échecs", mots: ["Roi", "Reine", "Tour", "Fou", "Cavalier", "Pion"]),
        AlveoleTheme(nom: "Le désert", mots: ["Dune", "Oasis", "Mirage", "Caravane", "Dromadaire", "Palmeraie"]),
        AlveoleTheme(nom: "Matériaux de construction", mots: ["Béton", "Brique", "Ciment", "Plâtre", "Tuile", "Mortier"]),
        AlveoleTheme(nom: "Le sommeil", mots: ["Oreiller", "Rêve", "Sieste", "Ronflement", "Insomnie", "Cauchemar"]),
        AlveoleTheme(nom: "Le feu", mots: ["Flamme", "Braise", "Fumée", "Cendre", "Étincelle", "Brasier"]),
        AlveoleTheme(nom: "Au bord de la mer", mots: ["Plage", "Galet", "Marée", "Vague", "Coquillage", "Falaise"]),
        AlveoleTheme(nom: "Les repas", mots: ["Petit-déjeuner", "Déjeuner", "Dîner", "Goûter", "Souper", "Collation"]),
        AlveoleTheme(nom: "Mesures de longueur", mots: ["Millimètre", "Centimètre", "Mètre", "Kilomètre", "Mille", "Lieue"]),
        AlveoleTheme(nom: "Documents administratifs", mots: ["Passeport", "Visa", "Formulaire", "Attestation", "Certificat", "Procuration"]),
        AlveoleTheme(nom: "La forêt", mots: ["Clairière", "Sous-bois", "Sentier", "Fougère", "Broussaille", "Écorce"]),
        AlveoleTheme(nom: "Les bruits", mots: ["Murmure", "Cri", "Grondement", "Chuchotement", "Vacarme", "Sifflement"]),
        AlveoleTheme(nom: "La pharmacie", mots: ["Comprimé", "Sirop", "Pommade", "Ordonnance", "Pansement", "Gélule"]),
        AlveoleTheme(nom: "Le chemin de fer", mots: ["Quai", "Rail", "Wagon", "Locomotive", "Aiguillage", "Traverse"]),
        AlveoleTheme(nom: "Les formes de relief", mots: ["Colline", "Vallée", "Plateau", "Plaine", "Gorge", "Ravin"]),
        AlveoleTheme(nom: "Le journal", mots: ["Article", "Éditorial", "Rubrique", "Manchette", "Abonnement", "Kiosque"]),
        AlveoleTheme(nom: "L'hôtel", mots: ["Réception", "Concierge", "Ascenseur", "Suite", "Pourboire", "Réservation"]),
        AlveoleTheme(nom: "La photographie", mots: ["Objectif", "Obturateur", "Pellicule", "Négatif", "Trépied", "Zoom"]),
        AlveoleTheme(nom: "L'hôpital", mots: ["Brancard", "Urgences", "Perfusion", "Ambulance", "Bloc opératoire", "Radiographie"]),
        AlveoleTheme(nom: "Les jeux de société", mots: ["Dé", "Plateau", "Jeton", "Dominos", "Cartes", "Sablier"]),
        AlveoleTheme(nom: "Les condiments", mots: ["Moutarde", "Ketchup", "Mayonnaise", "Vinaigre", "Cornichon", "Sel"]),
        AlveoleTheme(nom: "Portes et fenêtres", mots: ["Imposte", "Persienne", "Lucarne", "Volet", "Portail", "Vasistas"]),
        AlveoleTheme(nom: "Le vin", mots: ["Cépage", "Vendange", "Millésime", "Bouchon", "Cave", "Sommelier"]),
        AlveoleTheme(nom: "L'aéroport", mots: ["Piste", "Terminal", "Embarquement", "Escale", "Douane", "Tarmac"]),
        AlveoleTheme(nom: "La boulangerie", mots: ["Baguette", "Croissant", "Brioche", "Miche", "Chausson", "Pain"]),
        AlveoleTheme(nom: "Les jouets d'enfant", mots: ["Poupée", "Toupie", "Billes", "Cerf-volant", "Peluche", "Cube"]),
        AlveoleTheme(nom: "Les mots de la route", mots: ["Carrefour", "Rond-point", "Trottoir", "Feu", "Panneau", "Péage"]),
        AlveoleTheme(nom: "Chez le coiffeur", mots: ["Ciseaux", "Peigne", "Brosse", "Shampoing", "Mèche", "Séchoir"]),
        AlveoleTheme(nom: "Unités de masse", mots: ["Gramme", "Kilogramme", "Tonne", "Quintal", "Carat", "Once"]),
        AlveoleTheme(nom: "L'équitation", mots: ["Selle", "Étrier", "Bride", "Galop", "Écurie", "Mors"]),
        AlveoleTheme(nom: "Les confiseries", mots: ["Bonbon", "Caramel", "Nougat", "Réglisse", "Praline", "Sucette"]),
        AlveoleTheme(nom: "L'électricité", mots: ["Prise", "Interrupteur", "Ampoule", "Câble", "Disjoncteur", "Pile"]),
        AlveoleTheme(nom: "Le camping", mots: ["Tente", "Sac de couchage", "Réchaud", "Lampe torche", "Piquet", "Gourde"]),
        AlveoleTheme(nom: "Les mots du calcul", mots: ["Addition", "Soustraction", "Produit", "Quotient", "Reste", "Moyenne"]),
        AlveoleTheme(nom: "Les parties d'un vélo", mots: ["Guidon", "Pédale", "Chaîne", "Sonnette", "Garde-boue", "Jante"]),
        AlveoleTheme(nom: "Les récompenses", mots: ["Médaille", "Trophée", "Diplôme", "Coupe", "Prix", "Distinction"]),
        AlveoleTheme(nom: "Les mots de la ville", mots: ["Avenue", "Boulevard", "Place", "Quartier", "Ruelle", "Esplanade"]),
        AlveoleTheme(nom: "Les sauces", mots: ["Béchamel", "Vinaigrette", "Aïoli", "Coulis", "Hollandaise", "Béarnaise"]),
        AlveoleTheme(nom: "Instruments d'optique", mots: ["Loupe", "Microscope", "Télescope", "Longue-vue", "Lunettes", "Périscope"]),
        AlveoleTheme(nom: "Liens de parenté", mots: ["Cousin", "Neveu", "Belle-mère", "Grand-père", "Marraine", "Beau-frère"]),
        AlveoleTheme(nom: "La magie", mots: ["Sortilège", "Potion", "Grimoire", "Philtre", "Incantation", "Enchantement"]),
        AlveoleTheme(nom: "Le chauffage", mots: ["Cheminée", "Radiateur", "Chaudière", "Thermostat", "Brasero", "Bûche"]),
        AlveoleTheme(nom: "Supports d'écriture", mots: ["Papyrus", "Parchemin", "Tablette", "Calque", "Buvard", "Vélin"]),
        AlveoleTheme(nom: "Crustacés et coquillages", mots: ["Crabe", "Crevette", "Homard", "Bulot", "Huître", "Langouste"]),
        AlveoleTheme(nom: "Le voyage", mots: ["Valise", "Billet", "Itinéraire", "Souvenir", "Bagage", "Croisière"]),
        AlveoleTheme(nom: "Les mots du bureau", mots: ["Agrafeuse", "Classeur", "Tampon", "Corbeille", "Imprimante", "Trombone"]),
        AlveoleTheme(nom: "La pêche", mots: ["Canne", "Hameçon", "Appât", "Filet", "Épuisette", "Moulinet"]),
        AlveoleTheme(nom: "Le maquillage", mots: ["Fard", "Mascara", "Vernis", "Poudre", "Rouge à lèvres", "Pinceau"]),
        AlveoleTheme(nom: "L'armée", mots: ["Caserne", "Uniforme", "Grade", "Régiment", "Sentinelle", "Garnison"]),
        AlveoleTheme(nom: "Le jeu de cartes", mots: ["Trèfle", "Carreau", "Cœur", "Atout", "Valet", "Joker"]),
        AlveoleTheme(nom: "La couture", mots: ["Aiguille", "Fil", "Patron", "Ourlet", "Bobine", "Épingle"]),
        AlveoleTheme(nom: "Les produits de la ruche", mots: ["Miel", "Cire", "Propolis", "Gelée royale", "Pollen", "Hydromel"]),    ]

    static func generate() -> NidPuzzle {
        guard let theme = themes.randomElement() else {
            return NidPuzzle(theme: AlveoleTheme(nom: "Couleurs",
                                                 mots: ["Rouge", "Bleu", "Vert", "Jaune", "Orange", "Violet"]),
                             proposes: ["Rouge", "Bleu", "Vert", "Jaune", "Orange", "Violet",
                                        "Carré", "Rond", "Ligne"])
        }
        // Les intrus viennent d'autres thèmes : ce sont de vrais mots, plausibles
        // à première vue, et c'est ce qui fait la difficulté.
        let intrus = themes
            .filter { $0.nom != theme.nom }
            .flatMap(\.mots)
            .filter { !theme.mots.contains($0) }
            .shuffled()
            .prefix(3)

        return NidPuzzle(theme: theme,
                         proposes: (theme.mots + intrus).shuffled())
    }
}

// MARK: - ViewModel

@MainActor
@Observable
final class NidAbeilleViewModel {
    var puzzle: NidPuzzle?
    /// Les six alvéoles de la couronne, dans l'ordre horaire.
    var alveoles: [String?] = Array(repeating: nil, count: 6)
    var motSelectionne: String?
    var currentQuestion: Int = 0
    var totalQuestions: Int = 5
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var timeRemaining: Int = 60
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var showResult: Bool = false
    var derniereReussie: Bool = false

    private var timerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    var accuracy: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }

    var motsDisponibles: [String] {
        let places = Set(alveoles.compactMap { $0 })
        return puzzle?.proposes.filter { !places.contains($0) } ?? []
    }

    var ruchePleine: Bool { alveoles.allSatisfy { $0 != nil } }

    func startGame() {
        currentQuestion = 0
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        loadPuzzle()
    }

    private func loadPuzzle() {
        puzzle = NidGenerator.generate()
        alveoles = Array(repeating: nil, count: 6)
        motSelectionne = nil
        showResult = false
        derniereReussie = false
        timeRemaining = 60
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 60) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            valider(force: true)
        }
    }

    func selectionner(_ mot: String) {
        guard !showResult else { return }
        motSelectionne = (motSelectionne == mot) ? nil : mot
    }

    func placerEn(_ index: Int) {
        guard !showResult else { return }
        if let mot = motSelectionne {
            alveoles[index] = mot
            motSelectionne = nil
            HapticManager.light()
        } else if alveoles[index] != nil {
            alveoles[index] = nil
            HapticManager.light()
        }
    }

    /// L'ordre dans la couronne n'a pas d'importance : seul compte l'ensemble
    /// des six mots retenus.
    func valider(force: Bool = false) {
        guard !showResult, force || ruchePleine else { return }
        timerTask?.cancel()
        showResult = true

        let choisis = Set(alveoles.compactMap { $0 })
        derniereReussie = choisis == Set(puzzle?.solution ?? [])
        if derniereReussie {
            correctAnswers += 1
            HapticManager.success()
        } else {
            wrongAnswers += 1
            HapticManager.error()
        }

        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(3))
            if Task.isCancelled { return }
            currentQuestion += 1
            if currentQuestion >= totalQuestions {
                endGame()
            } else {
                loadPuzzle()
            }
        }
    }

    private func endGame() {
        timerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = true
    }

    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        return GameResult(gameType: .nidAbeille, score: Double(correctAnswers),
                          correctAnswers: correctAnswers, totalItems: totalQuestions,
                          duration: 0)
    }

    func stopGame() {
        timerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - Rendu de la ruche

/// Une alvéole hexagonale.
struct Hexagone: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let centre = CGPoint(x: rect.midX, y: rect.midY)
        let rayon = min(rect.width, rect.height) / 2
        for index in 0..<6 {
            // Sommet pointant vers le haut
            let angle = Double(index) * .pi / 3 - .pi / 2
            let point = CGPoint(x: centre.x + cos(angle) * rayon,
                                y: centre.y + sin(angle) * rayon)
            index == 0 ? path.move(to: point) : path.addLine(to: point)
        }
        path.closeSubpath()
        return path
    }
}

private struct AlveoleView: View {
    let texte: String?
    let estCentre: Bool
    let enAttente: Bool
    var cote: CGFloat = 88

    var body: some View {
        ZStack {
            Hexagone()
                .fill(estCentre ? Theme.accent
                      : (texte == nil ? Theme.surface : Theme.accent.opacity(0.16)))
            Hexagone()
                .stroke(enAttente ? Theme.ambre : Theme.filet, lineWidth: enAttente ? 2.5 : 1.5)
            Text(texte ?? "")
                .font(.system(size: estCentre ? 12 : 11,
                              weight: estCentre ? .bold : .semibold))
                .foregroundStyle(estCentre ? .white : Theme.texteFort)
                .multilineTextAlignment(.center)
                // Un facteur trop bas réduisait un thème long à 7 points
                .minimumScaleFactor(0.8)
                .lineLimit(3)
                .padding(.horizontal, 6)
        }
        .frame(width: cote, height: cote)
    }
}

// MARK: - Vue

struct NidAbeilleView: View {
    @State private var viewModel = NidAbeilleViewModel()

    private let cote: CGFloat = 84

    var body: some View {
        VStack(spacing: 12) {
            if viewModel.isGameActive {
                gameView
            } else if viewModel.isGameOver {
                gameOverView
            } else {
                startView
            }
        }
        .padding()
        .recordSession(when: viewModel.isGameOver) { viewModel.makeResult() }
        .sortieProtegee(enPartie: viewModel.isGameActive) { viewModel.stopGame() }
        .navigationTitle("Nid d'Abeille")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .nidAbeille)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Nid d'Abeille",
                    rules: [
                        RuleItem(icon: "hexagon", text: "L'alvéole centrale donne le thème"),
                        RuleItem(icon: "square.grid.3x3", text: "Neuf mots sont proposés, six appartiennent au thème"),
                        RuleItem(icon: "hand.tap", text: "Touche un mot puis une alvéole vide"),
                        RuleItem(icon: "exclamationmark.triangle", text: "Trois intrus ressemblent aux bons mots"),
                        RuleItem(icon: "timer", text: "60 secondes par ruche")
                    ],
                    accentColor: Theme.accentViolet,
                    isGameActive: viewModel.isGameActive
                )
            }
        }
        .onDisappear { viewModel.stopGame() }
    }

    private var startView: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "hexagon.fill")
                    .font(.system(size: 68))
                    .foregroundStyle(Theme.accentViolet)
                Text("Nid d'Abeille").font(.largeTitle.weight(.bold))

                ReglesCompactes(regles: [
                    "L'alvéole centrale donne le thème",
                    "Neuf mots sont proposés, six seulement appartiennent au thème",
                    "Touche un mot puis une alvéole pour l'y poser"
                ], teinte: Theme.accentViolet)

                TutoExemple(legende: "Trois intrus se glissent parmi les neuf mots. Ils sont crédibles : c'est là que se joue l'exercice.") {
                    HStack(spacing: 6) {
                        AlveoleView(texte: "Outils", estCentre: true, enAttente: false, cote: 62)
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Marteau · Scie · Rabot")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(Theme.vert)
                            Text("Balance · Cahier")
                                .font(.system(size: 12))
                                .foregroundStyle(Theme.rouge)
                        }
                    }
                }

                Text("Cet exercice existe au PSY0 depuis 2022, mais ses règles exactes ne sont pas publiques : ceci en est une adaptation, pas une reproduction.")
                    .font(.caption2)
                    .foregroundStyle(Theme.texteFaible)
                    .multilineTextAlignment(.center)

                Text("5 ruches, 60s chacune")
                    .font(.callout)
                    .foregroundStyle(Theme.texteFaible)

                Button {
                    viewModel.startGame()
                } label: {
                    Text("Commencer")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.accentViolet)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.vertical, 6)
        }
    }

    @ViewBuilder
    private var gameView: some View {
        if let puzzle = viewModel.puzzle {
            VStack(spacing: 12) {
                HStack {
                    Text("Ruche \(viewModel.currentQuestion + 1)/\(viewModel.totalQuestions)")
                        .font(.headline)
                    Spacer()
                    TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 60)
                }

                ruche(puzzle)

                if !viewModel.motsDisponibles.isEmpty && !viewModel.showResult {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()),
                                        GridItem(.flexible())], spacing: 6) {
                        ForEach(viewModel.motsDisponibles, id: \.self) { mot in
                            Button {
                                viewModel.selectionner(mot)
                            } label: {
                                Text(mot)
                                    .font(.system(size: 13, weight: .medium))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .background(viewModel.motSelectionne == mot
                                                ? Theme.ambre.opacity(0.35) : Theme.surface,
                                                in: RoundedRectangle(cornerRadius: 9))
                                    .overlay(RoundedRectangle(cornerRadius: 9)
                                        .strokeBorder(Theme.filet, lineWidth: 1))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                if viewModel.showResult {
                    VStack(spacing: 3) {
                        Text(viewModel.derniereReussie ? "Ruche complète !" : "Raté")
                            .font(.headline)
                            .foregroundStyle(viewModel.derniereReussie ? Theme.vert : Theme.rouge)
                        if !viewModel.derniereReussie {
                            Text(puzzle.solution.joined(separator: " · "))
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Theme.texteFort)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                } else {
                    Button {
                        viewModel.valider()
                    } label: {
                        Text("Valider la ruche")
                            .font(.carte)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(viewModel.ruchePleine ? Theme.accentViolet : Theme.filet,
                                        in: RoundedRectangle(cornerRadius: 10))
                    }
                    .disabled(!viewModel.ruchePleine)
                }

                Spacer(minLength: 0)
            }
        }
    }

    /// Six alvéoles disposées autour d'une septième.
    private func ruche(_ puzzle: NidPuzzle) -> some View {
        let pas = cote * 0.87
        return ZStack {
            AlveoleView(texte: puzzle.theme.nom, estCentre: true,
                        enAttente: false, cote: cote)
            ForEach(0..<6, id: \.self) { index in
                let angle = Double(index) * .pi / 3 - .pi / 2
                AlveoleView(texte: viewModel.alveoles[index],
                            estCentre: false,
                            enAttente: viewModel.motSelectionne != nil
                                && viewModel.alveoles[index] == nil,
                            cote: cote)
                    .offset(x: cos(angle) * pas, y: sin(angle) * pas)
                    .onTapGesture { viewModel.placerEn(index) }
            }
        }
        .frame(height: cote * 2.9)
    }

    private var gameOverView: some View {
        VStack(spacing: 24) {
            Spacer()
            EnTeteDeFin(taux: viewModel.accuracy)

            VStack(spacing: 12) {
                ResultRow(label: "Ruches complètes",
                          value: "\(viewModel.correctAnswers)/\(viewModel.totalQuestions)")
                ResultRow(label: "Précision", value: String(format: "%.0f%%", viewModel.accuracy))
            }
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Theme.accentViolet)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        NidAbeilleView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
