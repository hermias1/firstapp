import SwiftUI

// MARK: - Model
struct WordCategory {
    let name: String
    let words: [String]
}

extension WordCategory {
    static let allCategories: [[WordCategory]] = [
        // Série 1 - Alimentation
        [
            WordCategory(name: "Fruits", words: ["Pomme", "Banane", "Orange", "Fraise", "Cerise", "Mangue"]),
            WordCategory(name: "Légumes", words: ["Carotte", "Tomate", "Haricot", "Oignon", "Poivron", "Salade"]),
            WordCategory(name: "Viandes", words: ["Poulet", "Bœuf", "Porc", "Agneau", "Canard", "Dinde"]),
            WordCategory(name: "Poissons", words: ["Saumon", "Thon", "Cabillaud", "Truite", "Sardine", "Bar"])
        ],
        // Série 2 - Arts
        [
            WordCategory(name: "Sports", words: ["Football", "Tennis", "Natation", "Basket", "Rugby", "Golf"]),
            WordCategory(name: "Musique", words: ["Piano", "Guitare", "Violon", "Batterie", "Flûte", "Saxophone"]),
            WordCategory(name: "Cinéma", words: ["Acteur", "Réalisateur", "Scénario", "Caméra", "Montage", "Plateau"]),
            WordCategory(name: "Peinture", words: ["Toile", "Pinceau", "Couleur", "Chevalet", "Portrait", "Huile"])
        ],
        // Série 3 - Mode
        [
            WordCategory(name: "Vêtements", words: ["Pantalon", "Chemise", "Veste", "Manteau", "Robe", "Jupe"]),
            WordCategory(name: "Chaussures", words: ["Basket", "Botte", "Sandale", "Mocassin", "Escarpin", "Tennis"]),
            WordCategory(name: "Bijoux", words: ["Bague", "Collier", "Bracelet", "Boucle", "Montre", "Pendentif"]),
            WordCategory(name: "Accessoires", words: ["Ceinture", "Sac", "Chapeau", "Écharpe", "Gants", "Lunettes"])
        ],
        // Série 4 - Faune
        [
            WordCategory(name: "Mammifères", words: ["Chien", "Chat", "Lion", "Tigre", "Éléphant", "Girafe"]),
            WordCategory(name: "Oiseaux", words: ["Aigle", "Moineau", "Pigeon", "Corbeau", "Hibou", "Perroquet"]),
            WordCategory(name: "Insectes", words: ["Abeille", "Papillon", "Fourmi", "Mouche", "Coccinelle", "Scarabée"]),
            WordCategory(name: "Reptiles", words: ["Serpent", "Lézard", "Tortue", "Crocodile", "Caméléon", "Gecko"])
        ],
        // Série 5 - Société
        [
            WordCategory(name: "Métiers", words: ["Médecin", "Avocat", "Pompier", "Pilote", "Cuisinier", "Architecte"]),
            WordCategory(name: "Transports", words: ["Voiture", "Avion", "Bateau", "Train", "Vélo", "Moto"]),
            WordCategory(name: "Bâtiments", words: ["Maison", "Immeuble", "École", "Hôpital", "Église", "Musée"]),
            WordCategory(name: "Meubles", words: ["Table", "Chaise", "Lit", "Armoire", "Bureau", "Canapé"])
        ],
        // Série 6 - Géographie
        [
            WordCategory(name: "Pays", words: ["France", "Espagne", "Allemagne", "Italie", "Portugal", "Belgique"]),
            WordCategory(name: "Capitales", words: ["Paris", "Madrid", "Berlin", "Rome", "Lisbonne", "Bruxelles"]),
            WordCategory(name: "Fleuves", words: ["Seine", "Loire", "Rhône", "Garonne", "Rhin", "Danube"]),
            WordCategory(name: "Montagnes", words: ["Alpes", "Pyrénées", "Vosges", "Jura", "Massif Central", "Mont Blanc"])
        ],
        // Série 7 - Sciences
        [
            WordCategory(name: "Physique", words: ["Atome", "Électron", "Proton", "Neutron", "Énergie", "Force"]),
            WordCategory(name: "Chimie", words: ["Molécule", "Acide", "Base", "Sel", "Oxygène", "Hydrogène"]),
            WordCategory(name: "Biologie", words: ["Cellule", "ADN", "Gène", "Protéine", "Enzyme", "Virus"]),
            WordCategory(name: "Astronomie", words: ["Étoile", "Planète", "Galaxie", "Comète", "Satellite", "Astéroïde"])
        ],
        // Série 8 - Culture
        [
            WordCategory(name: "Littérature", words: ["Roman", "Poème", "Nouvelle", "Essai", "Fable", "Conte"]),
            WordCategory(name: "Théâtre", words: ["Scène", "Acteur", "Rideau", "Décor", "Costumes", "Réplique"]),
            WordCategory(name: "Danse", words: ["Ballet", "Valse", "Tango", "Salsa", "Hip-hop", "Classique"]),
            WordCategory(name: "Architecture", words: ["Colonne", "Arche", "Dôme", "Façade", "Voûte", "Pilier"])
        ],
        // Série 9 - Nature
        [
            WordCategory(name: "Arbres", words: ["Chêne", "Pin", "Sapin", "Bouleau", "Érable", "Olivier"]),
            WordCategory(name: "Fleurs", words: ["Rose", "Tulipe", "Orchidée", "Lys", "Marguerite", "Violette"]),
            WordCategory(name: "Saisons", words: ["Printemps", "Été", "Automne", "Hiver", "Équinoxe", "Solstice"]),
            WordCategory(name: "Météo", words: ["Pluie", "Neige", "Soleil", "Vent", "Orage", "Brouillard"])
        ],
        // Série 10 - Corps
        [
            WordCategory(name: "Organes", words: ["Cœur", "Poumon", "Foie", "Rein", "Cerveau", "Estomac"]),
            WordCategory(name: "Os", words: ["Fémur", "Tibia", "Crâne", "Vertèbre", "Côte", "Humérus"]),
            WordCategory(name: "Muscles", words: ["Biceps", "Triceps", "Abdominaux", "Quadriceps", "Mollet", "Pectoraux"]),
            WordCategory(name: "Sens", words: ["Vue", "Ouïe", "Odorat", "Goût", "Toucher", "Équilibre"])
        ],
        // Série 11 - Maison
        [
            WordCategory(name: "Cuisine", words: ["Casserole", "Poêle", "Couteau", "Fourchette", "Assiette", "Verre"]),
            WordCategory(name: "Salle de bain", words: ["Douche", "Lavabo", "Miroir", "Serviette", "Savon", "Brosse"]),
            WordCategory(name: "Chambre", words: ["Lit", "Oreiller", "Couette", "Matelas", "Lampe", "Réveil"]),
            WordCategory(name: "Jardin", words: ["Pelouse", "Haie", "Arbre", "Fleur", "Potager", "Terrasse"])
        ],
        // Série 12 - Technologie
        [
            WordCategory(name: "Informatique", words: ["Ordinateur", "Clavier", "Souris", "Écran", "Processeur", "Mémoire"]),
            WordCategory(name: "Internet", words: ["Site", "Email", "Réseau", "Serveur", "Cloud", "Wi-Fi"]),
            WordCategory(name: "Téléphone", words: ["Mobile", "Appel", "SMS", "Application", "Batterie", "Sonnerie"]),
            WordCategory(name: "Jeux vidéo", words: ["Console", "Manette", "Avatar", "Niveau", "Score", "Boss"])
        ],
        // Série 13 - Économie
        [
            WordCategory(name: "Finance", words: ["Banque", "Crédit", "Épargne", "Intérêt", "Placement", "Bourse"]),
            WordCategory(name: "Commerce", words: ["Magasin", "Client", "Vendeur", "Prix", "Soldes", "Caisse"]),
            WordCategory(name: "Entreprise", words: ["Société", "Employé", "Patron", "Bureau", "Réunion", "Contrat"]),
            WordCategory(name: "Impôts", words: ["Taxe", "Déclaration", "Revenu", "TVA", "Trésor", "Fisc"])
        ],
        // Série 14 - Histoire
        [
            WordCategory(name: "Antiquité", words: ["Pharaon", "Empereur", "Gladiateur", "Temple", "Pyramide", "Forum"]),
            WordCategory(name: "Moyen Âge", words: ["Château", "Chevalier", "Roi", "Seigneur", "Paysan", "Cathédrale"]),
            WordCategory(name: "Révolution", words: ["Bastille", "Guillotine", "République", "Liberté", "Égalité", "Fraternité"]),
            WordCategory(name: "Moderne", words: ["Usine", "Machine", "Train", "Électricité", "Téléphone", "Avion"])
        ],
        // Série 15 - Émotions
        [
            WordCategory(name: "Joie", words: ["Bonheur", "Plaisir", "Rire", "Sourire", "Fête", "Euphorie"]),
            WordCategory(name: "Tristesse", words: ["Chagrin", "Larme", "Mélancolie", "Deuil", "Nostalgie", "Peine"]),
            WordCategory(name: "Peur", words: ["Angoisse", "Terreur", "Crainte", "Panique", "Frayeur", "Effroi"]),
            WordCategory(name: "Colère", words: ["Rage", "Fureur", "Irritation", "Frustration", "Exaspération", "Révolte"])
        ],
    ]
}

// MARK: - ViewModel
@MainActor
@Observable
final class BoitesAMotsViewModel {
    var categories: [WordCategory] = []
    var boxAssignments: [Int: Int] = [:] // categoryIndex -> boxIndex
    var currentWord: String = ""
    var currentCategoryIndex: Int = 0
    var wordQueue: [(word: String, categoryIndex: Int)] = []
    var currentWordIndex: Int = 0
    var currentSeries: Int = 0
    var totalSeries: Int = 5
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var showingWord: Bool = false
    var feedback: String?

    private var seriesOrder: [Int] = []

    private var wordTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    var accuracy: Double {
        let total = correctAnswers + wrongAnswers
        guard total > 0 else { return 0 }
        return Double(correctAnswers) / Double(total) * 100
    }

    func startGame() {
        currentSeries = 0
        seriesOrder = Array(0..<WordCategory.allCategories.count).shuffled()
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        startNewSeries()
    }

    func startNewSeries() {
        guard currentSeries < seriesOrder.count else {
            endGame()
            return
        }

        categories = WordCategory.allCategories[seriesOrder[currentSeries]]
        boxAssignments = [:]
        feedback = nil

        // Créer la file de mots mélangés
        wordQueue = []
        for (index, category) in categories.enumerated() {
            for word in category.words {
                wordQueue.append((word, index))
            }
        }
        wordQueue.shuffle()

        currentWordIndex = 0
        showNextWord()
    }

    private func showNextWord() {
        guard currentWordIndex < wordQueue.count else {
            // Série terminée
            currentSeries += 1
            if currentSeries >= totalSeries {
                endGame()
            } else {
                transitionTask?.cancel()
                transitionTask = Task { @MainActor in
                    try? await Task.sleep(for: .seconds(1))
                    if Task.isCancelled { return }
                    startNewSeries()
                }
            }
            return
        }

        let item = wordQueue[currentWordIndex]
        currentWord = item.word
        currentCategoryIndex = item.categoryIndex
        showingWord = true
        feedback = nil

        // Afficher le mot brièvement
        wordTask?.cancel()
        wordTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(1.5))
            if Task.isCancelled { return }
            showingWord = false
        }
    }

    func selectBox(_ boxIndex: Int) {
        wordTask?.cancel()
        showingWord = false

        // Si la boîte n'est pas encore assignée, l'assigner à cette catégorie
        if boxAssignments[currentCategoryIndex] == nil {
            // Vérifier que la boîte n'est pas déjà utilisée
            if !boxAssignments.values.contains(boxIndex) {
                boxAssignments[currentCategoryIndex] = boxIndex
                correctAnswers += 1
                feedback = "Nouvelle catégorie : \(categories[currentCategoryIndex].name)"
            } else {
                // La boîte est déjà utilisée pour une autre catégorie
                wrongAnswers += 1
                feedback = "Cette boîte est déjà utilisée !"
            }
        } else {
            // Vérifier si le choix est correct
            if boxAssignments[currentCategoryIndex] == boxIndex {
                correctAnswers += 1
                feedback = "Correct !"
                HapticManager.success()
            } else {
                wrongAnswers += 1
                let correctBox = boxAssignments[currentCategoryIndex]!
                feedback = "Erreur ! C'était boîte \(correctBox + 1)"
                HapticManager.error()
            }
        }

        currentWordIndex += 1

        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(800))
            if Task.isCancelled { return }
            showNextWord()
        }
    }

    private func endGame() {
        wordTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = true
    }

    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        return GameResult(gameType: .boitesAMots, score: accuracy,
                          correctAnswers: correctAnswers,
                          totalItems: correctAnswers + wrongAnswers, duration: 0)
    }

    func stopGame() {
        wordTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }

    func boxLabel(_ index: Int) -> String {
        for (catIndex, boxIndex) in boxAssignments {
            if boxIndex == index {
                return categories[catIndex].name
            }
        }
        return "Boîte \(index + 1)"
    }

    func isBoxAssigned(_ index: Int) -> Bool {
        boxAssignments.values.contains(index)
    }
}

// MARK: - View
struct BoitesAMotsView: View {
    @State private var viewModel = BoitesAMotsViewModel()

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
        .navigationTitle("Boîtes à Mots")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .boitesAMots)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Boîtes à Mots",
                    rules: [
                        RuleItem(icon: "tray", text: "4 boîtes vides à remplir"),
                        RuleItem(icon: "eye", text: "Un mot apparaît brièvement"),
                        RuleItem(icon: "hand.tap", text: "Range-le dans la boîte de son thème"),
                        RuleItem(icon: "lightbulb", text: "Tu définis toi-même les associations")
                    ],
                    accentColor: .brown,
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

            Image(systemName: "tray.2.fill")
                .font(.system(size: 80))
                .foregroundStyle(.brown)

            Text("Boîtes à Mots")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("4 boîtes vides à remplir", systemImage: "tray")
                    Label("Un mot apparaît brièvement", systemImage: "eye")
                    Label("Range-le dans la boîte de son thème", systemImage: "hand.tap")
                    Label("Tu définis toi-même les associations", systemImage: "lightbulb")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("5 séries, fais le minimum d'erreurs")
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
                    .background(.brown)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Text("Série \(viewModel.currentSeries + 1)/\(viewModel.totalSeries)")
                    .font(.headline)

                Spacer()

                HStack(spacing: 12) {
                    Label("\(viewModel.correctAnswers)", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                    Label("\(viewModel.wrongAnswers)", systemImage: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }
                .font(.subheadline)
            }

            // Mot actuel
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .frame(height: 80)

                if viewModel.showingWord {
                    Text(viewModel.currentWord)
                        .font(.title.weight(.bold))
                        .transition(.opacity)
                } else {
                    Text("Choisis une boîte")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
            }

            // Feedback
            if let feedback = viewModel.feedback {
                Text(feedback)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(feedback.contains("Correct") || feedback.contains("Nouvelle") ? .green : .red)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            // Grille de boîtes
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(0..<viewModel.categories.count, id: \.self) { index in
                    Button {
                        viewModel.selectBox(index)
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: viewModel.isBoxAssigned(index) ? "tray.full.fill" : "tray")
                                .font(.title)

                            Text(viewModel.boxLabel(index))
                                .font(.subheadline.weight(.medium))
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(viewModel.isBoxAssigned(index) ? Color.brown.opacity(0.2) : Color(.systemGray5))
                        .foregroundStyle(viewModel.isBoxAssigned(index) ? .brown : .primary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(viewModel.showingWord)
                }
            }

            Spacer()

            // Progression
            Text("Mot \(min(viewModel.currentWordIndex + 1, viewModel.wordQueue.count))/\(viewModel.wordQueue.count)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var gameOverView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.green)

            Text("Terminé !")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                ResultRow(label: "Bonnes réponses", value: "\(viewModel.correctAnswers)")
                ResultRow(label: "Erreurs", value: "\(viewModel.wrongAnswers)")
                ResultRow(label: "Précision", value: String(format: "%.0f%%", viewModel.accuracy))
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer()

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.brown)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    NavigationStack {
        BoitesAMotsView()
    }
}
