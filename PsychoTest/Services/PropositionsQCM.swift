import Foundation

/// Construction des propositions d'un QCM numérique.
///
/// Une version précédente prenait les écarts dans l'ordre croissant en
/// s'arrêtant à quatre valeurs, ce qui produisait toujours les quatre entiers
/// consécutifs encadrant la solution : une fois les propositions triées, la
/// bonne réponse occupait invariablement le même rang. Il suffisait de choisir
/// la troisième plus petite pour répondre juste sans lire l'énoncé.
///
/// Ici le nombre de distracteurs placés sous la solution est tiré au hasard,
/// ce qui répartit son rang, et les écarts ne sont pas tous consécutifs.
enum PropositionsQCM {
    static func autour(de solution: Int, minimum: Int,
                       ecarts: [Int] = [1, 2, 3, 5]) -> [Int] {
        let dessous = ecarts.map { solution - $0 }.filter { $0 >= minimum }
        let dessus = ecarts.map { solution + $0 }

        // Combien de propositions seront plus petites que la solution
        let possiblesDessous = min(3, dessous.count)
        let nombreDessous = Int.random(in: 0...possiblesDessous)

        var valeurs: Set<Int> = [solution]
        for valeur in dessous.shuffled().prefix(nombreDessous) {
            valeurs.insert(valeur)
        }
        for valeur in dessus.shuffled() where valeurs.count < 4 {
            valeurs.insert(valeur)
        }
        // Filet de sécurité si les écarts n'ont pas suffi
        var supplement = (ecarts.max() ?? 5) + 1
        while valeurs.count < 4 {
            valeurs.insert(solution + supplement)
            supplement += 1
        }

        return Array(valeurs).shuffled()
    }
}
