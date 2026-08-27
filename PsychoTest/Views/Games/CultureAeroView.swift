import SwiftUI

// MARK: - Model
struct AeroQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
}

// MARK: - Questions Database (246 questions)
extension AeroQuestion {
    static let allQuestions: [AeroQuestion] = [
        // PHYSIQUE DU VOL
        AeroQuestion(question: "Quelle est la vitesse du son au niveau de la mer (environ) ?", options: ["340 m/s", "300 m/s", "400 m/s", "250 m/s"], correctAnswer: "340 m/s"),
        AeroQuestion(question: "Qu'est-ce que le stall (décrochage) ?", options: ["Perte de portance", "Panne moteur", "Atterrissage forcé", "Turbulence"], correctAnswer: "Perte de portance"),
        AeroQuestion(question: "Qu'est-ce que le Mach ?", options: ["Rapport vitesse/vitesse du son", "Unité de pression", "Type de moteur", "Système de navigation"], correctAnswer: "Rapport vitesse/vitesse du son"),
        AeroQuestion(question: "La portance est générée par :", options: ["Les ailes", "Le moteur", "Le train d'atterrissage", "La queue"], correctAnswer: "Les ailes"),
        AeroQuestion(question: "La traînée est une force qui :", options: ["S'oppose au mouvement", "Pousse l'avion", "Fait monter l'avion", "Fait descendre l'avion"], correctAnswer: "S'oppose au mouvement"),
        AeroQuestion(question: "L'angle d'incidence est :", options: ["L'angle entre l'aile et le vent relatif", "L'angle de virage", "L'angle de montée", "L'angle de descente"], correctAnswer: "L'angle entre l'aile et le vent relatif"),
        AeroQuestion(question: "Le centre de gravité d'un avion doit être :", options: ["Dans certaines limites", "Le plus en avant possible", "Le plus en arrière possible", "Exactement au centre"], correctAnswer: "Dans certaines limites"),
        AeroQuestion(question: "Le facteur de charge est :", options: ["Le rapport portance/poids", "La masse de l'avion", "La vitesse maximale", "Le nombre de passagers"], correctAnswer: "Le rapport portance/poids"),
        AeroQuestion(question: "En virage, le facteur de charge :", options: ["Augmente", "Diminue", "Reste constant", "Devient négatif"], correctAnswer: "Augmente"),
        AeroQuestion(question: "À masse constante, la vitesse de décrochage indiquée augmente avec :", options: ["Le facteur de charge", "L'altitude", "La température extérieure", "Le cap suivi"], correctAnswer: "Le facteur de charge"),

        // AXES ET COMMANDES
        AeroQuestion(question: "Qu'est-ce que le roulis ?", options: ["Rotation autour de l'axe longitudinal", "Rotation autour de l'axe vertical", "Rotation autour de l'axe latéral", "Mouvement vers l'avant"], correctAnswer: "Rotation autour de l'axe longitudinal"),
        AeroQuestion(question: "Quelle est la fonction des ailerons ?", options: ["Contrôler le roulis", "Contrôler le lacet", "Contrôler le tangage", "Freiner l'avion"], correctAnswer: "Contrôler le roulis"),
        AeroQuestion(question: "Le gouvernail de direction contrôle :", options: ["Le lacet", "Le roulis", "Le tangage", "La vitesse"], correctAnswer: "Le lacet"),
        AeroQuestion(question: "Le gouvernail de profondeur contrôle :", options: ["Le tangage", "Le roulis", "Le lacet", "La vitesse"], correctAnswer: "Le tangage"),
        AeroQuestion(question: "Les volets servent à :", options: ["Augmenter la portance à basse vitesse", "Réduire la traînée", "Contrôler le roulis", "Freiner en vol"], correctAnswer: "Augmenter la portance à basse vitesse"),
        AeroQuestion(question: "Les spoilers servent à :", options: ["Réduire la portance et augmenter la traînée", "Augmenter la portance", "Contrôler le lacet", "Stabiliser l'avion"], correctAnswer: "Réduire la portance et augmenter la traînée"),
        AeroQuestion(question: "Le trim sert à :", options: ["Réduire l'effort sur les commandes", "Augmenter la vitesse", "Réduire la consommation", "Améliorer la visibilité"], correctAnswer: "Réduire l'effort sur les commandes"),
        AeroQuestion(question: "L'empennage horizontal assure :", options: ["La stabilité en tangage", "La stabilité en roulis", "La stabilité en lacet", "La propulsion"], correctAnswer: "La stabilité en tangage"),
        AeroQuestion(question: "L'empennage vertical assure :", options: ["La stabilité en lacet", "La stabilité en tangage", "La stabilité en roulis", "La portance"], correctAnswer: "La stabilité en lacet"),
        AeroQuestion(question: "Les slats sont situés :", options: ["Au bord d'attaque de l'aile", "Au bord de fuite de l'aile", "Sur la dérive", "Sur le fuselage"], correctAnswer: "Au bord d'attaque de l'aile"),

        // INSTRUMENTS
        AeroQuestion(question: "Quel instrument indique l'altitude ?", options: ["Altimètre", "Variomètre", "Anémomètre", "Horizon artificiel"], correctAnswer: "Altimètre"),
        AeroQuestion(question: "Que mesure un anémomètre ?", options: ["La vitesse", "L'altitude", "La température", "La pression"], correctAnswer: "La vitesse"),
        AeroQuestion(question: "Que mesure un variomètre ?", options: ["Vitesse verticale", "Vitesse horizontale", "Altitude", "Cap"], correctAnswer: "Vitesse verticale"),
        AeroQuestion(question: "L'horizon artificiel indique :", options: ["L'assiette et l'inclinaison", "L'altitude", "La vitesse", "Le cap"], correctAnswer: "L'assiette et l'inclinaison"),
        AeroQuestion(question: "Le conservateur de cap indique :", options: ["La direction de l'avion", "L'altitude", "La vitesse", "L'assiette"], correctAnswer: "La direction de l'avion"),
        AeroQuestion(question: "L'indicateur de virage montre :", options: ["Le taux de virage et la symétrie", "L'altitude", "La vitesse", "Le cap"], correctAnswer: "Le taux de virage et la symétrie"),
        AeroQuestion(question: "L'altimètre fonctionne grâce à :", options: ["La pression atmosphérique", "Un radar", "Un GPS", "Un gyroscope"], correctAnswer: "La pression atmosphérique"),
        AeroQuestion(question: "Un tube de Pitot capte :", options: ["La pression totale", "La pression statique", "La température", "Le cap"], correctAnswer: "La pression totale"),
        AeroQuestion(question: "Le transpondeur sert à :", options: ["Identifier l'avion au radar", "Mesurer l'altitude", "Communiquer avec la tour", "Naviguer"], correctAnswer: "Identifier l'avion au radar"),
        AeroQuestion(question: "L'EFIS signifie :", options: ["Electronic Flight Instrument System", "Engine Fuel Indicator System", "Emergency Flight Information", "External Flight Input System"], correctAnswer: "Electronic Flight Instrument System"),

        // NAVIGATION
        AeroQuestion(question: "Que signifie VOR ?", options: ["VHF Omnidirectional Range", "Visual Operational Radar", "Vertical Orientation Reference", "Variable Output Receiver"], correctAnswer: "VHF Omnidirectional Range"),
        AeroQuestion(question: "Combien de milles nautiques dans un degré de latitude ?", options: ["60", "100", "30", "90"], correctAnswer: "60"),
        AeroQuestion(question: "Un mille nautique équivaut à :", options: ["1852 mètres", "1609 mètres", "1000 mètres", "2000 mètres"], correctAnswer: "1852 mètres"),
        AeroQuestion(question: "L'ILS permet :", options: ["Une approche de précision", "De mesurer la vitesse", "De communiquer", "De détecter les orages"], correctAnswer: "Une approche de précision"),
        AeroQuestion(question: "Le DME mesure :", options: ["La distance à une station", "L'altitude", "La vitesse sol", "Le cap"], correctAnswer: "La distance à une station"),
        AeroQuestion(question: "Le NDB est une balise :", options: ["Non directionnelle", "Directionnelle", "Satellite", "Radar"], correctAnswer: "Non directionnelle"),
        AeroQuestion(question: "Le GPS utilise :", options: ["Des satellites", "Des balises au sol", "Des radars", "Des ondes radio terrestres"], correctAnswer: "Des satellites"),
        AeroQuestion(question: "La route orthodromique est :", options: ["Le plus court chemin", "La route magnétique", "Une route circulaire", "Une route constante"], correctAnswer: "Le plus court chemin"),
        AeroQuestion(question: "La déclinaison magnétique est :", options: ["L'angle entre Nord vrai et Nord magnétique", "L'inclinaison de la Terre", "L'angle de montée", "La dérive"], correctAnswer: "L'angle entre Nord vrai et Nord magnétique"),
        AeroQuestion(question: "Le RNAV permet :", options: ["Une navigation point à point", "De mesurer l'altitude", "De communiquer", "De détecter le terrain"], correctAnswer: "Une navigation point à point"),

        // MÉTÉOROLOGIE
        AeroQuestion(question: "Que signifie METAR ?", options: ["Message d'observation météo", "Mesure de température", "Module d'étalonnage radar", "Méthode d'approche terrain"], correctAnswer: "Message d'observation météo"),
        AeroQuestion(question: "Quelle est la pression atmosphérique standard au niveau de la mer ?", options: ["1013.25 hPa", "1000 hPa", "1025 hPa", "980 hPa"], correctAnswer: "1013.25 hPa"),
        AeroQuestion(question: "Le TAF est :", options: ["Une prévision météo aéronautique", "Un type d'approche", "Un code de transpondeur", "Une fréquence radio"], correctAnswer: "Une prévision météo aéronautique"),
        AeroQuestion(question: "Les cumulonimbus sont dangereux car ils :", options: ["Contiennent des turbulences et de la grêle", "Sont très hauts", "Sont difficiles à voir", "Contiennent de la neige"], correctAnswer: "Contiennent des turbulences et de la grêle"),
        AeroQuestion(question: "Le windshear est :", options: ["Un changement brutal de vent", "Un vent constant", "Un vent arrière", "Un vent de face"], correctAnswer: "Un changement brutal de vent"),
        AeroQuestion(question: "Le givrage se produit quand :", options: ["La température est proche de 0°C avec humidité", "Il fait très froid", "Il fait très chaud", "L'altitude est élevée"], correctAnswer: "La température est proche de 0°C avec humidité"),
        AeroQuestion(question: "CAVOK signifie :", options: ["Cloud And Visibility OK", "Ceiling And Vertical OK", "Clear Aviation OK", "Conditions Always Valid OK"], correctAnswer: "Cloud And Visibility OK"),
        AeroQuestion(question: "La visibilité se mesure en :", options: ["Mètres ou kilomètres", "Pieds", "Milles nautiques", "Degrés"], correctAnswer: "Mètres ou kilomètres"),
        AeroQuestion(question: "Un front froid apporte généralement :", options: ["Des orages et averses", "Du beau temps", "Du brouillard", "Des vents calmes"], correctAnswer: "Des orages et averses"),
        AeroQuestion(question: "Le brouillard d'advection se forme :", options: ["Quand l'air chaud passe sur une surface froide", "La nuit", "En montagne", "Au-dessus de l'eau"], correctAnswer: "Quand l'air chaud passe sur une surface froide"),

        // RÉGLEMENTATION
        AeroQuestion(question: "Que signifie IFR ?", options: ["Instrument Flight Rules", "International Flight Regulations", "Internal Fuel Reserve", "Indicated Flight Rate"], correctAnswer: "Instrument Flight Rules"),
        AeroQuestion(question: "Que signifie VFR ?", options: ["Visual Flight Rules", "Variable Fuel Reserve", "Vertical Flight Regulations", "Verified Flight Route"], correctAnswer: "Visual Flight Rules"),
        AeroQuestion(question: "Quelle fréquence est utilisée pour les appels de détresse ?", options: ["121.5 MHz", "118.0 MHz", "125.0 MHz", "130.0 MHz"], correctAnswer: "121.5 MHz"),
        AeroQuestion(question: "Le niveau de vol FL100 correspond à :", options: ["10 000 pieds", "1 000 pieds", "100 000 pieds", "100 mètres"], correctAnswer: "10 000 pieds"),
        AeroQuestion(question: "Le calage QNH donne :", options: ["L'altitude par rapport au niveau de la mer", "L'altitude par rapport au sol", "L'altitude par rapport à 1013 hPa", "La hauteur de l'avion"], correctAnswer: "L'altitude par rapport au niveau de la mer"),
        AeroQuestion(question: "Le calage QFE donne :", options: ["La hauteur par rapport au terrain", "L'altitude MSL", "Le niveau de vol", "La pression standard"], correctAnswer: "La hauteur par rapport au terrain"),
        AeroQuestion(question: "Au-dessus de l'altitude de transition, on utilise :", options: ["Le calage standard 1013.25 hPa", "Le QNH", "Le QFE", "Le QFF"], correctAnswer: "Le calage standard 1013.25 hPa"),
        AeroQuestion(question: "L'OACI est :", options: ["L'Organisation de l'Aviation Civile Internationale", "Un type d'aéroport", "Un code météo", "Un système de navigation"], correctAnswer: "L'Organisation de l'Aviation Civile Internationale"),
        AeroQuestion(question: "Un NOTAM est :", options: ["Un avis aux navigants", "Un type d'avion", "Une procédure d'approche", "Un code transpondeur"], correctAnswer: "Un avis aux navigants"),
        AeroQuestion(question: "Le squawk 7700 indique :", options: ["Une urgence", "Une panne radio", "Un détournement", "Un vol normal"], correctAnswer: "Une urgence"),

        // AÉROPORTS ET CODES
        AeroQuestion(question: "Quel est le code OACI de Paris CDG ?", options: ["LFPG", "EGLL", "KJFK", "EHAM"], correctAnswer: "LFPG"),
        AeroQuestion(question: "Quel est le code OACI de Londres Heathrow ?", options: ["EGLL", "LFPG", "KJFK", "EDDF"], correctAnswer: "EGLL"),
        AeroQuestion(question: "Les codes OACI commençant par 'LF' désignent :", options: ["La France", "L'Allemagne", "L'Italie", "L'Espagne"], correctAnswer: "La France"),
        AeroQuestion(question: "Les codes OACI commençant par 'K' désignent :", options: ["Les États-Unis", "Le Royaume-Uni", "Le Canada", "L'Australie"], correctAnswer: "Les États-Unis"),
        AeroQuestion(question: "Le code IATA de Paris CDG est :", options: ["CDG", "PAR", "ORY", "LYS"], correctAnswer: "CDG"),
        AeroQuestion(question: "Une piste 27 est orientée vers :", options: ["L'ouest (270°)", "L'est", "Le nord", "Le sud"], correctAnswer: "L'ouest (270°)"),
        AeroQuestion(question: "TWR signifie :", options: ["Tower (Tour de contrôle)", "Taxiway", "Terminal", "Traffic"], correctAnswer: "Tower (Tour de contrôle)"),
        AeroQuestion(question: "GND signifie :", options: ["Ground (Sol)", "General", "Guide", "Gate"], correctAnswer: "Ground (Sol)"),
        AeroQuestion(question: "APP signifie :", options: ["Approach (Approche)", "Airport", "Apron", "Arrival"], correctAnswer: "Approach (Approche)"),
        AeroQuestion(question: "ATIS fournit :", options: ["Les informations automatiques de l'aéroport", "Le plan de vol", "Les autorisations", "Le carburant"], correctAnswer: "Les informations automatiques de l'aéroport"),

        // AVIONS ET CONSTRUCTEURS
        AeroQuestion(question: "Combien de moteurs possède un A320 ?", options: ["2", "3", "4", "1"], correctAnswer: "2"),
        AeroQuestion(question: "Quel avion est surnommé 'Jumbo Jet' ?", options: ["Boeing 747", "Airbus A380", "Boeing 777", "Airbus A350"], correctAnswer: "Boeing 747"),
        AeroQuestion(question: "Quel est le constructeur de l'A350 ?", options: ["Airbus", "Boeing", "Embraer", "Bombardier"], correctAnswer: "Airbus"),
        AeroQuestion(question: "Combien de litres de kérosène un A380 peut-il transporter ?", options: ["~320 000 L", "~100 000 L", "~500 000 L", "~50 000 L"], correctAnswer: "~320 000 L"),
        AeroQuestion(question: "Le Boeing 787 est surnommé :", options: ["Dreamliner", "Jumbo", "Super", "Max"], correctAnswer: "Dreamliner"),
        AeroQuestion(question: "L'A380 est un avion à :", options: ["2 ponts", "1 pont", "3 ponts", "4 ponts"], correctAnswer: "2 ponts"),
        AeroQuestion(question: "Le Concorde était un avion :", options: ["Supersonique", "Subsonique", "Hypersonique", "Turbopropulseur"], correctAnswer: "Supersonique"),
        AeroQuestion(question: "Embraer est un constructeur :", options: ["Brésilien", "Américain", "Européen", "Canadien"], correctAnswer: "Brésilien"),
        AeroQuestion(question: "ATR est un constructeur d'avions :", options: ["Turbopropulseurs", "Supersoniques", "Gros porteurs", "Jets d'affaires"], correctAnswer: "Turbopropulseurs"),
        AeroQuestion(question: "Le premier vol motorisé des frères Wright date de :", options: ["1903", "1890", "1920", "1910"], correctAnswer: "1903"),

        // MOTEURS ET SYSTÈMES
        AeroQuestion(question: "Que signifie APU ?", options: ["Auxiliary Power Unit", "Automatic Pilot Unit", "Air Pressure Unit", "Altitude Processing Unit"], correctAnswer: "Auxiliary Power Unit"),
        AeroQuestion(question: "Que signifie TCAS ?", options: ["Traffic Collision Avoidance System", "Technical Control Aviation System", "Thermal Cabin Air System", "Total Control Autopilot System"], correctAnswer: "Traffic Collision Avoidance System"),
        AeroQuestion(question: "Le GPWS sert à :", options: ["Alerter de la proximité du sol", "Mesurer la vitesse", "Naviguer", "Communiquer"], correctAnswer: "Alerter de la proximité du sol"),
        AeroQuestion(question: "L'APU fournit :", options: ["Électricité et air comprimé au sol", "La poussée", "Le carburant", "L'oxygène"], correctAnswer: "Électricité et air comprimé au sol"),
        AeroQuestion(question: "Les turboréacteurs fonctionnent selon le principe :", options: ["Action-réaction", "Archimède", "Pascal", "Bernoulli uniquement"], correctAnswer: "Action-réaction"),
        AeroQuestion(question: "Le bypass ratio d'un moteur est :", options: ["Le rapport flux froid/flux chaud", "La température", "La pression", "La vitesse"], correctAnswer: "Le rapport flux froid/flux chaud"),
        AeroQuestion(question: "L'auto-manette (autothrottle) gère :", options: ["La poussée des moteurs", "Le train d'atterrissage", "Les volets", "Les freins"], correctAnswer: "La poussée des moteurs"),
        AeroQuestion(question: "Le FMS signifie :", options: ["Flight Management System", "Fuel Monitoring System", "Flight Mode Selector", "Forward Motion System"], correctAnswer: "Flight Management System"),
        AeroQuestion(question: "L'ELT sert à :", options: ["Émettre un signal de détresse", "Éclairer la cabine", "Mesurer l'altitude", "Contrôler les moteurs"], correctAnswer: "Émettre un signal de détresse"),
        AeroQuestion(question: "Le RAT est :", options: ["Une turbine de secours", "Un radar", "Un type d'antenne", "Un réservoir"], correctAnswer: "Une turbine de secours"),

        // ATMOSPHÈRE ET ALTITUDE
        AeroQuestion(question: "Quelle est l'altitude de croisière typique d'un avion de ligne ?", options: ["35 000 pieds", "15 000 pieds", "50 000 pieds", "5 000 pieds"], correctAnswer: "35 000 pieds"),
        AeroQuestion(question: "À quelle altitude commence la stratosphère ?", options: ["~11 km", "~5 km", "~20 km", "~30 km"], correctAnswer: "~11 km"),
        AeroQuestion(question: "Combien y a-t-il de pieds dans un mètre (environ) ?", options: ["3.28", "2.54", "1.85", "4.12"], correctAnswer: "3.28"),
        AeroQuestion(question: "La température diminue avec l'altitude de :", options: ["~2°C par 1000 pieds", "~5°C par 1000 pieds", "~1°C par 1000 pieds", "~10°C par 1000 pieds"], correctAnswer: "~2°C par 1000 pieds"),
        AeroQuestion(question: "La troposphère est :", options: ["La couche où se produisent les phénomènes météo", "La couche d'ozone", "La couche la plus haute", "Une couche sans air"], correctAnswer: "La couche où se produisent les phénomènes météo"),
        AeroQuestion(question: "L'atmosphère standard ISA a une température au sol de :", options: ["15°C", "0°C", "20°C", "25°C"], correctAnswer: "15°C"),
        AeroQuestion(question: "La tropopause est :", options: ["La limite entre troposphère et stratosphère", "Une couche de nuages", "Le niveau de vol maximum", "Une zone de turbulence"], correctAnswer: "La limite entre troposphère et stratosphère"),
        AeroQuestion(question: "L'altitude densité augmente quand :", options: ["La température augmente", "La pression augmente", "L'altitude diminue", "L'humidité diminue"], correctAnswer: "La température augmente"),
        AeroQuestion(question: "En atmosphère chaude, les performances :", options: ["Diminuent", "Augmentent", "Restent identiques", "S'améliorent au décollage"], correctAnswer: "Diminuent"),

        // PROCÉDURES ET OPÉRATIONS
        AeroQuestion(question: "Le pushback est :", options: ["Le repoussage de l'avion", "Le décollage", "L'atterrissage", "Le ravitaillement"], correctAnswer: "Le repoussage de l'avion"),
        AeroQuestion(question: "Une approche ILS cat III permet :", options: ["Un atterrissage par très faible visibilité", "Un décollage de nuit", "Un atterrissage manuel", "Un atterrissage par beau temps"], correctAnswer: "Un atterrissage par très faible visibilité"),
        AeroQuestion(question: "Le go-around est :", options: ["Une remise des gaz", "Un décollage", "Un virage", "Un atterrissage"], correctAnswer: "Une remise des gaz"),
        AeroQuestion(question: "V1 est :", options: ["La vitesse de décision au décollage", "La vitesse de rotation", "La vitesse d'envol", "La vitesse de croisière"], correctAnswer: "La vitesse de décision au décollage"),
        AeroQuestion(question: "Vr est :", options: ["La vitesse de rotation", "La vitesse de décision", "La vitesse d'envol", "La vitesse maximale"], correctAnswer: "La vitesse de rotation"),
        AeroQuestion(question: "V2 est :", options: ["La vitesse de montée après décollage", "La vitesse de rotation", "La vitesse de décision", "La vitesse d'approche"], correctAnswer: "La vitesse de montée après décollage"),
        AeroQuestion(question: "Le briefing avant vol sert à :", options: ["Préparer le vol et anticiper les problèmes", "Vérifier le carburant", "Nettoyer l'avion", "Saluer les passagers"], correctAnswer: "Préparer le vol et anticiper les problèmes"),
        AeroQuestion(question: "Le CRM (Crew Resource Management) concerne :", options: ["La gestion de l'équipage", "Le carburant", "La maintenance", "Les passagers"], correctAnswer: "La gestion de l'équipage"),
        AeroQuestion(question: "Un ETOPS est une certification pour :", options: ["Les vols longs bimoteurs", "Les vols courts", "Les vols cargo", "Les vols VFR"], correctAnswer: "Les vols longs bimoteurs"),
        AeroQuestion(question: "Le MEL est :", options: ["La liste des équipements minimum", "Un type de carburant", "Une procédure d'approche", "Un code de communication"], correctAnswer: "La liste des équipements minimum"),

        // COMMUNICATIONS
        AeroQuestion(question: "Roger signifie :", options: ["Message reçu et compris", "Affirmatif", "Négatif", "Répétez"], correctAnswer: "Message reçu et compris"),
        AeroQuestion(question: "Wilco signifie :", options: ["Will comply (je vais me conformer)", "Message reçu", "Répétez", "Négatif"], correctAnswer: "Will comply (je vais me conformer)"),
        AeroQuestion(question: "Affirm signifie :", options: ["Oui", "Non", "Répétez", "Message reçu"], correctAnswer: "Oui"),
        AeroQuestion(question: "Negative signifie :", options: ["Non", "Oui", "Répétez", "Attendez"], correctAnswer: "Non"),
        AeroQuestion(question: "Say again signifie :", options: ["Répétez", "Confirmez", "Annulez", "Attendez"], correctAnswer: "Répétez"),
        AeroQuestion(question: "Standby signifie :", options: ["Attendez", "Partez", "Répétez", "Confirmez"], correctAnswer: "Attendez"),
        AeroQuestion(question: "Le squawk 7500 indique :", options: ["Un détournement", "Une urgence", "Une panne radio", "Un vol normal"], correctAnswer: "Un détournement"),
        AeroQuestion(question: "Le squawk 7600 indique :", options: ["Une panne radio", "Un détournement", "Une urgence", "Un vol normal"], correctAnswer: "Une panne radio"),
        AeroQuestion(question: "Pan Pan indique :", options: ["Une urgence sans danger immédiat", "Une détresse absolue", "Un vol normal", "Une fin de communication"], correctAnswer: "Une urgence sans danger immédiat"),
        AeroQuestion(question: "L'alphabet phonétique commence par :", options: ["Alpha, Bravo, Charlie", "Able, Baker, Charlie", "Adam, Boy, Charles", "Apple, Banana, Cherry"], correctAnswer: "Alpha, Bravo, Charlie"),

        // HISTOIRE DE L'AVIATION
        AeroQuestion(question: "Charles Lindbergh a traversé l'Atlantique en :", options: ["1927", "1903", "1945", "1918"], correctAnswer: "1927"),
        AeroQuestion(question: "Le premier avion à réaction commercial fut :", options: ["De Havilland Comet", "Boeing 707", "Douglas DC-8", "Concorde"], correctAnswer: "De Havilland Comet"),
        AeroQuestion(question: "Le mur du son a été franchi pour la première fois en :", options: ["1947", "1939", "1955", "1960"], correctAnswer: "1947"),
        AeroQuestion(question: "L'avion qui a franchi le mur du son s'appelait :", options: ["Bell X-1", "Concorde", "Boeing 747", "Spirit of St. Louis"], correctAnswer: "Bell X-1"),
        AeroQuestion(question: "Le premier vol du Concorde date de :", options: ["1969", "1976", "1960", "1985"], correctAnswer: "1969"),
        AeroQuestion(question: "Le premier vol de l'A380 date de :", options: ["2005", "2000", "2010", "1998"], correctAnswer: "2005"),
        AeroQuestion(question: "Louis Blériot a traversé la Manche en :", options: ["1909", "1903", "1920", "1915"], correctAnswer: "1909"),
        AeroQuestion(question: "Antoine de Saint-Exupéry était :", options: ["Pilote et écrivain", "Ingénieur", "Mécanicien", "Contrôleur aérien"], correctAnswer: "Pilote et écrivain"),
        AeroQuestion(question: "L'Aéropostale transportait principalement :", options: ["Du courrier", "Des passagers", "Du fret", "Des militaires"], correctAnswer: "Du courrier"),
        AeroQuestion(question: "Jean Mermoz est célèbre pour :", options: ["Ses traversées de l'Atlantique Sud", "Le premier vol motorisé", "La traversée de la Manche", "Le mur du son"], correctAnswer: "Ses traversées de l'Atlantique Sud"),

        // QUESTIONS DIVERSES
        AeroQuestion(question: "Le carburant des avions de ligne est :", options: ["Du kérosène (Jet A1)", "De l'essence", "Du diesel", "Du GPL"], correctAnswer: "Du kérosène (Jet A1)"),
        AeroQuestion(question: "Un nœud (kt) équivaut à :", options: ["1 mille nautique par heure", "1 km/h", "1 mph", "1 m/s"], correctAnswer: "1 mille nautique par heure"),
        AeroQuestion(question: "La boîte noire est généralement :", options: ["Orange", "Noire", "Rouge", "Blanche"], correctAnswer: "Orange"),
        AeroQuestion(question: "Le CVR enregistre :", options: ["Les conversations du cockpit", "Les paramètres de vol", "La vidéo", "Le carburant"], correctAnswer: "Les conversations du cockpit"),
        AeroQuestion(question: "Le FDR enregistre :", options: ["Les paramètres de vol", "Les conversations", "La vidéo", "La météo"], correctAnswer: "Les paramètres de vol"),
        AeroQuestion(question: "La pressurisation de la cabine maintient une altitude :", options: ["~8000 pieds", "~0 pied", "~20000 pieds", "~35000 pieds"], correctAnswer: "~8000 pieds"),
        AeroQuestion(question: "Le masque à oxygène tombe automatiquement quand :", options: ["La pression cabine chute", "Il y a un incendie", "L'avion atterrit", "Le pilote le décide"], correctAnswer: "La pression cabine chute"),
        AeroQuestion(question: "Un vol long-courrier dépasse généralement :", options: ["6 heures", "2 heures", "1 heure", "30 minutes"], correctAnswer: "6 heures"),
        AeroQuestion(question: "Le hub d'Air France est :", options: ["Paris CDG", "Paris Orly", "Lyon", "Nice"], correctAnswer: "Paris CDG"),
        AeroQuestion(question: "Les winglets servent à :", options: ["Réduire la traînée induite", "Augmenter la portance", "Améliorer le roulis", "Freiner l'avion"], correctAnswer: "Réduire la traînée induite"),

        // MARK: Questions ajoutées après contrôle factuel
        AeroQuestion(question: "Dans l'atmosphère standard internationale (ISA), quelle est la pression au niveau moyen de la mer ?", options: ["1013,25 hPa", "1000,00 hPa", "1023,50 hPa", "950,00 hPa"], correctAnswer: "1013,25 hPa"),
        AeroQuestion(question: "Dans l'atmosphère standard internationale (ISA), quelle est la température au niveau moyen de la mer ?", options: ["+15 °C", "0 °C", "+20 °C", "+10 °C"], correctAnswer: "+15 °C"),
        AeroQuestion(question: "Quel est le gradient thermique vertical de l'atmosphère standard dans la troposphère ?", options: ["6,5 °C par 1000 m", "3,0 °C par 1000 m", "1,0 °C par 1000 m", "10,0 °C par 1000 m"], correctAnswer: "6,5 °C par 1000 m"),
        AeroQuestion(question: "En atmosphère standard, quelle température règne à 10 000 ft ?", options: ["−5 °C", "+5 °C", "−15 °C", "−20 °C"], correctAnswer: "−5 °C"),
        AeroQuestion(question: "Dans l'atmosphère standard, à quelle altitude se situe la tropopause ?", options: ["Environ 11 km (36 000 ft)", "Environ 5 km (16 000 ft)", "Environ 20 km (65 000 ft)", "Environ 30 km (100 000 ft)"], correctAnswer: "Environ 11 km (36 000 ft)"),
        AeroQuestion(question: "Dans l'atmosphère standard, comment évolue la température au-dessus de la tropopause, entre 11 et 20 km ?", options: ["Elle reste constante à environ −56,5 °C", "Elle continue de décroître au même rythme que dans la troposphère", "Elle augmente de 2 °C par 1000 ft", "Elle chute brutalement au-dessous de −100 °C"], correctAnswer: "Elle reste constante à environ −56,5 °C"),
        AeroQuestion(question: "Que désigne le QNH ?", options: ["La pression de l'aérodrome ramenée au niveau moyen de la mer selon l'atmosphère standard", "La pression atmosphérique mesurée au niveau du terrain lui-même", "La valeur fixe de 1013,25 hPa utilisée en croisière", "La pression régnant au niveau de vol de croisière"], correctAnswer: "La pression de l'aérodrome ramenée au niveau moyen de la mer selon l'atmosphère standard"),
        AeroQuestion(question: "Que lit un pilote sur son altimètre calé au QFE de l'aérodrome ?", options: ["La hauteur au-dessus de l'aérodrome (zéro au sol sur le terrain)", "L'altitude au-dessus du niveau moyen de la mer", "Le niveau de vol", "L'altitude-densité du terrain"], correctAnswer: "La hauteur au-dessus de l'aérodrome (zéro au sol sur le terrain)"),
        AeroQuestion(question: "Lorsque l'altimètre est calé sur 1013,25 hPa, que représente son indication ?", options: ["Un niveau de vol", "L'altitude vraie au-dessus du niveau de la mer", "La hauteur au-dessus du relief survolé", "L'altitude-densité"], correctAnswer: "Un niveau de vol"),
        AeroQuestion(question: "En montée, lorsqu'un avion franchit l'altitude de transition, quel calage le pilote affiche-t-il ?", options: ["1013,25 hPa (calage standard)", "Le QNH du terrain de destination", "Le QFE du terrain de départ", "Le QNH régional le plus bas de la zone"], correctAnswer: "1013,25 hPa (calage standard)"),
        AeroQuestion(question: "Un avion vole d'une zone de haute pression vers une zone de basse pression sans actualiser son calage QNH. Que peut-on dire de sa position réelle ?", options: ["Il se trouve plus bas que l'altitude affichée par l'altimètre", "Il se trouve plus haut que l'altitude affichée par l'altimètre", "L'altitude affichée reste exacte, l'altimètre se corrigeant automatiquement", "L'erreur n'apparaît qu'au-dessus du niveau de transition"], correctAnswer: "Il se trouve plus bas que l'altitude affichée par l'altimètre"),
        AeroQuestion(question: "Près du niveau de la mer, à quelle variation d'altitude correspond approximativement une variation de pression de 1 hPa ?", options: ["Environ 28 ft", "Environ 8 ft", "Environ 100 ft", "Environ 300 ft"], correctAnswer: "Environ 28 ft"),
        AeroQuestion(question: "Quel genre de nuage est associé aux orages ?", options: ["Le cumulonimbus", "Le nimbostratus", "L'altocumulus", "Le cirrostratus"], correctAnswer: "Le cumulonimbus"),
        AeroQuestion(question: "De quoi les cirrus sont-ils constitués ?", options: ["De cristaux de glace", "De gouttelettes d'eau surfondue", "De gouttes de pluie en formation", "De grêlons en suspension"], correctAnswer: "De cristaux de glace"),
        AeroQuestion(question: "Quel nuage est typiquement associé à des précipitations continues et étendues ?", options: ["Le nimbostratus", "Le cumulus humilis", "Le cirrocumulus", "L'altocumulus lenticularis"], correctAnswer: "Le nimbostratus"),
        AeroQuestion(question: "Dans un METAR, que signifie l'abréviation OVC ?", options: ["Ciel couvert, 8 octas de nuages", "Ciel fragmenté, 5 à 7 octas de nuages", "Ciel épars, 3 à 4 octas de nuages", "Ciel peu nuageux, 1 à 2 octas de nuages"], correctAnswer: "Ciel couvert, 8 octas de nuages"),
        AeroQuestion(question: "Dans un METAR, comment interprète-t-on le groupe BKN040 ?", options: ["Nuages fragmentés (5 à 7 octas) à 4 000 ft au-dessus de l'aérodrome", "Nuages fragmentés (5 à 7 octas) à 40 ft au-dessus de l'aérodrome", "Ciel couvert (8 octas) à 4 000 ft au-dessus de l'aérodrome", "Nuages fragmentés (5 à 7 octas) à 4 000 m au-dessus de l'aérodrome"], correctAnswer: "Nuages fragmentés (5 à 7 octas) à 4 000 ft au-dessus de l'aérodrome"),
        AeroQuestion(question: "Dans quelles conditions le givrage se forme-t-il sur la cellule d'un avion en vol ?", options: ["Lorsqu'il traverse des gouttelettes d'eau surfondue, liquides malgré une température négative", "Lorsqu'il traverse un nuage de cristaux de glace secs", "Lorsqu'il traverse de l'air très froid et parfaitement sec", "Lorsqu'il traverse un nuage dont la température dépasse +10 °C"], correctAnswer: "Lorsqu'il traverse des gouttelettes d'eau surfondue, liquides malgré une température négative"),
        AeroQuestion(question: "Comment définit-on le cisaillement de vent (wind shear) ?", options: ["Une variation soudaine de la direction et/ou de la vitesse du vent sur une faible distance", "Un vent régulier supérieur à 40 kt en altitude", "La différence entre le vent au sol et le vent prévu par le TAF", "La composante du vent perpendiculaire à l'axe de piste"], correctAnswer: "Une variation soudaine de la direction et/ou de la vitesse du vent sur une faible distance"),
        AeroQuestion(question: "Qu'est-ce qu'une microrafale (microburst) ?", options: ["Un puissant courant descendant localisé sous un cumulonimbus, divergeant violemment au sol", "Une rafale de vent de surface mesurée sur moins de trois secondes", "Une turbulence de sillage laissée par un avion lourd", "Un tourbillon de poussière se formant par temps calme et chaud"], correctAnswer: "Un puissant courant descendant localisé sous un cumulonimbus, divergeant violemment au sol"),
        AeroQuestion(question: "Où rencontre-t-on principalement la turbulence en air clair (CAT) ?", options: ["À haute altitude, au voisinage des courants-jets", "Sous la base des cumulonimbus", "Dans les basses couches, au-dessous de 3 000 ft par vent fort", "Au-dessus des étendues maritimes froides"], correctAnswer: "À haute altitude, au voisinage des courants-jets"),
        AeroQuestion(question: "À partir de quelle visibilité horizontale parle-t-on de brouillard ?", options: ["Moins de 1 000 m", "Moins de 5 000 m", "Moins de 2 000 m", "Moins de 200 m"], correctAnswer: "Moins de 1 000 m"),
        AeroQuestion(question: "Quelles conditions favorisent la formation d'un brouillard de rayonnement ?", options: ["Une nuit claire, un vent faible et un sol qui se refroidit", "Un vent fort de secteur ouest et un ciel couvert", "Le passage d'un front froid actif", "Une masse d'air chaud advectée au-dessus d'une mer chaude"], correctAnswer: "Une nuit claire, un vent faible et un sol qui se refroidit"),
        AeroQuestion(question: "Comment se forme un brouillard d'advection ?", options: ["Par déplacement d'air chaud et humide au-dessus d'une surface plus froide", "Par refroidissement nocturne du sol sous un ciel dégagé", "Par détente de l'air lors d'une ascendance orographique brutale", "Par évaporation d'une pluie chaude dans de l'air très sec"], correctAnswer: "Par déplacement d'air chaud et humide au-dessus d'une surface plus froide"),
        AeroQuestion(question: "Dans un METAR, que signifie l'abréviation BR ?", options: ["Brume", "Brouillard", "Bruine", "Grain"], correctAnswer: "Brume"),
        AeroQuestion(question: "Quelle visibilité minimale l'emploi de CAVOK dans un METAR exige-t-il ?", options: ["10 km ou plus", "8 km ou plus", "5 km ou plus", "1 500 m ou plus"], correctAnswer: "10 km ou plus"),
        AeroQuestion(question: "Dans un TAF, que signale le groupe TEMPO ?", options: ["Des variations temporaires durant chacune moins d'une heure", "Un changement durable et définitif des conditions", "Une probabilité de 30 % que le phénomène se produise", "La durée totale de validité du message"], correctAnswer: "Des variations temporaires durant chacune moins d'une heure"),
        AeroQuestion(question: "Dans un METAR, comment interprète-t-on le groupe 24015G28KT ?", options: ["Vent venant du 240° pour 15 kt, avec des rafales à 28 kt", "Vent soufflant vers le 240° pour 15 kt, avec des rafales à 28 kt", "Vent de 240 kt, moyenné sur 15 minutes, avec un maximum de 28 kt", "Vent venant du 240° pour 15 kt, ayant tourné de 28° dans l'heure"], correctAnswer: "Vent venant du 240° pour 15 kt, avec des rafales à 28 kt"),
        AeroQuestion(question: "Dans un METAR, un écart très faible entre la température et le point de rosée (par exemple 12/11) indique surtout :", options: ["Un air proche de la saturation, avec un risque de brouillard ou de nuages bas", "Un air très sec garantissant une excellente visibilité", "Une chute rapide de la pression atmosphérique", "Un renforcement imminent du vent de surface"], correctAnswer: "Un air proche de la saturation, avec un risque de brouillard ou de nuages bas"),
        AeroQuestion(question: "Dans quelle direction générale soufflent les courants-jets des latitudes moyennes ?", options: ["D'ouest en est", "D'est en ouest", "Du nord vers le sud", "Du sud vers le nord"], correctAnswer: "D'ouest en est"),
        AeroQuestion(question: "À quelle altitude rencontre-t-on principalement les courants-jets ?", options: ["Entre 30 000 et 40 000 ft environ", "Entre 5 000 et 10 000 ft environ", "Entre 15 000 et 20 000 ft environ", "Entre 60 000 et 70 000 ft environ"], correctAnswer: "Entre 30 000 et 40 000 ft environ"),
        AeroQuestion(question: "Qu'est-ce que l'effet de foehn ?", options: ["Un vent chaud et sec descendant sur le versant sous le vent d'un relief", "Un vent froid et humide remontant le long d'un versant exposé au vent", "Une brise nocturne descendant des vallées vers la plaine", "Un renforcement du vent dans un détroit entre deux terres"], correctAnswer: "Un vent chaud et sec descendant sur le versant sous le vent d'un relief"),
        AeroQuestion(question: "Comment souffle la brise de mer et à quel moment ?", options: ["De la mer vers la terre, pendant la journée", "De la terre vers la mer, pendant la journée", "De la mer vers la terre, pendant la nuit", "De la terre vers la mer, en milieu de matinée"], correctAnswer: "De la mer vers la terre, pendant la journée"),
        AeroQuestion(question: "Dans l'hémisphère nord, dans quel sens le vent circule-t-il autour d'une dépression ?", options: ["Dans le sens inverse des aiguilles d'une montre", "Dans le sens des aiguilles d'une montre", "Radialement vers l'extérieur, en ligne droite", "Toujours du nord vers le sud"], correctAnswer: "Dans le sens inverse des aiguilles d'une montre"),
        AeroQuestion(question: "Combien vaut exactement un mille nautique ?", options: ["1 852 m", "1 609 m", "1 000 m", "2 000 m"], correctAnswer: "1 852 m"),
        AeroQuestion(question: "Que représente un nœud ?", options: ["Un mille nautique par heure", "Un kilomètre par heure", "Un mille nautique par minute", "Un mètre par seconde"], correctAnswer: "Un mille nautique par heure"),
        AeroQuestion(question: "À quoi correspond historiquement le mille nautique ?", options: ["À une minute d'arc de latitude", "À un degré d'arc de latitude", "À une minute d'arc de longitude au 45e parallèle", "À un dixième de degré de longitude"], correctAnswer: "À une minute d'arc de latitude"),
        AeroQuestion(question: "Combien vaut un pied (foot) en mesure métrique ?", options: ["0,3048 m", "0,254 m", "0,914 m", "3,281 m"], correctAnswer: "0,3048 m"),
        AeroQuestion(question: "Comment les longitudes sont-elles comptées ?", options: ["De 0° à 180°, vers l'est et vers l'ouest à partir du méridien de Greenwich", "De 0° à 360°, vers l'est à partir de l'équateur", "De 0° à 90°, de part et d'autre du méridien de Greenwich", "De 0° à 90°, vers le nord et vers le sud"], correctAnswer: "De 0° à 180°, vers l'est et vers l'ouest à partir du méridien de Greenwich"),
        AeroQuestion(question: "Parmi les parallèles terrestres, lequel constitue un grand cercle ?", options: ["L'équateur", "Le tropique du Cancer", "Le cercle polaire arctique", "Le 45e parallèle nord"], correctAnswer: "L'équateur"),
        AeroQuestion(question: "Comment appelle-t-on le plus court chemin entre deux points de la surface du globe ?", options: ["L'orthodromie", "La loxodromie", "La route magnétique", "Le rhumb de compas"], correctAnswer: "L'orthodromie"),
        AeroQuestion(question: "Qu'est-ce qu'une loxodromie ?", options: ["Une trajectoire qui coupe tous les méridiens sous un même angle", "Une trajectoire qui coupe les méridiens sous des angles variables", "La trajectoire la plus courte entre deux points du globe", "Une trajectoire suivant une ligne de déclinaison magnétique constante"], correctAnswer: "Une trajectoire qui coupe tous les méridiens sous un même angle"),
        AeroQuestion(question: "Qu'est-ce qu'un grand cercle sur le globe terrestre ?", options: ["Un cercle dont le plan passe par le centre de la Terre", "Un cercle dont le plan est parallèle à celui de l'équateur", "Un cercle tangent à la surface terrestre", "Un cercle coupant tous les méridiens sous le même angle"], correctAnswer: "Un cercle dont le plan passe par le centre de la Terre"),
        AeroQuestion(question: "Sur une carte en projection Mercator, comment une loxodromie est-elle représentée ?", options: ["Par une ligne droite", "Par un arc de cercle incurvé vers le pôle le plus proche", "Par une courbe s'infléchissant vers l'équateur", "Par une ligne brisée changeant de direction à chaque méridien"], correctAnswer: "Par une ligne droite"),
        AeroQuestion(question: "Que mesure la déclinaison magnétique en un lieu donné ?", options: ["L'angle entre le nord vrai (géographique) et le nord magnétique", "L'angle entre le nord magnétique et le nord indiqué par le compas de bord", "L'angle entre le cap suivi et la route sol", "L'angle entre l'axe de l'avion et l'horizon"], correctAnswer: "L'angle entre le nord vrai (géographique) et le nord magnétique"),
        AeroQuestion(question: "Que joignent les lignes isogones tracées sur une carte ?", options: ["Les points de même déclinaison magnétique", "Les points de même altitude", "Les points de même pression atmosphérique", "Les points de même déviation compas"], correctAnswer: "Les points de même déclinaison magnétique"),
        AeroQuestion(question: "Un avion suit un cap vrai de 090° dans une région où la déclinaison magnétique est de 5° est. Quel est son cap magnétique ?", options: ["085°", "095°", "090°", "080°"], correctAnswer: "085°"),
        AeroQuestion(question: "À quoi est due la différence entre le cap suivi par un avion et sa route sol ?", options: ["À la dérive provoquée par le vent", "À la déclinaison magnétique du lieu", "À la déviation propre du compas de bord", "À l'erreur de calage de l'altimètre"], correctAnswer: "À la dérive provoquée par le vent"),
        AeroQuestion(question: "Une piste portant le numéro 27 est orientée selon un cap magnétique voisin de :", options: ["270°", "027°", "072°", "207°"], correctAnswer: "270°"),
        AeroQuestion(question: "À quoi la déviation du compas magnétique de bord est-elle due ?", options: ["Au champ magnétique propre de l'avion (masses métalliques et circuits électriques)", "À la déclinaison magnétique de la région survolée", "À la rotation de la Terre sur elle-même", "À la variation de pression avec l'altitude"], correctAnswer: "Au champ magnétique propre de l'avion (masses métalliques et circuits électriques)"),
        AeroQuestion(question: "Un avion se déplace à une vitesse sol de 480 kt. Quelle distance parcourt-il en 15 minutes ?", options: ["120 NM", "60 NM", "240 NM", "480 NM"], correctAnswer: "120 NM"),
        AeroQuestion(question: "À vitesse indiquée (IAS) constante, que devient la vitesse vraie (TAS) lorsque l'avion monte ?", options: ["Elle augmente", "Elle diminue", "Elle reste rigoureusement identique", "Elle augmente sous la tropopause puis diminue au-dessus"], correctAnswer: "Elle augmente"),
        AeroQuestion(question: "Quelle information un équipement DME fournit-il à l'équipage ?", options: ["La distance oblique séparant l'avion de la station sol", "Le relèvement magnétique de la station sol", "L'altitude de l'avion au-dessus de la station sol", "La vitesse sol de l'avion par rapport à la piste"], correctAnswer: "La distance oblique séparant l'avion de la station sol"),
        AeroQuestion(question: "À quoi servent principalement les winglets installés en bout d'aile ?", options: ["Réduire la traînée induite liée aux tourbillons marginaux", "Réduire la traînée de frottement du fuselage", "Augmenter la vitesse de décrochage en approche", "Amortir les vibrations de la dérive"], correctAnswer: "Réduire la traînée induite liée aux tourbillons marginaux"),
        AeroQuestion(question: "À masse constante, la traînée induite d'un avion :", options: ["Diminue lorsque la vitesse augmente", "Augmente lorsque la vitesse augmente", "Est indépendante de la portance produite", "Est maximale en croisière rapide"], correctAnswer: "Diminue lorsque la vitesse augmente"),
        AeroQuestion(question: "Le déploiement des becs de bord d'attaque permet :", options: ["D'augmenter l'incidence maximale atteignable avant décrochage", "D'augmenter la vitesse maximale en croisière", "De réduire la traînée pendant la montée", "D'augmenter la finesse maximale de l'aile"], correctAnswer: "D'augmenter l'incidence maximale atteignable avant décrochage"),
        AeroQuestion(question: "À masse constante, la sortie des volets a pour effet :", options: ["De diminuer la vitesse de décrochage", "D'augmenter la vitesse de décrochage", "De laisser la vitesse de décrochage inchangée", "De diminuer le coefficient de portance maximal"], correctAnswer: "De diminuer la vitesse de décrochage"),
        AeroQuestion(question: "En virage stabilisé en palier à 60° d'inclinaison, le facteur de charge vaut environ :", options: ["2", "1,15", "1,41", "3"], correctAnswer: "2"),
        AeroQuestion(question: "La finesse aérodynamique d'un avion est le rapport :", options: ["Portance sur traînée", "Poids sur portance", "Poussée sur traînée", "Envergure sur corde moyenne"], correctAnswer: "Portance sur traînée"),
        AeroQuestion(question: "L'effet de sol, ressenti juste avant le toucher des roues :", options: ["Réduit la traînée induite et tend à faire flotter l'avion", "Augmente fortement la vitesse de décrochage", "Diminue la portance produite par l'aile", "Annule l'efficacité des volets"], correctAnswer: "Réduit la traînée induite et tend à faire flotter l'avion"),
        AeroQuestion(question: "Le nombre de Mach critique d'un profil est la valeur de Mach à partir de laquelle :", options: ["L'écoulement atteint localement la vitesse du son sur le profil", "L'avion tout entier franchit le mur du son", "Le décrochage à basse vitesse devient inévitable", "Les moteurs atteignent leur poussée maximale"], correctAnswer: "L'écoulement atteint localement la vitesse du son sur le profil"),
        AeroQuestion(question: "La flèche des ailes des avions de ligne a principalement pour but :", options: ["De retarder les effets de compressibilité en transsonique", "D'augmenter la portance aux basses vitesses", "De réduire la masse de la voilure", "De simplifier la construction du caisson central"], correctAnswer: "De retarder les effets de compressibilité en transsonique"),
        AeroQuestion(question: "Un fort taux de dilution (bypass ratio) sur un turboréacteur procure :", options: ["Une consommation spécifique plus faible et un bruit réduit", "Un meilleur rendement aux vitesses supersoniques", "Un moteur de plus petit diamètre", "Une vitesse d'éjection des gaz beaucoup plus élevée"], correctAnswer: "Une consommation spécifique plus faible et un bruit réduit"),
        AeroQuestion(question: "Dans un turboréacteur, quel est l'ordre des éléments traversés par le flux d'air ?", options: ["Entrée d'air, compresseur, chambre de combustion, turbine, tuyère", "Entrée d'air, chambre de combustion, compresseur, turbine, tuyère", "Entrée d'air, turbine, compresseur, chambre de combustion, tuyère", "Entrée d'air, compresseur, turbine, chambre de combustion, tuyère"], correctAnswer: "Entrée d'air, compresseur, chambre de combustion, turbine, tuyère"),
        AeroQuestion(question: "Dans un turbopropulseur, la propulsion est assurée principalement :", options: ["Par l'hélice entraînée par la turbine", "Par l'éjection des gaz dans la tuyère", "Par le compresseur axial", "Par un réacteur d'appoint séparé"], correctAnswer: "Par l'hélice entraînée par la turbine"),
        AeroQuestion(question: "Sur un avion de ligne, les inverseurs de poussée sont utilisés :", options: ["Après le toucher des roues, pour réduire la distance d'arrêt", "En croisière, pour accélérer la descente", "Pendant la montée initiale, pour limiter la vitesse", "Avant la rotation, pour améliorer l'adhérence des roues"], correctAnswer: "Après le toucher des roues, pour réduire la distance d'arrêt"),
        AeroQuestion(question: "Sur la grande majorité des avions de ligne, l'APU est installé :", options: ["Dans le cône de queue du fuselage", "Dans le caisson central de voilure", "Sous le poste de pilotage", "Dans le mât de l'un des réacteurs"], correctAnswer: "Dans le cône de queue du fuselage"),
        AeroQuestion(question: "En vol, la RAT (Ram Air Turbine) est entraînée par :", options: ["L'écoulement d'air dû à la vitesse de l'avion", "Un moteur électrique de secours", "Les gaz d'échappement de l'APU", "Une bouteille d'air comprimé"], correctAnswer: "L'écoulement d'air dû à la vitesse de l'avion"),
        AeroQuestion(question: "Sur un turboréacteur double flux, le paramètre N1 désigne :", options: ["Le régime de rotation du corps basse pression entraînant la soufflante", "La poussée délivrée exprimée en pourcentage", "Le débit de carburant injecté", "La température des gaz d'échappement"], correctAnswer: "Le régime de rotation du corps basse pression entraînant la soufflante"),
        AeroQuestion(question: "À régime moteur constant, lorsque l'altitude augmente, la poussée d'un turboréacteur :", options: ["Diminue, car la masse volumique de l'air diminue", "Augmente, car la température de l'air diminue", "Reste rigoureusement constante", "Augmente proportionnellement au nombre de Mach"], correctAnswer: "Diminue, car la masse volumique de l'air diminue"),
        AeroQuestion(question: "Sur un avion à commandes de vol électriques, les ordres du pilote sont transmis aux gouvernes :", options: ["Sous forme de signaux électriques traités par des calculateurs", "Par câbles et poulies", "Par tringles et bielles rigides", "Par transmission pneumatique"], correctAnswer: "Sous forme de signaux électriques traités par des calculateurs"),
        AeroQuestion(question: "Un centrage trop arrière a pour conséquence :", options: ["De réduire la stabilité longitudinale de l'avion", "D'augmenter la stabilité longitudinale de l'avion", "D'augmenter la vitesse de décrochage", "D'augmenter les efforts au manche nécessaires à la rotation"], correctAnswer: "De réduire la stabilité longitudinale de l'avion"),
        AeroQuestion(question: "Le dièdre positif de la voilure contribue :", options: ["À la stabilité latérale, en roulis", "À la stabilité en tangage", "À la réduction de la traînée d'onde", "À l'augmentation de la poussée disponible"], correctAnswer: "À la stabilité latérale, en roulis"),
        AeroQuestion(question: "Un avion qui vole vers une zone de pression plus basse sans recaler son altimètre :", options: ["Se trouve en réalité plus bas que l'altitude indiquée", "Se trouve en réalité plus haut que l'altitude indiquée", "Se trouve exactement à l'altitude indiquée", "Voit son altimètre afficher une altitude trop faible"], correctAnswer: "Se trouve en réalité plus bas que l'altitude indiquée"),
        AeroQuestion(question: "En montée à vitesse indiquée constante, la vitesse vraie (TAS) :", options: ["Augmente", "Diminue", "Reste constante", "Diminue jusqu'à la tropopause puis augmente"], correctAnswer: "Augmente"),
        AeroQuestion(question: "L'obstruction du tube Pitot fausse en premier lieu l'indication :", options: ["De la vitesse indiquée", "Du cap magnétique", "De l'assiette", "De la température extérieure"], correctAnswer: "De la vitesse indiquée"),
        AeroQuestion(question: "Le FADEC d'un avion de ligne assure :", options: ["La régulation électronique à pleine autorité du moteur", "La commande automatique des volets", "La régulation de la pressurisation cabine", "La gestion du freinage automatique"], correctAnswer: "La régulation électronique à pleine autorité du moteur"),
        AeroQuestion(question: "Face à un avis de résolution (RA) du TCAS, l'équipage doit :", options: ["Suivre l'ordre du TCAS, même s'il contredit une instruction du contrôle", "Attendre la confirmation du contrôleur avant d'agir", "Ignorer l'avis lorsqu'il vole en espace aérien contrôlé", "Virer systématiquement à droite"], correctAnswer: "Suivre l'ordre du TCAS, même s'il contredit une instruction du contrôle"),
        AeroQuestion(question: "Le code transpondeur 7600 signale :", options: ["Une panne de radiocommunication", "Un acte d'intervention illicite", "Une situation de détresse", "Un vol VFR non contrôlé"], correctAnswer: "Une panne de radiocommunication"),
        AeroQuestion(question: "Le mode C d'un transpondeur transmet au contrôle :", options: ["L'altitude-pression de l'aéronef", "La vitesse sol de l'aéronef", "Le cap magnétique suivi", "L'immatriculation en clair"], correctAnswer: "L'altitude-pression de l'aéronef"),
        AeroQuestion(question: "En radiotéléphonie, un message d'urgence qui n'implique pas de danger immédiat s'annonce par :", options: ["PAN PAN", "MAYDAY", "SÉCURITÉ", "STANDBY"], correctAnswer: "PAN PAN"),
        AeroQuestion(question: "En phraséologie, le terme WILCO signifie :", options: ["J'ai compris votre message et je m'y conformerai", "Message reçu", "Je répète mon message", "Attendez, je vous rappelle"], correctAnswer: "J'ai compris votre message et je m'y conformerai"),
        AeroQuestion(question: "Dans l'alphabet aéronautique international, la lettre Q se prononce :", options: ["Quebec", "Quito", "Queen", "Quintal"], correctAnswer: "Quebec"),
        AeroQuestion(question: "Le siège de l'OACI se trouve à :", options: ["Montréal", "Genève", "Paris", "Bruxelles"], correctAnswer: "Montréal"),
        AeroQuestion(question: "L'IATA est :", options: ["Une association professionnelle regroupant des compagnies aériennes", "Une agence spécialisée des Nations unies", "L'autorité européenne de la sécurité aérienne", "Le régulateur national français de l'aviation civile"], correctAnswer: "Une association professionnelle regroupant des compagnies aériennes"),
        AeroQuestion(question: "L'AESA (EASA), agence européenne de la sécurité aérienne, a son siège à :", options: ["Cologne", "Bruxelles", "Toulouse", "Amsterdam"], correctAnswer: "Cologne"),
        AeroQuestion(question: "En France, l'autorité nationale chargée de la réglementation et de la surveillance de l'aviation civile est :", options: ["La DGAC", "Le BEA", "L'ENAC", "L'AESA"], correctAnswer: "La DGAC"),
        AeroQuestion(question: "En France, l'enquête de sécurité menée après un accident d'aviation civile relève :", options: ["Du BEA", "De la DGAC", "De l'OACI", "De l'ENAC"], correctAnswer: "Du BEA"),
        AeroQuestion(question: "La certification ETOPS concerne :", options: ["Les vols de bimoteurs s'éloignant d'un terrain de déroutement au-delà d'un temps de vol fixé", "Les vols supersoniques au-dessus des zones habitées", "Les atterrissages par très faible visibilité", "Le transport aérien de matières dangereuses"], correctAnswer: "Les vols de bimoteurs s'éloignant d'un terrain de déroutement au-delà d'un temps de vol fixé"),
        AeroQuestion(question: "La MEL (Minimum Equipment List) permet :", options: ["D'entreprendre un vol avec certains équipements inopérants, sous conditions", "De définir l'équipement de secours obligatoire en cabine", "De lister l'outillage de maintenance embarqué", "De fixer la composition minimale de l'équipage"], correctAnswer: "D'entreprendre un vol avec certains équipements inopérants, sous conditions"),
        AeroQuestion(question: "Le CRM (Crew Resource Management) désigne :", options: ["L'utilisation efficace de toutes les ressources disponibles, notamment humaines, au service de la sécurité du vol", "La gestion optimisée du carburant en croisière", "La planification de la maintenance programmée des avions", "La répartition des passagers et du fret en cabine"], correctAnswer: "L'utilisation efficace de toutes les ressources disponibles, notamment humaines, au service de la sécurité du vol"),
        AeroQuestion(question: "En cas de panne moteur constatée après V1 au décollage, l'équipage doit :", options: ["Poursuivre le décollage", "Interrompre immédiatement le décollage", "Rentrer le train avant la rotation", "Réduire la poussée du moteur restant"], correctAnswer: "Poursuivre le décollage"),
        AeroQuestion(question: "La VNE d'un avion est :", options: ["La vitesse à ne jamais dépasser", "La vitesse de croisière recommandée", "La vitesse de décrochage volets sortis", "La vitesse maximale train sorti"], correctAnswer: "La vitesse à ne jamais dépasser"),
        AeroQuestion(question: "L'aéroport dont le code OACI est LFPO est :", options: ["Paris-Orly", "Paris-Le Bourget", "Lyon-Saint-Exupéry", "Nice-Côte d'Azur"], correctAnswer: "Paris-Orly"),
        AeroQuestion(question: "Le code IATA à deux lettres de la compagnie Air France est :", options: ["AF", "AFR", "FR", "AZ"], correctAnswer: "AF"),
        AeroQuestion(question: "Qui réalise la première traversée de la Manche en avion, en 1909 ?", options: ["Louis Blériot", "Hubert Latham", "Clément Ader", "Roland Garros"], correctAnswer: "Louis Blériot"),
        AeroQuestion(question: "Qui effectue la première traversée aérienne de la Méditerranée, en 1913 ?", options: ["Roland Garros", "Louis Blériot", "Jean Mermoz", "Henri Guillaumet"], correctAnswer: "Roland Garros"),
        AeroQuestion(question: "Qui réussit en 1927 la première traversée de l'Atlantique Nord en solitaire et sans escale ?", options: ["Charles Lindbergh", "Amelia Earhart", "Jean Mermoz", "Howard Hughes"], correctAnswer: "Charles Lindbergh"),
        AeroQuestion(question: "Jean Mermoz est resté célèbre pour :", options: ["La première liaison postale sans escale au-dessus de l'Atlantique Sud, en 1930", "La première traversée de la Manche en avion", "Le premier vol supersonique de l'histoire", "La fondation de la compagnie Air France"], correctAnswer: "La première liaison postale sans escale au-dessus de l'Atlantique Sud, en 1930"),
        AeroQuestion(question: "Le premier vol supersonique officiellement reconnu, en 1947, est réalisé par :", options: ["Chuck Yeager sur Bell X-1", "André Turcat sur Concorde", "Neil Armstrong sur X-15", "Scott Crossfield sur Douglas Skyrocket"], correctAnswer: "Chuck Yeager sur Bell X-1"),
        AeroQuestion(question: "Le Concorde a été retiré du service commercial en :", options: ["2003", "1996", "2000", "2008"], correctAnswer: "2003"),
        AeroQuestion(question: "La Sud-Aviation Caravelle a marqué l'histoire en étant le premier avion de ligne à réaction à :", options: ["Placer ses réacteurs à l'arrière du fuselage", "Voler à vitesse supersonique", "Recevoir des commandes de vol électriques", "Traverser l'Atlantique sans escale"], correctAnswer: "Placer ses réacteurs à l'arrière du fuselage"),
        AeroQuestion(question: "Le Boeing 747 a effectué son premier vol en :", options: ["1969", "1959", "1974", "1980"], correctAnswer: "1969"),
        AeroQuestion(question: "Quel est le premier avion conçu et produit par Airbus ?", options: ["L'A300", "L'A310", "L'A320", "L'A340"], correctAnswer: "L'A300"),
        AeroQuestion(question: "La compagnie Air France est créée en :", options: ["1933", "1919", "1946", "1958"], correctAnswer: "1933"),
        AeroQuestion(question: "Quel appareil fut le premier avion de ligne à réaction mis en service commercial ?", options: ["Le de Havilland Comet", "Le Boeing 707", "La Sud-Aviation Caravelle", "Le Tupolev Tu-104"], correctAnswer: "Le de Havilland Comet"),
        AeroQuestion(question: "Qui devient en 1932 la première femme à traverser l'Atlantique en solitaire ?", options: ["Amelia Earhart", "Maryse Bastié", "Hélène Boucher", "Jacqueline Auriol"], correctAnswer: "Amelia Earhart"),
    ]
}

// MARK: - ViewModel
@MainActor
@Observable
final class CultureAeroViewModel {
    var questions: [AeroQuestion] = []
    var currentIndex: Int = 0
    var score: Double = 0
    var answered: Int = 0
    var skipped: Int = 0
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var selectedAnswer: String?
    var showFeedback: Bool = false
    var totalQuestions: Int = 30
    var shuffledOptions: [String] = []

    private var transitionTask: Task<Void, Never>?

    // Barème: +3 bonne, -1 mauvaise, 0 "je ne sais pas"

    var currentQuestion: AeroQuestion? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    private func shuffleCurrentOptions() {
        if let question = currentQuestion {
            shuffledOptions = question.options.shuffled()
        }
    }

    func startGame() {
        // Sélectionner 30 questions aléatoires parmi 240
        questions = BanqueRotation.tirer(AeroQuestion.allQuestions,
                                         nombre: totalQuestions,
                                         cle: "aero") { $0.question }
        currentIndex = 0
        score = 0
        answered = 0
        skipped = 0
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        selectedAnswer = nil
        showFeedback = false
        shuffleCurrentOptions()
    }

    func selectAnswer(_ answer: String) {
        guard selectedAnswer == nil, let question = currentQuestion else { return }

        selectedAnswer = answer
        showFeedback = true
        answered += 1

        if answer == question.correctAnswer {
            score += 3
            correctAnswers += 1
        } else {
            score -= 1
            wrongAnswers += 1
        }

        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(1))
            if Task.isCancelled { return }
            moveToNext()
        }
    }

    func skipQuestion() {
        guard selectedAnswer == nil else { return }
        skipped += 1
        moveToNext()
    }

    private func moveToNext() {
        currentIndex += 1
        selectedAnswer = nil
        showFeedback = false

        if currentIndex >= questions.count {
            isGameActive = false
            isGameOver = true
        } else {
            shuffleCurrentOptions()
        }
    }

    /// Barème à points négatifs : le score peut être inférieur à zéro.
    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        return GameResult(gameType: .cultureAero, score: score,
                          correctAnswers: correctAnswers, totalItems: totalQuestions,
                          duration: 0)
    }

    func stopGame() {
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - View
struct CultureAeroView: View {
    @State private var viewModel = CultureAeroViewModel()

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
        .navigationTitle("Culture Aéro")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .cultureAero)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Culture Aéro",
                    rules: [
                        RuleItem(icon: "airplane", text: "30 QCM sur l'aviation"),
                        RuleItem(icon: "plus.circle", text: "+3 points si correct"),
                        RuleItem(icon: "minus.circle", text: "-1 point si incorrect"),
                        RuleItem(icon: "forward", text: "Tu peux passer une question")
                    ],
                    accentColor: Theme.accentViolet,
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

            Image(systemName: "airplane")
                .font(.system(size: 80))
                .foregroundStyle(Theme.accentViolet)

            Text("Culture Aéronautique")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("30 questions aléatoires parmi 240", systemImage: "shuffle")
                    Label("+3 points bonne réponse", systemImage: "plus.circle.fill")
                    Label("-1 point mauvaise réponse", systemImage: "minus.circle.fill")
                    Label("0 point si 'Je ne sais pas'", systemImage: "hand.raised.fill")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer()

            Button {
                viewModel.startGame()
            } label: {
                Text("Commencer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.cyan)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Q\(viewModel.currentIndex + 1)/\(viewModel.questions.count)")
                    .font(.headline)

                Spacer()

                Text("Score: \(Int(viewModel.score))")
                    .font(.headline)
                    .foregroundStyle(viewModel.score >= 0 ? Theme.vert : Theme.rouge)
            }

            Spacer()

            if let question = viewModel.currentQuestion {
                // Question
                Text(question.question)
                    .font(.title3.weight(.medium))
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                // Options
                VStack(spacing: 10) {
                    ForEach(viewModel.shuffledOptions, id: \.self) { option in
                        Button {
                            viewModel.selectAnswer(option)
                        } label: {
                            Text(option)
                                .font(.body.weight(.medium))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(optionBackground(option, question: question))
                                .foregroundStyle(optionForeground(option, question: question))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .disabled(viewModel.selectedAnswer != nil)
                    }

                    // Bouton "Je ne sais pas"
                    if viewModel.selectedAnswer == nil {
                        Button {
                            viewModel.skipQuestion()
                        } label: {
                            Text("Je ne sais pas")
                                .font(.body.weight(.medium))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray4))
                                .foregroundStyle(.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }

            Spacer()
        }
    }

    private func optionBackground(_ option: String, question: AeroQuestion) -> Color {
        if viewModel.showFeedback {
            if option == question.correctAnswer {
                return Theme.vert
            } else if option == viewModel.selectedAnswer {
                return Theme.rouge
            }
        }
        return Color(.systemGray5)
    }

    private func optionForeground(_ option: String, question: AeroQuestion) -> Color {
        if viewModel.showFeedback && (option == question.correctAnswer || option == viewModel.selectedAnswer) {
            return .white
        }
        return .primary
    }

    private var gameOverView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: viewModel.score >= 0 ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(viewModel.score >= 0 ? Theme.vert : Theme.rouge)

            Text("Terminé !")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                ResultRow(label: "Réponses correctes", value: "\(viewModel.correctAnswers)")
                ResultRow(label: "Réponses incorrectes", value: "\(viewModel.wrongAnswers)")
                ResultRow(label: "Questions passées", value: "\(viewModel.skipped)")
                Divider()
                ResultRow(label: "Score final", value: "\(Int(viewModel.score)) pts")
            }
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("Barème: +3 correct, -1 incorrect, 0 passé")
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.cyan)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    NavigationStack {
        CultureAeroView()
    }
}
