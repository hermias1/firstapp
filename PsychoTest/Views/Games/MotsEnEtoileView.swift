import SwiftUI

// MARK: - Modèle

/// Une étoile de six mots refermée sur elle-même.
///
/// Règle officielle du test : on choisit 6 mots parmi 9 et on les place sur
/// l'étoile de façon que chaque case commune à deux mots ne porte qu'une seule
/// lettre. Ici, deux mots voisins se rejoignent sur un sommet : la dernière
/// lettre de l'un doit donc être la première lettre du suivant, et le sixième
/// referme la boucle sur le premier.
///
/// La consigne officielle précise qu'une autre solution que celle attendue est
/// acceptée si elle ne comporte pas d'erreur : la validation vérifie donc la
/// contrainte, jamais l'égalité avec une solution mémorisée.
struct EtoilePuzzle {
    /// Les neuf mots proposés, mélangés.
    let mots: [String]
    /// Une solution possible, montrée en correction.
    let solution: [String]
}

enum MotsEnEtoileGenerator {
    static let nombreDeBranches = 6

    /// Mots français de sept lettres, validés par le correcteur orthographique
    /// du système puis mis en majuscules sans accents.
    static let corpus: [String] = [
        "ABRICOT", "ABSENCE", "ABSTENU", "ACCORDE", "ACHETER", "ACOMPTE",
        "ACROBAT", "ADRESSE", "AFFAIRE", "AFFICHE", "AGRAFER", "AIGUISE",
        "AIMABLE", "AJOUTER", "ALERTER", "ALIMENT", "ALLUMER", "AMATEUR",
        "AMBIANT", "AMORCER", "ANALYSE", "ANGLAIS", "ANIMAUX", "ANNOTER",
        "ANODINE", "ANTENNE", "APAISER", "APLANIR", "APPARAT", "APPUYER",
        "ARBITRE", "ARCHIVE", "ARDOISE", "ARMOIRE", "ARTICLE", "ARTISAN",
        "ASPIRER", "ATELIER", "ATTACHE", "ATTIRER", "AUBAINE", "AUDIBLE",
        "AUTOMNE", "AVANCER", "BALANCE", "BALISER", "BALLADE", "BANDEAU",
        "BANQUET", "BAPTISE", "BARRAGE", "BASCULE", "BAVARDE", "BERCEAU",
        "BESOGNE", "BEURRER", "BIBERON", "BICYCLE", "BILLARD", "BISCUIT",
        "BIZARRE", "BLANCHE", "BLOQUER", "BOISSON", "BONHEUR", "BORDURE",
        "BOUCHON", "BOUCLER", "BOUILLI", "BOUQUET", "BRANCHE", "BRAQUER",
        "BRASIER", "BRICOLE", "BRIGADE", "BRIOCHE", "BRIQUET", "BRUMEUX",
        "BRUSQUE", "BRUYANT", "CABARET", "CABINET", "CADENAS", "CADENCE",
        "CAISSON", "CALIBRE", "CALMANT", "CAMPING", "CANDEUR", "CANICHE",
        "CANTINE", "CAPABLE", "CAPORAL", "CAPRICE", "CAPSULE", "CAPUCHE",
        "CARBONE", "CARESSE", "CAROTTE", "CARREAU", "CASCADE", "CASSURE",
        "CATHODE", "CAVERNE", "CELLIER", "CENSURE", "CERCEAU", "CERTAIN",
        "CHALEUR", "CHAMBRE", "CHAPEAU", "CHARBON", "CHARIOT", "CHARMER",
        "CHEMISE", "CHEVRON", "CHICANE", "CHIFFRE", "CHORALE", "CIGOGNE",
        "CIRCUIT", "CITERNE", "CITOYEN", "CLAIRON", "CLAMEUR", "CLAPIER",
        "CLAVIER", "CLIQUER", "CLOCHER", "CLOISON", "COINCER", "COLLINE",
        "COLOMBE", "COLONNE", "CONCERT", "CONFORT", "CONTACT", "CONTOUR",
        "COPEAUX", "CORBEAU", "CORDAGE", "COSTUME", "COULOIR", "COURAGE",
        "COURANT", "COUTEAU", "COUTURE", "CRACHER", "CRAMPON", "CRAQUER",
        "CRAVATE", "CREUSET", "CRISTAL", "CROCHET", "CROISER", "CROQUIS",
        "CUISINE", "CULOTTE", "CULTURE", "CYCLONE", "DAIGNER", "DALMATE",
        "DANSEUR", "DAUPHIN", "DIAMANT", "DILUANT", "DIRECTE", "DIRIGER",
        "DISCRET", "DOCTEUR", "DOMAINE", "DOMINER", "DOSSIER", "DOUCEUR",
        "DRAPEAU", "DRESSER", "DUPERIE", "DURABLE", "EFFACER", "EMMENER",
        "EMPILER", "ENDROIT", "ENFANCE", "ENGAGER", "ENLEVER", "ENNUYER",
        "ENVOYER", "ESSAYER", "ESSENCE", "ESTIMER", "ESTOMAC", "EXCITER",
        "EXCUSER", "EXISTER", "EXPERTE", "EXPIRER", "EXPLOIT", "EXPOSER",
        "FACETTE", "FACTEUR", "FAIBLIR", "FALAISE", "FAMILLE", "FARCEUR",
        "FATIGUE", "FAUCHER", "FERMENT", "FERMIER", "FERRURE", "FEUILLE",
        "FIANCER", "FICELLE", "FICHIER", "FIGURER", "FILTRER", "FINANCE",
        "FINESSE", "FLAMBER", "FLATTER", "FLEURIR", "FLOTTER", "FLUVIAL",
        "FONDANT", "FORFAIT", "FORMULE", "FORTUNE", "FOURNIR", "FRAGILE",
        "FRAICHE", "FRAPPER", "FREINER", "FRILEUX", "FRISSON", "FRITURE",
        "FROMAGE", "FRONTAL", "FROTTER", "FUGITIF", "FURETER", "FUSIBLE",
        "GAGNANT", "GALERIE", "GALOPER", "GAMELLE", "GARDIEN", "GAZETTE",
        "GERMAIN", "GESTION", "GICLEUR", "GLISSER", "GLOBULE", "GOUFFRE",
        "GOUSSET", "GOUTTES", "GRADUEL", "GRANITE", "GRATUIT", "GRAVEUR",
        "GRAVURE", "GREFFON", "GRENADE", "GRIMPER", "GRINCER", "GRISANT",
        "GROUPER", "GUETTER", "GUIDAGE", "GUITARE", "HABITER", "HACHOIR",
        "HALEINE", "HAUSSER", "HERBAGE", "HEURTER", "HOMMAGE", "HORAIRE",
        "HORIZON", "HORLOGE", "HOSPICE", "HOULEUX", "HUMAINE", "HYDRATE",
        "IGNORER", "IMMENSE", "IMPASSE", "IMPOSER", "INCONNU", "INDEXER",
        "INFLUER", "INITIER", "INNOVER", "INONDER", "INQUIET", "INSECTE",
        "INTENSE", "INVITER", "IVRESSE", "JAVELOT", "JETABLE", "JOINDRE",
        "JOUFFLU", "JOURNAL", "JOYEUSE", "JUBILER", "JUMELLE", "JUPETTE",
        "JURANDE", "JUSTICE", "JUTEUSE", "LACUNES", "LAITIER", "LAMBEAU",
        "LAMINER", "LAMPION", "LANGAGE", "LARGEUR", "LAURIER", "LAVERIE",
        "LECTEUR", "LENTEUR", "LESSIVE", "LEVRAUT", "LIAISON", "LICENCE",
        "LIMITER", "LIMPIDE", "LINTEAU", "LIQUIDE", "LISSEUR", "LOGIQUE",
        "LORGNER", "LOUANGE", "LUNETTE", "LUSTRER", "LUXUEUX", "MACHINE",
        "MAGASIN", "MAGIQUE", "MAIGRIR", "MAILLOT", "MAJEURE", "MALAISE",
        "MALICES", "MANETTE", "MARMITE", "MARQUER", "MARTEAU", "MARTYRE",
        "MASQUER", "MASSIFS", "MATELAS", "MATINAL", "MAUDIRE", "MAUVAIS",
        "MAXIMUM", "MENACER", "MENDIER", "MENTALE", "MESURER", "MIAULER",
        "MICROBE", "MIGRANT", "MILITER", "MILLIER", "MIMIQUE", "MINUTER",
        "MIRACLE", "MIRADOR", "MISSIVE", "MODELER", "MODESTE", "MOISSON",
        "MOLAIRE", "MONDIAL", "MONNAIE", "MONTRER", "MORCEAU", "MORDANT",
        "MOTIVER", "MOULAGE", "MOUSSER", "MOUVOIR", "MOYENNE", "MURMURE",
        "MUSCADE", "MUSICAL", "NATUREL", "NAVETTE", "NEIGEUX", "NERVURE",
        "NEUTRON", "NIVELER", "NOIRCIR", "NORMALE", "NOTABLE", "NOTAIRE",
        "NOURRIR", "NOUVEAU", "NUAGEUX", "NUANCER", "OBLIGER", "OBSCURE",
        "OBTENIR", "OCCUPER", "OCTOBRE", "ODORANT", "OMETTRE", "ONDULER",
        "OPINION", "OPPOSER", "OPTIMAL", "OPTIQUE", "ORAGEUX", "ORATEUR",
        "ORBITAL", "OREILLE", "OUBLIER", "OURAGAN", "OUVRAGE", "PALMIER",
        "PANNEAU", "PARADIS", "PARLANT", "PARQUET", "PATINER", "PAYSAGE",
        "PEIGNER", "PEINTRE", "PENDULE", "PERCALE", "PERDRIX", "PERFORE",
        "PICORER", "PIGMENT", "PIROGUE", "PISCINE", "PIVOTER", "PLACARD",
        "PLAFOND", "PLAISIR", "PLANEUR", "PLAQUER", "PLASTIC", "PLATEAU",
        "PLEURER", "PLISSER", "POIRIER", "POISSON", "POIVRON", "POLAIRE",
        "POMMADE", "POMPIER", "PORTAIL", "PORTION", "POTABLE", "POTERIE",
        "POURPRE", "PRENDRE", "PROUVER", "PRUNIER", "PUBLIER", "PUNAISE",
        "QUITTER", "RABOTER", "RACINES", "RAILLER", "RAMPANT", "RANCUNE",
        "RECONNU", "RECULER", "REJETER", "RELAXER", "RELEVER", "REMUANT",
        "RENOUER", "REPOSER", "REQUIEM", "RESPECT", "RESSORT", "RETENIR",
        "RETIRER", "REVENIR", "RIGOLER", "RISQUER", "ROGNURE", "ROMANCE",
        "ROSIERS", "ROUTINE", "RUGUEUX", "RYTHMER", "SABOTER", "SAGESSE",
        "SALAIRE", "SALARIE", "SATINER", "SAUVAGE", "SCELLER", "SCRUTIN",
        "SECOUER", "SECTEUR", "SEMAINE", "SEMELLE", "SEMENCE", "SENTIER",
        "SERRURE", "SILENCE", "SILLAGE", "SOIGNER", "SOLAIRE", "SOMBRER",
        "SOMMEIL", "SONDAGE", "SOURCIL", "SPORTIF", "STATION", "STOCKER",
        "STOPPER", "STUPEUR", "SUBTILE", "SUFFIRE", "SUIVEUR", "SURFACE",
        "SYLLABE", "SYMBOLE", "TABLEAU", "TAMBOUR", "TARIFER", "TASSEAU",
        "TAVERNE", "TEXTURE", "TIMBRER", "TITRAGE", "TORCHON", "TORNADE",
        "TORRENT", "TOUCHER", "TOURNER", "TOUSSER", "TRACEUR", "TRAINER",
        "TRAITER", "TREMPER", "TRESSER", "TRIPLER", "TROMPER", "TROUVER",
        "TRUELLE", "TURBINE", "TUTELLE", "TYPIQUE", "UNIFIER", "URGENCE",
        "VALIDER", "VANTAIL", "VEDETTE", "VEILLER", "VELOURS", "VERDURE",
        "VERSANT", "VIBRANT", "VOITURE", "VOULOIR",    ]

    /// Index des mots par initiale. Constante : Swift 6 refuse un état global
    /// mutable, et cet index ne change jamais.
    private static let parInitiale: [Character: [String]] =
        Dictionary(grouping: corpus, by: { $0.first! })

    /// Vrai si les mots forment un anneau valide : chaque mot commence par la
    /// lettre qui termine le précédent, et le dernier reboucle sur le premier.
    static func anneauValide(_ mots: [String]) -> Bool {
        guard mots.count == nombreDeBranches,
              Set(mots).count == nombreDeBranches else { return false }
        for index in mots.indices {
            let courant = mots[index]
            let suivant = mots[(index + 1) % mots.count]
            guard let fin = courant.last, let debut = suivant.first, fin == debut else {
                return false
            }
        }
        return true
    }

    /// La lettre partagée par deux mots voisins, si elle existe.
    static func jonction(_ gauche: String?, _ droite: String?) -> Character? {
        guard let gauche, let droite, let fin = gauche.last, let debut = droite.first,
              fin == debut else { return nil }
        return fin
    }

    /// Construit un anneau en limitant la répétition des initiales : sans cette
    /// contrainte, les verbes en -ER dominent et toutes les étoiles se
    /// ressemblent.
    static func construireAnneau(maxParInitiale: Int = 2) -> [String]? {
        for _ in 0..<4000 {
            guard let depart = corpus.randomElement() else { return nil }
            var chaine = [depart]
            var comptes: [Character: Int] = [depart.first!: 1]
            var abandon = false

            for _ in 1..<nombreDeBranches {
                let candidats = (parInitiale[chaine.last!.last!] ?? []).filter {
                    !chaine.contains($0) && (comptes[$0.first!] ?? 0) < maxParInitiale
                }
                guard let choix = candidats.randomElement() else { abandon = true; break }
                chaine.append(choix)
                comptes[choix.first!, default: 0] += 1
            }

            if !abandon, chaine.last!.last == chaine.first!.first {
                return chaine
            }
        }
        return nil
    }

    static func generate() -> EtoilePuzzle {
        for _ in 0..<50 {
            guard let anneau = construireAnneau() else { continue }
            // Trois mots supplémentaires pour brouiller les pistes
            let autres = corpus.filter { !anneau.contains($0) }.shuffled().prefix(3)
            guard autres.count == 3 else { continue }
            return EtoilePuzzle(mots: (anneau + autres).shuffled(), solution: anneau)
        }

        let repli = ["MIRACLE", "ESTOMAC", "CADENAS", "STOPPER", "RENOUER", "REQUIEM"]
        let autres = corpus.filter { !repli.contains($0) }.shuffled().prefix(3)
        return EtoilePuzzle(mots: (repli + autres).shuffled(), solution: repli)
    }
}

// MARK: - ViewModel

@MainActor
@Observable
final class MotsEnEtoileViewModel {
    var puzzle: EtoilePuzzle?
    /// Les six branches de l'étoile, dans l'ordre du tour.
    var branches: [String?] = Array(repeating: nil, count: MotsEnEtoileGenerator.nombreDeBranches)
    var motSelectionne: String?

    var currentQuestion: Int = 0
    var totalQuestions: Int = 10
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var timeRemaining: Int = 50
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var showResult: Bool = false
    var lastAnswerCorrect: Bool = false

    private var timerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    var accuracy: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }

    /// Les mots encore en réserve.
    var motsDisponibles: [String] {
        let places = Set(branches.compactMap { $0 })
        return puzzle?.mots.filter { !places.contains($0) } ?? []
    }

    var toutesBranchesRemplies: Bool {
        branches.allSatisfy { $0 != nil }
    }

    /// La lettre qui relie une branche à la suivante, si les deux mots
    /// s'accordent.
    func jonctionApres(_ index: Int) -> Character? {
        let suivant = (index + 1) % branches.count
        return MotsEnEtoileGenerator.jonction(branches[index], branches[suivant])
    }

    /// Vrai quand deux mots voisins sont posés mais ne se rejoignent pas.
    func conflitApres(_ index: Int) -> Bool {
        let suivant = (index + 1) % branches.count
        guard branches[index] != nil, branches[suivant] != nil else { return false }
        return jonctionApres(index) == nil
    }

    func startGame() {
        currentQuestion = 0
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        loadPuzzle()
    }

    private func loadPuzzle() {
        puzzle = MotsEnEtoileGenerator.generate()
        branches = Array(repeating: nil, count: MotsEnEtoileGenerator.nombreDeBranches)
        motSelectionne = nil
        showResult = false
        lastAnswerCorrect = false
        timeRemaining = 50
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 50) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            terminer(reussi: false)
        }
    }

    func selectionner(_ mot: String) {
        guard !showResult else { return }
        motSelectionne = (motSelectionne == mot) ? nil : mot
    }

    func placerEn(_ index: Int) {
        guard !showResult else { return }
        if let mot = motSelectionne {
            branches[index] = mot
            motSelectionne = nil
            HapticManager.light()
        } else if branches[index] != nil {
            // Toucher une branche occupée libère le mot
            branches[index] = nil
            HapticManager.light()
        }
    }

    func valider() {
        guard !showResult, toutesBranchesRemplies else { return }
        terminer(reussi: MotsEnEtoileGenerator.anneauValide(branches.compactMap { $0 }))
    }

    private func terminer(reussi: Bool) {
        guard !showResult else { return }
        timerTask?.cancel()
        showResult = true
        lastAnswerCorrect = reussi
        if reussi {
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
        return GameResult(gameType: .motsEnEtoile, score: Double(correctAnswers),
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

// MARK: - Vue

struct MotsEnEtoileView: View {
    @State private var viewModel = MotsEnEtoileViewModel()

    var body: some View {
        VStack(spacing: 14) {
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
        .navigationTitle("Mots en Étoile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    GameStatsView(type: .motsEnEtoile)
                } label: {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Mots en Étoile",
                    rules: [
                        RuleItem(icon: "textformat.abc", text: "9 mots de 7 lettres sont proposés"),
                        RuleItem(icon: "star", text: "Places-en 6 sur les branches de l'étoile"),
                        RuleItem(icon: "link", text: "Deux mots voisins partagent une lettre"),
                        RuleItem(icon: "arrow.triangle.2.circlepath", text: "La dernière lettre d'un mot est la première du suivant"),
                        RuleItem(icon: "arrow.uturn.left", text: "La 6ᵉ branche reboucle sur la 1ʳᵉ"),
                        RuleItem(icon: "timer", text: "50 secondes par étoile")
                    ],
                    accentColor: .yellow,
                    isGameActive: viewModel.isGameActive
                )
            }
        }
        .onDisappear { viewModel.stopGame() }
    }

    private var startView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "star.fill")
                .font(.system(size: 74))
                .foregroundStyle(.yellow)
            Text("Mots en Étoile").font(.largeTitle.weight(.bold))

            VStack(alignment: .leading, spacing: 8) {
                Label("9 mots de 7 lettres sont proposés", systemImage: "textformat.abc")
                Label("Places-en 6 sur les branches", systemImage: "star")
                Label("La dernière lettre d'un mot est la première du suivant", systemImage: "link")
                Label("La 6ᵉ branche reboucle sur la 1ʳᵉ", systemImage: "arrow.uturn.left")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(spacing: 3) {
                Text("Exemple").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                Text("MIRACL**E** → **E**STOMA**C** → **C**ADENAS")
                    .font(.caption.monospaced())
            }

            Text("10 étoiles, 50s chacune")
                .font(.callout)
                .foregroundStyle(.secondary)

            Button {
                viewModel.startGame()
            } label: {
                Text("Commencer")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }

    @ViewBuilder
    private var gameView: some View {
        if let puzzle = viewModel.puzzle {
            VStack(spacing: 10) {
                HStack {
                    Text("Étoile \(viewModel.currentQuestion + 1)/\(viewModel.totalQuestions)")
                        .font(.headline)
                    Spacer()
                    TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 50)
                }

                // L'anneau : six branches, chacune reliée à la suivante
                VStack(spacing: 0) {
                    ForEach(viewModel.branches.indices, id: \.self) { index in
                        brancheView(index)
                        jonctionView(index)
                    }
                }

                if !viewModel.motsDisponibles.isEmpty {
                    Text("Mots disponibles")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()),
                                        GridItem(.flexible())], spacing: 6) {
                        ForEach(viewModel.motsDisponibles, id: \.self) { mot in
                            Button {
                                viewModel.selectionner(mot)
                            } label: {
                                Text(mot)
                                    .font(.caption.monospaced().weight(.medium))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .background(viewModel.motSelectionne == mot
                                                ? Color.yellow.opacity(0.4) : Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .buttonStyle(.plain)
                            .disabled(viewModel.showResult)
                        }
                    }
                }

                if viewModel.showResult {
                    VStack(spacing: 4) {
                        Text(viewModel.lastAnswerCorrect ? "Étoile valide !" : "Raté")
                            .font(.headline)
                            .foregroundStyle(viewModel.lastAnswerCorrect ? .green : .red)
                        if !viewModel.lastAnswerCorrect {
                            Text("Une solution : " + puzzle.solution.joined(separator: " → "))
                                .font(.caption2.monospaced())
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                } else {
                    Button {
                        viewModel.valider()
                    } label: {
                        Text("Valider l'étoile")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(viewModel.toutesBranchesRemplies ? Color.yellow : Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .disabled(!viewModel.toutesBranchesRemplies)
                }

                Spacer(minLength: 0)
            }
        }
    }

    /// Une branche : le mot posé, ou un emplacement vide à remplir.
    private func brancheView(_ index: Int) -> some View {
        Button {
            viewModel.placerEn(index)
        } label: {
            HStack(spacing: 8) {
                Text("\(index + 1)")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.secondary)
                    .frame(width: 16)
                if let mot = viewModel.branches[index] {
                    Text(mot)
                        .font(.subheadline.monospaced().weight(.semibold))
                } else {
                    Text(viewModel.motSelectionne == nil ? "vide" : "poser ici")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(viewModel.branches[index] == nil
                          ? Color(.systemGray6) : Color.yellow.opacity(0.18))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(viewModel.motSelectionne != nil && viewModel.branches[index] == nil
                            ? Color.yellow : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .disabled(viewModel.showResult)
    }

    /// La lettre de liaison entre deux branches voisines.
    private func jonctionView(_ index: Int) -> some View {
        let lettre = viewModel.jonctionApres(index)
        let conflit = viewModel.conflitApres(index)
        let dernier = index == viewModel.branches.count - 1

        return HStack(spacing: 6) {
            Spacer().frame(width: 22)
            Image(systemName: dernier ? "arrow.turn.left.up" : "arrow.down")
                .font(.caption2)
                .foregroundStyle(.secondary)
            if let lettre {
                Text(String(lettre))
                    .font(.caption.monospaced().weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .background(Circle().fill(Color.green))
            } else if conflit {
                Image(systemName: "xmark")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .background(Circle().fill(Color.red))
            } else {
                Circle()
                    .strokeBorder(Color(.systemGray3), lineWidth: 1)
                    .frame(width: 20, height: 20)
            }
            if dernier {
                Text("retour à la branche 1")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .frame(height: 24)
    }

    private var gameOverView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: viewModel.accuracy >= 70 ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(viewModel.accuracy >= 70 ? .green : .red)
            Text("Terminé !").font(.largeTitle.weight(.bold))

            VStack(spacing: 12) {
                ResultRow(label: "Étoiles valides", value: "\(viewModel.correctAnswers)/\(viewModel.totalQuestions)")
                ResultRow(label: "Précision", value: String(format: "%.0f%%", viewModel.accuracy))
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        MotsEnEtoileView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
