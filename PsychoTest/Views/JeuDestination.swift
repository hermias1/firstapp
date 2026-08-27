import SwiftUI

/// L'écran d'un test, désigné par son type.
///
/// Le routage vit ici plutôt que dans le menu, pour que le parcours d'examen
/// puisse lancer les mêmes épreuves : sans cela, sa liste n'était qu'un
/// pense-bête et il fallait revenir au menu pour jouer.
struct JeuDestination: View {
    let type: GameType

    var body: some View {
        switch type {
        case .pairImpair: PairImpairView()
        case .m2Back: M2BackView()
        case .grillesCalculs: GrillesCalculsView()
        case .seriesLogiques: SeriesLogiquesView()
        case .anglaisQCM: AnglaisQCMView()
        case .anglaisComprehension: ComprehensionAnglaiseView()
        case .cultureAero: CultureAeroView()
        case .unMotSurDeux: UnMotSurDeuxView()
        case .formesEtCouleurs: FormesCouleursView()
        case .boitesAMots: BoitesAMotsView()
        case .motsEnEtoile: MotsEnEtoileView()
        case .nidAbeille: NidAbeilleView()
        case .calculMental: MentalCalculationView()
        case .billes: BillesView()
        case .formesGlissees: FormesGlisseesView()
        case .empilementsCubes: EmpilementsView()
        case .cubes2D3D: CubesPatronsView()
        case .objets3D: Objets3DView()
        case .airways: AirwaysView()
        case .psychomoteur: PsychomoteurView()
        }
    }
}
