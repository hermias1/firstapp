import Foundation

/// Sert en priorité le contenu que le joueur n'a jamais vu.
///
/// Un tirage au hasard dans toute la banque fait revenir les mêmes questions
/// bien avant d'avoir épuisé le stock : avec 190 questions tirées 30 par 30,
/// un candidat qui enchaîne les parties revoit une question sur cinq dès la
/// deuxième. On mémorise donc ce qui a déjà été servi, et on ne repart au
/// début qu'une fois le tour complet fait.
enum BanqueRotation {
    private static func cleStockage(_ cle: String) -> String { "banque.vus.\(cle)" }

    /// Tire `nombre` éléments en servant d'abord les inédits.
    ///
    /// - Parameter identifiant: ce qui distingue durablement un élément ; le
    ///   libellé de la question convient, l'index de tableau non, car il change
    ///   dès qu'on insère du contenu.
    static func tirer<T>(_ elements: [T], nombre: Int, cle: String,
                         identifiant: (T) -> String) -> [T] {
        guard !elements.isEmpty else { return [] }
        let defaults = UserDefaults.standard
        let dejaVus = Set(defaults.stringArray(forKey: cleStockage(cle)) ?? [])

        let inedits = elements.filter { !dejaVus.contains(identifiant($0)) }
        var tirage: [T]

        if inedits.count >= nombre {
            tirage = Array(inedits.shuffled().prefix(nombre))
            // On complète la liste des vus
            let vus = dejaVus.union(tirage.map(identifiant))
            defaults.set(Array(vus), forKey: cleStockage(cle))
        } else {
            // Le tour est bouclé : on sert les derniers inédits, on complète
            // avec du déjà-vu, et on repart d'une ardoise ne contenant que
            // ce tirage.
            let complement = elements
                .filter { dejaVus.contains(identifiant($0)) }
                .shuffled()
                .prefix(max(0, nombre - inedits.count))
            tirage = (inedits + complement).shuffled()
            defaults.set(tirage.map(identifiant), forKey: cleStockage(cle))
        }

        return tirage
    }

    /// Oublie ce qui a été vu pour une banque donnée.
    static func reinitialiser(_ cle: String) {
        UserDefaults.standard.removeObject(forKey: cleStockage(cle))
    }

    /// Nombre d'éléments déjà servis, pour information.
    static func nombreDeVus(_ cle: String) -> Int {
        UserDefaults.standard.stringArray(forKey: cleStockage(cle))?.count ?? 0
    }
}
