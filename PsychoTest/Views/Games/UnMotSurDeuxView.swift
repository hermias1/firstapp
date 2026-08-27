import SwiftUI

// MARK: - Model
struct WordPair {
    let theme1: String
    let theme2: String
    let words1: [String]
    let words2: [String]
}

extension WordPair {
    static let allPairs: [WordPair] = [
        // Série 1-10 (originales)
        WordPair(theme1: "Fruits", theme2: "Animaux",
            words1: ["Abricot", "Banane", "Cerise", "Fraise", "Mangue"],
            words2: ["Aigle", "Cheval", "Dauphin", "Lion", "Tigre"]),
        WordPair(theme1: "Pays", theme2: "Couleurs",
            words1: ["Allemagne", "Brésil", "Canada", "France", "Japon"],
            words2: ["Blanc", "Gris", "Noir", "Rouge", "Vert"]),
        WordPair(theme1: "Métiers", theme2: "Sports",
            words1: ["Avocat", "Cuisinier", "Médecin", "Pilote", "Pompier"],
            words2: ["Basket", "Football", "Natation", "Rugby", "Tennis"]),
        WordPair(theme1: "Villes", theme2: "Instruments",
            words1: ["Berlin", "Londres", "Madrid", "Paris", "Rome"],
            words2: ["Batterie", "Guitare", "Piano", "Trompette", "Violon"]),
        WordPair(theme1: "Légumes", theme2: "Véhicules",
            words1: ["Carotte", "Haricot", "Oignon", "Poivron", "Tomate"],
            words2: ["Avion", "Bateau", "Moto", "Train", "Voiture"]),
        WordPair(theme1: "Mois", theme2: "Planètes",
            words1: ["Avril", "Février", "Janvier", "Mars", "Novembre"],
            words2: ["Jupiter", "Neptune", "Saturne", "Uranus", "Vénus"]),
        WordPair(theme1: "Fleurs", theme2: "Oiseaux",
            words1: ["Dahlia", "Iris", "Lilas", "Rose", "Tulipe"],
            words2: ["Canari", "Corbeau", "Moineau", "Pigeon", "Rossignol"]),
        WordPair(theme1: "Arbres", theme2: "Poissons",
            words1: ["Bouleau", "Chêne", "Érable", "Pin", "Saule"],
            words2: ["Carpe", "Requin", "Saumon", "Thon", "Truite"]),
        WordPair(theme1: "Boissons", theme2: "Matières",
            words1: ["Café", "Eau", "Jus", "Lait", "Thé"],
            words2: ["Anglais", "Chimie", "Histoire", "Maths", "Physique"]),
        WordPair(theme1: "Meubles", theme2: "Saisons",
            words1: ["Armoire", "Bureau", "Chaise", "Lit", "Table"],
            words2: ["Automne", "Été", "Hiver", "Printemps", "Solstice"]),

        // Série 11-20
        WordPair(theme1: "Capitales", theme2: "Océans",
            words1: ["Athènes", "Berlin", "Lisbonne", "Oslo", "Vienne"],
            words2: ["Arctique", "Atlantique", "Indien", "Pacifique", "Antarctique"]),
        WordPair(theme1: "Fromages", theme2: "Danses",
            words1: ["Brie", "Camembert", "Gruyère", "Roquefort", "Tomme"],
            words2: ["Ballet", "Salsa", "Tango", "Valse", "Zumba"]),
        WordPair(theme1: "Pierres", theme2: "Métaux",
            words1: ["Diamant", "Émeraude", "Rubis", "Saphir", "Topaze"],
            words2: ["Argent", "Bronze", "Cuivre", "Fer", "Or"]),
        WordPair(theme1: "Épices", theme2: "Tissus",
            words1: ["Cannelle", "Cumin", "Paprika", "Poivre", "Safran"],
            words2: ["Coton", "Laine", "Lin", "Soie", "Velours"]),
        WordPair(theme1: "Desserts", theme2: "Jeux",
            words1: ["Brownie", "Crêpe", "Éclair", "Macaron", "Tarte"],
            words2: ["Bridge", "Dames", "Échecs", "Poker", "Scrabble"]),
        WordPair(theme1: "Rivières", theme2: "Montagnes",
            words1: ["Danube", "Garonne", "Loire", "Rhin", "Seine"],
            words2: ["Alpes", "Andes", "Atlas", "Himalaya", "Pyrénées"]),
        WordPair(theme1: "Insectes", theme2: "Reptiles",
            words1: ["Abeille", "Fourmi", "Libellule", "Mouche", "Papillon"],
            words2: ["Cobra", "Iguane", "Lézard", "Python", "Tortue"]),
        WordPair(theme1: "Outils", theme2: "Armes",
            words1: ["Clé", "Marteau", "Pince", "Scie", "Tournevis"],
            words2: ["Arc", "Épée", "Fusil", "Lance", "Sabre"]),
        WordPair(theme1: "Verbes", theme2: "Adjectifs",
            words1: ["Aimer", "Courir", "Dormir", "Manger", "Parler"],
            words2: ["Beau", "Grand", "Petit", "Rapide", "Vieux"]),
        WordPair(theme1: "Nombres", theme2: "Lettres",
            words1: ["Cinq", "Deux", "Quatre", "Sept", "Trois"],
            words2: ["Alpha", "Delta", "Gamma", "Omega", "Sigma"]),

        // Série 21-30
        WordPair(theme1: "Fruits Exotiques", theme2: "Félins",
            words1: ["Ananas", "Coco", "Goyave", "Litchi", "Papaye"],
            words2: ["Guépard", "Jaguar", "Léopard", "Lynx", "Puma"]),
        WordPair(theme1: "Religions", theme2: "Philosophes",
            words1: ["Bouddhisme", "Christianisme", "Hindouisme", "Islam", "Judaïsme"],
            words2: ["Aristote", "Descartes", "Kant", "Platon", "Socrate"]),
        WordPair(theme1: "Maladies", theme2: "Médicaments",
            words1: ["Angine", "Bronchite", "Diabète", "Grippe", "Rhume"],
            words2: ["Aspirine", "Doliprane", "Ibuprofène", "Paracétamol", "Vitamines"]),
        WordPair(theme1: "Planètes", theme2: "Étoiles",
            words1: ["Jupiter", "Mars", "Neptune", "Saturne", "Vénus"],
            words2: ["Aldébaran", "Bételgeuse", "Polaire", "Sirius", "Véga"]),
        WordPair(theme1: "Compositeurs", theme2: "Peintres",
            words1: ["Bach", "Beethoven", "Chopin", "Mozart", "Vivaldi"],
            words2: ["Dali", "Monet", "Picasso", "Renoir", "Van Gogh"]),
        WordPair(theme1: "Langues", theme2: "Alphabets",
            words1: ["Allemand", "Anglais", "Espagnol", "Français", "Italien"],
            words2: ["Arabe", "Cyrillique", "Grec", "Hébraïque", "Latin"]),
        WordPair(theme1: "Sens", theme2: "Organes",
            words1: ["Goût", "Odorat", "Ouïe", "Toucher", "Vue"],
            words2: ["Cerveau", "Cœur", "Foie", "Poumon", "Rein"]),
        WordPair(theme1: "Émotions", theme2: "Vertus",
            words1: ["Amour", "Colère", "Joie", "Peur", "Tristesse"],
            words2: ["Courage", "Générosité", "Patience", "Prudence", "Sagesse"]),
        WordPair(theme1: "Sciences", theme2: "Arts",
            words1: ["Astronomie", "Biologie", "Chimie", "Physique", "Zoologie"],
            words2: ["Architecture", "Cinéma", "Musique", "Peinture", "Sculpture"]),
        WordPair(theme1: "Saisons", theme2: "Jours",
            words1: ["Automne", "Été", "Hiver", "Printemps", "Solstice"],
            words2: ["Dimanche", "Jeudi", "Lundi", "Samedi", "Vendredi"]),

        // Série 31-40
        WordPair(theme1: "Vins", theme2: "Bières",
            words1: ["Beaujolais", "Bordeaux", "Bourgogne", "Champagne", "Côtes-du-Rhône"],
            words2: ["Guinness", "Heineken", "Kronenbourg", "Leffe", "Stella"]),
        WordPair(theme1: "Céréales", theme2: "Légumineuses",
            words1: ["Avoine", "Blé", "Maïs", "Orge", "Riz"],
            words2: ["Fève", "Haricot", "Lentille", "Pois", "Soja"]),
        WordPair(theme1: "Capitales Asie", theme2: "Capitales Europe",
            words1: ["Bangkok", "Pékin", "Séoul", "Tokyo", "New Delhi"],
            words2: ["Amsterdam", "Bruxelles", "Londres", "Madrid", "Rome"]),
        WordPair(theme1: "Dieux Grecs", theme2: "Dieux Romains",
            words1: ["Apollon", "Arès", "Athéna", "Poséidon", "Zeus"],
            words2: ["Jupiter", "Mars", "Mercure", "Neptune", "Vénus"]),
        WordPair(theme1: "Chiffres", theme2: "Formes",
            words1: ["Cent", "Dix", "Mille", "Un", "Zéro"],
            words2: ["Carré", "Cercle", "Losange", "Rectangle", "Triangle"]),
        WordPair(theme1: "Continents", theme2: "Mers",
            words1: ["Afrique", "Amérique", "Asie", "Europe", "Océanie"],
            words2: ["Baltique", "Méditerranée", "Morte", "Nord", "Rouge"]),
        WordPair(theme1: "Félins", theme2: "Canidés",
            words1: ["Chat", "Guépard", "Lion", "Panthère", "Tigre"],
            words2: ["Chien", "Coyote", "Loup", "Renard", "Hyène"]),
        WordPair(theme1: "Sports Aquatiques", theme2: "Sports d'Hiver",
            words1: ["Kayak", "Natation", "Plongée", "Surf", "Voile"],
            words2: ["Bobsleigh", "Hockey", "Luge", "Patinage", "Ski"]),
        WordPair(theme1: "Herbes", theme2: "Champignons",
            words1: ["Basilic", "Ciboulette", "Menthe", "Persil", "Thym"],
            words2: ["Bolet", "Cèpe", "Girolle", "Morille", "Truffe"]),
        WordPair(theme1: "Romans", theme2: "Films",
            words1: ["Germinal", "Hamlet", "Madame Bovary", "Notre-Dame", "Ulysse"],
            words2: ["Avatar", "Inception", "Matrix", "Titanic", "Vertigo"]),
    ]
}

// MARK: - ViewModel
@MainActor
@Observable
final class UnMotSurDeuxViewModel {
    var currentPair: WordPair?
    var allWords: [String] = []
    var selectedWords: [String] = []
    var currentSeries: Int = 0
    var totalSeries: Int = 10
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var hasError: Bool = false
    var errorCount: Int = 0
    var startTime: Date?
    var seriesTimes: [TimeInterval] = []

    // Tracking pour l'alternance
    var nextExpectedTheme1Index: Int = 0
    var nextExpectedTheme2Index: Int = 0
    var expectingTheme1: Bool = true

    var sortedWords1: [String] = []
    var sortedWords2: [String] = []

    private var transitionTask: Task<Void, Never>?

    var averageTime: TimeInterval {
        guard !seriesTimes.isEmpty else { return 0 }
        return seriesTimes.reduce(0, +) / Double(seriesTimes.count)
    }

    var theme1Name: String {
        currentPair?.theme1 ?? ""
    }

    var theme2Name: String {
        currentPair?.theme2 ?? ""
    }

    func startGame() {
        currentSeries = 0
        seriesTimes = []
        errorCount = 0
        isGameActive = true
        isGameOver = false
        startNewSeries()
    }

    func startNewSeries(resetTimer: Bool = true) {
        hasError = false
        selectedWords = []
        expectingTheme1 = true
        nextExpectedTheme1Index = 0
        nextExpectedTheme2Index = 0

        // Sélectionner une paire aléatoire
        currentPair = BanqueRotation.tirer(WordPair.allPairs, nombre: 1,
                                           cle: "motSurDeux") { $0.theme1 + "/" + $0.theme2 }.first
            ?? WordPair.allPairs.randomElement()

        guard let pair = currentPair else { return }

        // Trier les mots par ordre alphabétique
        sortedWords1 = pair.words1.sorted { $0.localizedStandardCompare($1) == .orderedAscending }
        sortedWords2 = pair.words2.sorted { $0.localizedStandardCompare($1) == .orderedAscending }

        // Mélanger tous les mots pour l'affichage
        allWords = (sortedWords1 + sortedWords2).shuffled()

        if resetTimer { startTime = Date() }
    }

    func selectWord(_ word: String) {
        guard !hasError else { return }

        let isFromTheme1 = sortedWords1.contains(word)
        let isFromTheme2 = sortedWords2.contains(word)

        if expectingTheme1 {
            // On attend un mot du thème 1
            if isFromTheme1 {
                let expectedWord = sortedWords1[nextExpectedTheme1Index]
                if word == expectedWord {
                    selectedWords.append(word)
                    nextExpectedTheme1Index += 1
                    expectingTheme1 = false
                    checkSeriesComplete()
                } else {
                    triggerError()
                }
            } else {
                triggerError()
            }
        } else {
            // On attend un mot du thème 2
            if isFromTheme2 {
                let expectedWord = sortedWords2[nextExpectedTheme2Index]
                if word == expectedWord {
                    selectedWords.append(word)
                    nextExpectedTheme2Index += 1
                    expectingTheme1 = true
                    checkSeriesComplete()
                } else {
                    triggerError()
                }
            } else {
                triggerError()
            }
        }
    }

    private func triggerError() {
        hasError = true
        errorCount += 1
        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(1))
            if Task.isCancelled { return }
            startNewSeries(resetTimer: false)
        }
    }

    private func checkSeriesComplete() {
        let totalExpected = sortedWords1.count + sortedWords2.count
        if selectedWords.count == totalExpected {
            if let start = startTime {
                seriesTimes.append(Date().timeIntervalSince(start))
            }
            currentSeries += 1

            if currentSeries >= totalSeries {
                isGameActive = false
                isGameOver = true
            } else {
                transitionTask?.cancel()
                transitionTask = Task { @MainActor in
                    try? await Task.sleep(for: .milliseconds(500))
                    if Task.isCancelled { return }
                    startNewSeries()
                }
            }
        }
    }

    func isSelected(_ word: String) -> Bool {
        selectedWords.contains(word)
    }

    func wordTheme(_ word: String) -> Int {
        if sortedWords1.contains(word) { return 1 }
        if sortedWords2.contains(word) { return 2 }
        return 0
    }

    /// Temps moyen par série : plus bas est meilleur.
    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        // Le total inclut les tentatives ratées : sans cela le taux de
        // réussite vaudrait 100 % même en se trompant à chaque série.
        return GameResult(gameType: .unMotSurDeux, score: averageTime,
                          correctAnswers: currentSeries,
                          totalItems: currentSeries + errorCount,
                          duration: seriesTimes.reduce(0, +))
    }

    func stopGame() {
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - View
struct UnMotSurDeuxView: View {
    @State private var viewModel = UnMotSurDeuxViewModel()

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isGameActive {
                gameActiveView
            } else if viewModel.isGameOver {
                gameOverView
            } else {
                startView
            }
        }
        .padding()
        .recordSession(when: viewModel.isGameOver) { viewModel.makeResult() }
        .sortieProtegee(enPartie: viewModel.isGameActive) { viewModel.stopGame() }
        .navigationTitle("Un Mot sur Deux")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .unMotSurDeux)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Un Mot sur Deux",
                    rules: [
                        RuleItem(icon: "textformat.abc", text: "2 thématiques mélangées"),
                        RuleItem(icon: "arrow.left.arrow.right", text: "Alterne entre les 2 thèmes"),
                        RuleItem(icon: "textformat.abc.dottedunderline", text: "Ordre alphabétique dans chaque thème"),
                        RuleItem(icon: "exclamationmark.triangle", text: "Erreur = nouvelle série")
                    ],
                    accentColor: Theme.accent,
                    isGameActive: viewModel.isGameActive
                )
            }
        }
        .onDisappear {
            viewModel.stopGame()
        }
    }

    private var startView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "textformat.alt")
                .font(.system(size: 80))
                .foregroundStyle(Theme.accent)

            Text("Un Mot sur Deux")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("2 thématiques de mots mélangées", systemImage: "text.word.spacing")
                    Label("Alterne entre les 2 thèmes", systemImage: "arrow.left.arrow.right")
                    Label("Ordre alphabétique dans chaque thème", systemImage: "textformat.abc")
                    Label("Erreur = nouvelle série", systemImage: "exclamationmark.triangle")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("10 séries, le plus vite possible")
                .font(.callout)
                .foregroundStyle(.secondary)

            Spacer()

            Button {
                viewModel.startGame()
            } label: {
                Text("Commencer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.indigo)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Série \(viewModel.currentSeries + 1)/\(viewModel.totalSeries)")
                    .font(.headline)

                Spacer()

                // Indicateur du thème attendu
                Text(viewModel.expectingTheme1 ? "→ \(viewModel.theme1Name)" : "→ \(viewModel.theme2Name)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(viewModel.expectingTheme1 ? .indigo : .orange)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(viewModel.expectingTheme1 ? Theme.accent.opacity(0.15) : Color.orange.opacity(0.15))
                    .clipShape(Capsule())
            }

            // Légende des thèmes
            HStack(spacing: 16) {
                Label(viewModel.theme1Name, systemImage: "circle.fill")
                    .font(.caption)
                    .foregroundStyle(.indigo)
                Label(viewModel.theme2Name, systemImage: "circle.fill")
                    .font(.caption)
                    .foregroundStyle(Theme.ambre)
            }

            if viewModel.hasError {
                Text("Erreur ! Recommence...")
                    .font(.headline)
                    .foregroundStyle(Theme.rouge)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Theme.rouge.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Spacer()

            // Grille de mots
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 10) {
                ForEach(viewModel.allWords, id: \.self) { word in
                    Button {
                        viewModel.selectWord(word)
                    } label: {
                        Text(word)
                            .font(.subheadline.weight(.medium))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(buttonColor(for: word))
                            .foregroundStyle(viewModel.isSelected(word) ? .white : .primary)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .disabled(viewModel.isSelected(word) || viewModel.hasError)
                }
            }

            Spacer()

            // Progression
            Text("Sélectionnés: \(viewModel.selectedWords.count)/\(viewModel.allWords.count)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private func buttonColor(for word: String) -> Color {
        if viewModel.isSelected(word) {
            return viewModel.wordTheme(word) == 1 ? .indigo : .orange
        }
        return Color(.systemGray5)
    }

    private var gameOverView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(Theme.vert)

            Text("Terminé !")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                ResultRow(label: "Séries complétées", value: "\(viewModel.currentSeries)")
                ResultRow(label: "Erreurs", value: "\(viewModel.errorCount)")
                ResultRow(label: "Temps moyen", value: String(format: "%.1fs", viewModel.averageTime))
                ResultRow(label: "Temps total", value: String(format: "%.1fs", viewModel.seriesTimes.reduce(0, +)))
            }
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer()

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.indigo)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    NavigationStack {
        UnMotSurDeuxView()
    }
}
