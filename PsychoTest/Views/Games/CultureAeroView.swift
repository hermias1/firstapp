import SwiftUI

// MARK: - Model
struct AeroQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
}

// MARK: - Questions Database (139 questions)
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
        // Sélectionner 30 questions aléatoires parmi 139
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
                    Label("30 questions aléatoires parmi 139", systemImage: "shuffle")
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
