import SwiftUI

// MARK: - Model
struct EnglishQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
    let category: Category

    enum Category: String, CaseIterable {
        case grammar = "Grammar"
        case vocabulary = "Vocabulary"
    }
}

// MARK: - Questions Database (302 questions)
extension EnglishQuestion {
    static let allQuestions: [EnglishQuestion] = grammarQuestions + vocabularyQuestions

    // MARK: - Grammar Questions (100+)
    static let grammarQuestions: [EnglishQuestion] = [
        // Tenses - Past
        EnglishQuestion(question: "She ___ to the airport yesterday.", options: ["go", "goes", "went", "gone"], correctAnswer: "went", category: .grammar),
        EnglishQuestion(question: "They ___ the movie last night.", options: ["watch", "watched", "watching", "watches"], correctAnswer: "watched", category: .grammar),
        EnglishQuestion(question: "I ___ my keys this morning.", options: ["lose", "lost", "losed", "losing"], correctAnswer: "lost", category: .grammar),
        EnglishQuestion(question: "He ___ to Paris in 2019.", options: ["travel", "travels", "traveled", "traveling"], correctAnswer: "traveled", category: .grammar),
        EnglishQuestion(question: "We ___ dinner at 8 PM yesterday.", options: ["have", "has", "had", "having"], correctAnswer: "had", category: .grammar),

        // Tenses - Present Perfect
        EnglishQuestion(question: "He has been working here ___ 2019.", options: ["for", "since", "during", "while"], correctAnswer: "since", category: .grammar),
        EnglishQuestion(question: "I have lived in London ___ five years.", options: ["for", "since", "during", "while"], correctAnswer: "for", category: .grammar),
        EnglishQuestion(question: "She has ___ finished her homework.", options: ["yet", "already", "still", "ever"], correctAnswer: "already", category: .grammar),
        EnglishQuestion(question: "This is the best film I have ___ seen.", options: ["ever", "never", "already", "yet"], correctAnswer: "ever", category: .grammar),
        EnglishQuestion(question: "They haven't arrived ___.", options: ["yet", "already", "still", "ever"], correctAnswer: "yet", category: .grammar),

        // Tenses - Future
        EnglishQuestion(question: "The plane ___ at 9 PM tonight.", options: ["leaves", "leave", "leaving", "will leaving"], correctAnswer: "leaves", category: .grammar),
        EnglishQuestion(question: "By next year, I ___ my license.", options: ["will get", "will have gotten", "get", "am getting"], correctAnswer: "will have gotten", category: .grammar),
        EnglishQuestion(question: "I ___ you tomorrow.", options: ["call", "will call", "calling", "called"], correctAnswer: "will call", category: .grammar),
        EnglishQuestion(question: "She ___ 25 next month.", options: ["is", "will be", "was", "being"], correctAnswer: "will be", category: .grammar),
        EnglishQuestion(question: "We ___ to the beach this weekend.", options: ["go", "goes", "are going", "went"], correctAnswer: "are going", category: .grammar),

        // Conditionals
        EnglishQuestion(question: "If I ___ you, I would accept the offer.", options: ["am", "was", "were", "be"], correctAnswer: "were", category: .grammar),
        EnglishQuestion(question: "If it rains, we ___ stay home.", options: ["will", "would", "were", "have"], correctAnswer: "will", category: .grammar),
        EnglishQuestion(question: "I would help if I ___ time.", options: ["have", "has", "had", "having"], correctAnswer: "had", category: .grammar),
        EnglishQuestion(question: "If she ___ harder, she would pass.", options: ["study", "studies", "studied", "studying"], correctAnswer: "studied", category: .grammar),
        EnglishQuestion(question: "What ___ you do if you won the lottery?", options: ["will", "would", "do", "did"], correctAnswer: "would", category: .grammar),

        // Passive Voice
        EnglishQuestion(question: "The aircraft ___ inspected before takeoff.", options: ["must be", "must being", "must been", "must to be"], correctAnswer: "must be", category: .grammar),
        EnglishQuestion(question: "The letter ___ yesterday.", options: ["was sent", "sent", "is sent", "sends"], correctAnswer: "was sent", category: .grammar),
        EnglishQuestion(question: "English ___ in many countries.", options: ["speaks", "spoke", "is spoken", "speaking"], correctAnswer: "is spoken", category: .grammar),
        EnglishQuestion(question: "The house ___ in 1990.", options: ["built", "was built", "is built", "builds"], correctAnswer: "was built", category: .grammar),
        EnglishQuestion(question: "The work ___ by tomorrow.", options: ["will finish", "will be finished", "finishes", "finished"], correctAnswer: "will be finished", category: .grammar),

        // Subject-Verb Agreement
        EnglishQuestion(question: "Neither the pilot nor the co-pilot ___ aware of the failure at that time.", options: ["was", "were", "are", "is"], correctAnswer: "was", category: .grammar),
        EnglishQuestion(question: "The news ___ shocking.", options: ["is", "are", "were", "have"], correctAnswer: "is", category: .grammar),
        EnglishQuestion(question: "Everyone ___ ready for the test.", options: ["is", "are", "were", "have"], correctAnswer: "is", category: .grammar),
        EnglishQuestion(question: "The team ___ playing well.", options: ["is", "has", "have", "being"], correctAnswer: "is", category: .grammar),
        EnglishQuestion(question: "Mathematics ___ my favorite subject.", options: ["is", "are", "were", "have"], correctAnswer: "is", category: .grammar),

        // Comparatives and Superlatives
        EnglishQuestion(question: "The runway is ___ than I expected.", options: ["more short", "shorter", "most short", "short"], correctAnswer: "shorter", category: .grammar),
        EnglishQuestion(question: "She is the ___ student in class.", options: ["smarter", "smartest", "more smart", "most smart"], correctAnswer: "smartest", category: .grammar),
        EnglishQuestion(question: "This book is ___ than that one.", options: ["interesting", "more interesting", "most interesting", "interestinger"], correctAnswer: "more interesting", category: .grammar),
        EnglishQuestion(question: "He runs ___ than his brother.", options: ["fast", "faster", "fastest", "more fast"], correctAnswer: "faster", category: .grammar),
        EnglishQuestion(question: "This is the ___ day of my life.", options: ["happy", "happier", "happiest", "more happy"], correctAnswer: "happiest", category: .grammar),

        // Modal Verbs
        EnglishQuestion(question: "I wish I ___ fly better.", options: ["can", "could", "would", "will"], correctAnswer: "could", category: .grammar),
        EnglishQuestion(question: "You ___ smoke here. It's forbidden.", options: ["mustn't", "don't have to", "shouldn't", "couldn't"], correctAnswer: "mustn't", category: .grammar),
        EnglishQuestion(question: "She ___ be at home. Her car is here.", options: ["must", "can", "should", "would"], correctAnswer: "must", category: .grammar),
        EnglishQuestion(question: "You ___ work so hard. Take a break.", options: ["shouldn't", "mustn't", "can't", "won't"], correctAnswer: "shouldn't", category: .grammar),
        EnglishQuestion(question: "___ you help me with this?", options: ["Could", "May", "Ought", "Must"], correctAnswer: "Could", category: .grammar),

        // Gerunds and Infinitives
        EnglishQuestion(question: "He suggested ___ the flight.", options: ["to delay", "delaying", "delay", "delayed"], correctAnswer: "delaying", category: .grammar),
        EnglishQuestion(question: "We look forward ___ you soon.", options: ["to see", "seeing", "to seeing", "see"], correctAnswer: "to seeing", category: .grammar),
        EnglishQuestion(question: "I enjoy ___ books.", options: ["read", "to read", "reading", "reads"], correctAnswer: "reading", category: .grammar),
        EnglishQuestion(question: "She decided ___ medicine.", options: ["study", "studying", "to study", "studies"], correctAnswer: "to study", category: .grammar),
        EnglishQuestion(question: "He avoided ___ the question.", options: ["answer", "to answer", "answering", "answers"], correctAnswer: "answering", category: .grammar),

        // Prepositions
        EnglishQuestion(question: "___ having checked the systems, we proceeded.", options: ["After", "Before", "While", "During"], correctAnswer: "After", category: .grammar),
        EnglishQuestion(question: "I'm interested ___ aviation.", options: ["in", "on", "at", "for"], correctAnswer: "in", category: .grammar),
        EnglishQuestion(question: "She's good ___ mathematics.", options: ["in", "on", "at", "for"], correctAnswer: "at", category: .grammar),
        EnglishQuestion(question: "He arrived ___ Monday.", options: ["in", "on", "at", "by"], correctAnswer: "on", category: .grammar),
        EnglishQuestion(question: "I'll see you ___ 3 o'clock.", options: ["in", "on", "at", "by"], correctAnswer: "at", category: .grammar),

        // Relative Clauses
        EnglishQuestion(question: "The weather, ___ was forecast, turned bad.", options: ["as", "that", "what", "whom"], correctAnswer: "as", category: .grammar),
        EnglishQuestion(question: "The man ___ called is my uncle.", options: ["who", "which", "what", "whom"], correctAnswer: "who", category: .grammar),
        EnglishQuestion(question: "The book ___ I read was great.", options: ["who", "which", "what", "whom"], correctAnswer: "which", category: .grammar),
        EnglishQuestion(question: "This is the house ___ I grew up.", options: ["where", "which", "that", "what"], correctAnswer: "where", category: .grammar),
        EnglishQuestion(question: "The reason ___ I'm late is traffic.", options: ["why", "which", "when", "what"], correctAnswer: "why", category: .grammar),

        // Articles
        EnglishQuestion(question: "She is ___ engineer.", options: ["a", "an", "the", "—"], correctAnswer: "an", category: .grammar),
        EnglishQuestion(question: "___ sun rises in the east.", options: ["A", "An", "The", "—"], correctAnswer: "The", category: .grammar),
        EnglishQuestion(question: "I need ___ information.", options: ["a", "an", "some", "many"], correctAnswer: "some", category: .grammar),
        EnglishQuestion(question: "He plays ___ piano beautifully.", options: ["a", "an", "the", "—"], correctAnswer: "the", category: .grammar),
        EnglishQuestion(question: "She went to ___ university in London.", options: ["a", "an", "these", "much"], correctAnswer: "a", category: .grammar),

        // Present Perfect vs Past Simple
        EnglishQuestion(question: "The passengers ___ board yet.", options: ["haven't", "hasn't", "didn't", "don't"], correctAnswer: "haven't", category: .grammar),
        EnglishQuestion(question: "I ___ him last week.", options: ["see", "saw", "have seen", "seen"], correctAnswer: "saw", category: .grammar),
        EnglishQuestion(question: "She ___ here for two years.", options: ["works", "worked", "has worked", "working"], correctAnswer: "has worked", category: .grammar),
        EnglishQuestion(question: "They ___ to Paris three times.", options: ["go", "went", "have been", "been"], correctAnswer: "have been", category: .grammar),
        EnglishQuestion(question: "I ___ my breakfast already.", options: ["eat", "ate", "have eaten", "eating"], correctAnswer: "have eaten", category: .grammar),

        // Inversion
        EnglishQuestion(question: "Not only ___ he arrive late, but he forgot his ID.", options: ["did", "does", "was", "had"], correctAnswer: "did", category: .grammar),
        EnglishQuestion(question: "Rarely ___ I seen such beauty.", options: ["have", "had", "do", "did"], correctAnswer: "have", category: .grammar),
        EnglishQuestion(question: "Never before ___ I seen such a storm.", options: ["had", "have", "did", "was"], correctAnswer: "had", category: .grammar),
        EnglishQuestion(question: "Hardly ___ he arrived when it started raining.", options: ["had", "has", "did", "was"], correctAnswer: "had", category: .grammar),
        EnglishQuestion(question: "Only then ___ I understand what had happened.", options: ["did", "was", "have", "am"], correctAnswer: "did", category: .grammar),

        // Question Tags
        EnglishQuestion(question: "You're coming, ___?", options: ["aren't you", "isn't it", "don't you", "won't you"], correctAnswer: "aren't you", category: .grammar),
        EnglishQuestion(question: "She doesn't like coffee, ___?", options: ["does she", "doesn't she", "is she", "isn't she"], correctAnswer: "does she", category: .grammar),
        EnglishQuestion(question: "They've finished, ___?", options: ["haven't they", "have they", "didn't they", "did they"], correctAnswer: "haven't they", category: .grammar),
        EnglishQuestion(question: "Let's go, ___?", options: ["shall we", "will we", "do we", "don't we"], correctAnswer: "shall we", category: .grammar),
        EnglishQuestion(question: "He can swim, ___?", options: ["can't he", "can he", "doesn't he", "does he"], correctAnswer: "can't he", category: .grammar),

        // Reported Speech
        EnglishQuestion(question: "She said she ___ tired.", options: ["is", "was", "has been", "will be"], correctAnswer: "was", category: .grammar),
        EnglishQuestion(question: "He told me he ___ help.", options: ["will", "would", "can", "may"], correctAnswer: "would", category: .grammar),
        EnglishQuestion(question: "They asked if I ___ coming.", options: ["am", "was", "will be", "being"], correctAnswer: "was", category: .grammar),
        EnglishQuestion(question: "She asked where I ___.", options: ["live", "lived", "living", "lives"], correctAnswer: "lived", category: .grammar),
        EnglishQuestion(question: "He said he ___ the answer.", options: ["knows", "knew", "knowing", "know"], correctAnswer: "knew", category: .grammar),

        // Quantifiers
        EnglishQuestion(question: "There isn't ___ milk left.", options: ["some", "any", "many", "few"], correctAnswer: "any", category: .grammar),
        EnglishQuestion(question: "I have ___ friends in Paris.", options: ["a few", "a little", "few", "little"], correctAnswer: "a few", category: .grammar),
        EnglishQuestion(question: "She has ___ patience.", options: ["many", "much", "few", "a few"], correctAnswer: "much", category: .grammar),
        EnglishQuestion(question: "There are ___ people waiting.", options: ["much", "many", "little", "a little"], correctAnswer: "many", category: .grammar),
        EnglishQuestion(question: "I need ___ more time.", options: ["a few", "a little", "few", "many"], correctAnswer: "a little", category: .grammar),

        // Mixed Grammar
        EnglishQuestion(question: "If I ___ known, I would have helped.", options: ["have", "has", "had", "having"], correctAnswer: "had", category: .grammar),
        EnglishQuestion(question: "She ___ to be very kind, judging by her smile.", options: ["seems", "seem", "seeming", "seemingly"], correctAnswer: "seems", category: .grammar),
        EnglishQuestion(question: "I'd rather you ___ smoking.", options: ["stop", "stopped", "stopping", "stops"], correctAnswer: "stopped", category: .grammar),
        EnglishQuestion(question: "It's time we ___.", options: ["leave", "left", "leaving", "leaves"], correctAnswer: "left", category: .grammar),
        EnglishQuestion(question: "I wish I ___ taller.", options: ["am", "was", "were", "be"], correctAnswer: "were", category: .grammar),
        EnglishQuestion(question: "He made me ___ the truth.", options: ["tell", "to tell", "telling", "told"], correctAnswer: "tell", category: .grammar),
        EnglishQuestion(question: "I had my car ___.", options: ["repair", "repaired", "repairing", "repairs"], correctAnswer: "repaired", category: .grammar),
        EnglishQuestion(question: "The sooner, the ___.", options: ["good", "better", "best", "well"], correctAnswer: "better", category: .grammar),
        EnglishQuestion(question: "No sooner had I arrived ___ it started raining.", options: ["than", "when", "that", "then"], correctAnswer: "than", category: .grammar),
        EnglishQuestion(question: "He's used to ___ early.", options: ["wake", "waking", "woke", "woken"], correctAnswer: "waking", category: .grammar),
        EnglishQuestion(question: "I can't help ___ about it.", options: ["think", "to think", "thinking", "thought"], correctAnswer: "thinking", category: .grammar),
        EnglishQuestion(question: "It's no use ___ about it.", options: ["worry", "to worry", "worrying", "worried"], correctAnswer: "worrying", category: .grammar),
        EnglishQuestion(question: "She insisted ___ paying.", options: ["on", "in", "at", "for"], correctAnswer: "on", category: .grammar),
        EnglishQuestion(question: "I apologized ___ being late.", options: ["for", "about", "of", "to"], correctAnswer: "for", category: .grammar),
        EnglishQuestion(question: "He succeeded ___ passing the exam.", options: ["in", "on", "at", "to"], correctAnswer: "in", category: .grammar),

        // MARK: Questions ajoutées après contrôle de double réponse
        EnglishQuestion(question: "Last summer, the crew ___ three transatlantic flights in a single week.", options: ["operated", "has operated", "have operated", "had been operating"], correctAnswer: "operated", category: .grammar),
        EnglishQuestion(question: "My sister ___ in Toulouse since she joined the aerospace industry in 2019.", options: ["has lived", "lives", "lived", "is living"], correctAnswer: "has lived", category: .grammar),
        EnglishQuestion(question: "This time tomorrow we ___ over the Atlantic.", options: ["will be flying", "will fly", "would be flying", "will have flown"], correctAnswer: "will be flying", category: .grammar),
        EnglishQuestion(question: "According to the timetable, the airport shuttle ___ every twenty minutes.", options: ["leaves", "is leaving", "will be leaving", "has left"], correctAnswer: "leaves", category: .grammar),
        EnglishQuestion(question: "By the time we reached the gate, the plane ___.", options: ["had already left", "has already left", "would already leave", "is already leaving"], correctAnswer: "had already left", category: .grammar),
        EnglishQuestion(question: "By the time you land in Tokyo, we ___ the meeting.", options: ["will have finished", "will finish", "have finished", "would finish"], correctAnswer: "will have finished", category: .grammar),
        EnglishQuestion(question: "We ___ over the Alps when the seatbelt sign suddenly came on.", options: ["were flying", "flew", "have flown", "had flown"], correctAnswer: "were flying", category: .grammar),
        EnglishQuestion(question: "He has been a flight instructor since he ___ the air force in 2015.", options: ["left", "has left", "had left", "was leaving"], correctAnswer: "left", category: .grammar),
        EnglishQuestion(question: "If I ___ you, I would apply for the cadet programme this year.", options: ["were", "am", "will be", "would be"], correctAnswer: "were", category: .grammar),
        EnglishQuestion(question: "If the fog ___ so thick that night, we would have landed on time.", options: ["hadn't been", "wasn't", "wouldn't have been", "hasn't been"], correctAnswer: "hadn't been", category: .grammar),
        EnglishQuestion(question: "If she had passed the medical last year, she ___ a first officer today.", options: ["would be", "would have been", "will be", "is"], correctAnswer: "would be", category: .grammar),
        EnglishQuestion(question: "If the wind ___ any stronger, the airport will close the second runway.", options: ["gets", "will get", "would get", "got"], correctAnswer: "gets", category: .grammar),
        EnglishQuestion(question: "The northern runway ___ since Monday for resurfacing work.", options: ["has been closed", "is closing", "was closed", "closes"], correctAnswer: "has been closed", category: .grammar),
        EnglishQuestion(question: "On yesterday's flight, the safety demonstration ___ by the purser.", options: ["was given", "has been given", "gave", "is given"], correctAnswer: "was given", category: .grammar),
        EnglishQuestion(question: "All electronic devices must ___ during take-off and landing.", options: ["be switched off", "switching off", "being switched off", "to be switched off"], correctAnswer: "be switched off", category: .grammar),
        EnglishQuestion(question: "The new turboprop ___ to be the quietest aircraft in its class.", options: ["is said", "says", "is saying", "has said"], correctAnswer: "is said", category: .grammar),
        EnglishQuestion(question: "She apologised for ___ late to the briefing.", options: ["being", "be", "to be", "been"], correctAnswer: "being", category: .grammar),
        EnglishQuestion(question: "The captain suggested ___ a more northerly route to avoid the storm.", options: ["taking", "to take", "take", "took"], correctAnswer: "taking", category: .grammar),
        EnglishQuestion(question: "Halfway through the checklist, the co-pilot stopped ___ a call from the tower.", options: ["to take", "taking", "take", "taken"], correctAnswer: "to take", category: .grammar),
        EnglishQuestion(question: "I clearly remember ___ the cabin door before we left the aircraft.", options: ["locking", "to lock", "lock", "locked"], correctAnswer: "locking", category: .grammar),
        EnglishQuestion(question: "She was still at the check-in desk at 9:05, so she ___ the 9:00 flight.", options: ["can't have boarded", "must have boarded", "should have boarded", "needn't have boarded"], correctAnswer: "can't have boarded", category: .grammar),
        EnglishQuestion(question: "Passengers ___ use mobile phones during take-off: it is strictly forbidden.", options: ["must not", "do not have to", "need not", "might not"], correctAnswer: "must not", category: .grammar),
        EnglishQuestion(question: "You ___ leave now if you want to catch the last shuttle to the terminal.", options: ["had better", "have better", "would better", "should better"], correctAnswer: "had better", category: .grammar),
        EnglishQuestion(question: "Before onboard weather radar existed, pilots ___ see storms only when they were already very close.", options: ["could", "can", "could have", "will be able to"], correctAnswer: "could", category: .grammar),
        EnglishQuestion(question: "___ life of a long-haul pilot is far less glamorous than people imagine.", options: ["The", "A", "No article", "Some"], correctAnswer: "The", category: .grammar),
        EnglishQuestion(question: "___ Netherlands is one of the airline's busiest destinations.", options: ["The", "A", "No article", "That"], correctAnswer: "The", category: .grammar),
        EnglishQuestion(question: "The connecting flight leaves ___ Tuesday at dawn.", options: ["on", "in", "at", "by"], correctAnswer: "on", category: .grammar),
        EnglishQuestion(question: "We arrived ___ the airport almost three hours before departure.", options: ["at", "in", "to", "on"], correctAnswer: "at", category: .grammar),
        EnglishQuestion(question: "The duty manager is responsible ___ the cabin crew roster.", options: ["for", "of", "to", "with"], correctAnswer: "for", category: .grammar),
        EnglishQuestion(question: "This aircraft is capable ___ flying for twelve hours without refuelling.", options: ["of", "to", "for", "in"], correctAnswer: "of", category: .grammar),
        EnglishQuestion(question: "The engineer ___ signed the maintenance report has thirty years' experience.", options: ["who", "which", "whose", "whom"], correctAnswer: "who", category: .grammar),
        EnglishQuestion(question: "Reykjavik, ___ is the capital of Iceland, was our stopover on the way to New York.", options: ["which", "that", "where", "what"], correctAnswer: "which", category: .grammar),
        EnglishQuestion(question: "The passenger ___ suitcase was lost has been offered compensation.", options: ["whose", "who's", "whom", "which"], correctAnswer: "whose", category: .grammar),
        EnglishQuestion(question: "That's the colleague ___ I shared a hotel room in Osaka.", options: ["with whom", "who", "that", "which"], correctAnswer: "with whom", category: .grammar),
        EnglishQuestion(question: "The A350 is ___ quieter than the aircraft it replaced.", options: ["far", "very", "so", "too"], correctAnswer: "far", category: .grammar),
        EnglishQuestion(question: "It was ___ landing I have ever experienced.", options: ["the smoothest", "the most smooth", "smoothest", "smoother"], correctAnswer: "the smoothest", category: .grammar),
        EnglishQuestion(question: "The flight to Dubai takes ___ the flight to Cairo.", options: ["twice as long as", "twice longer than", "two times longer as", "twice as longer as"], correctAnswer: "twice as long as", category: .grammar),
        EnglishQuestion(question: "___ we leave, the better our chances of avoiding the traffic.", options: ["The sooner", "Sooner", "More soon", "The soonest"], correctAnswer: "The sooner", category: .grammar),
        EnglishQuestion(question: "He told me yesterday that he ___ his licence the previous month.", options: ["had obtained", "has obtained", "obtains", "will obtain"], correctAnswer: "had obtained", category: .grammar),
        EnglishQuestion(question: "The immigration officer asked me ___.", options: ["where I was going", "where was I going", "where I am going", "where do I go"], correctAnswer: "where I was going", category: .grammar),
        EnglishQuestion(question: "She said she ___ call us the following day.", options: ["would", "will", "shall", "would have"], correctAnswer: "would", category: .grammar),
        EnglishQuestion(question: "The instructor told us ___ during the emergency briefing.", options: ["not to talk", "to not talking", "don't talk", "that not talk"], correctAnswer: "not to talk", category: .grammar),
        EnglishQuestion(question: "Not only ___ the flight delayed, but our luggage was also sent to the wrong city.", options: ["was", "it was", "did", "had"], correctAnswer: "was", category: .grammar),
        EnglishQuestion(question: "No sooner ___ we taken off than the storm broke over the airport.", options: ["had", "have", "did", "were"], correctAnswer: "had", category: .grammar),
        EnglishQuestion(question: "Seldom ___ such severe turbulence on this route.", options: ["have we experienced", "we have experienced", "did we experienced", "we experienced"], correctAnswer: "have we experienced", category: .grammar),
        EnglishQuestion(question: "How ___ luggage are you taking on board?", options: ["much", "many", "few", "several"], correctAnswer: "much", category: .grammar),
        EnglishQuestion(question: "There were ___ complaints about the noise that the airline changed the flight path.", options: ["so many", "so much", "such many", "too many"], correctAnswer: "so many", category: .grammar),
        EnglishQuestion(question: "___ of the crew members speaks Japanese, so we will need an interpreter.", options: ["None", "No one", "Any", "Both"], correctAnswer: "None", category: .grammar),
        EnglishQuestion(question: "You've never flown a glider, ___?", options: ["have you", "haven't you", "did you", "do you"], correctAnswer: "have you", category: .grammar),
        EnglishQuestion(question: "Let's take the earlier train to the airport, ___?", options: ["shall we", "will we", "do we", "shan't we"], correctAnswer: "shall we", category: .grammar),
        EnglishQuestion(question: "Hand me the checklist, ___?", options: ["will you", "do you", "shall you", "are you"], correctAnswer: "will you", category: .grammar),
        EnglishQuestion(question: "I'm sitting in the wrong seat, ___?", options: ["aren't I", "amn't I", "am not I", "isn't it"], correctAnswer: "aren't I", category: .grammar),
        EnglishQuestion(question: "The aircraft had to ___ shortly after take-off because of an oil leak.", options: ["turn back", "turn down", "turn over", "turn up"], correctAnswer: "turn back", category: .grammar),
        EnglishQuestion(question: "The crew briefing has been ___ until Monday morning.", options: ["put off", "put out", "put away", "put up"], correctAnswer: "put off", category: .grammar),
        EnglishQuestion(question: "He ___ his mother, who was a navigator in the 1980s.", options: ["takes after", "takes over", "takes up", "takes on"], correctAnswer: "takes after", category: .grammar),
        EnglishQuestion(question: "The rental car ___ petrol ten kilometres from the terminal.", options: ["ran out of", "ran over", "ran into", "ran through"], correctAnswer: "ran out of", category: .grammar),
        EnglishQuestion(question: "Quel mot a le sens le plus proche de « reluctant » ?", options: ["unwilling", "eager", "reliable", "thorough"], correctAnswer: "unwilling", category: .vocabulary),
        EnglishQuestion(question: "Quel adjectif a le sens le plus proche de « scarce » ?", options: ["rare", "plentiful", "frightened", "costly"], correctAnswer: "rare", category: .vocabulary),
        EnglishQuestion(question: "Quel verbe a le sens le plus proche de « to enhance » ?", options: ["to improve", "to weaken", "to postpone", "to describe"], correctAnswer: "to improve", category: .vocabulary),
        EnglishQuestion(question: "Quel adjectif a le sens le plus proche de « cautious » ?", options: ["careful", "curious", "reckless", "confident"], correctAnswer: "careful", category: .vocabulary),
        EnglishQuestion(question: "Quel adjectif a le sens le plus proche de « tedious » ?", options: ["boring", "tidy", "risky", "brief"], correctAnswer: "boring", category: .vocabulary),
        EnglishQuestion(question: "In radio communication, « to acknowledge a message » means:", options: ["to confirm that you have received it", "to answer it in detail", "to forward it to another station", "to write it down in the logbook"], correctAnswer: "to confirm that you have received it", category: .vocabulary),
        EnglishQuestion(question: "Quel groupe verbal a le sens le plus proche de « to jeopardise » ?", options: ["to put at risk", "to speed up", "to make official", "to share out equally"], correctAnswer: "to put at risk", category: .vocabulary),
        EnglishQuestion(question: "Quel est le contraire de « to accelerate » ?", options: ["to slow down", "to speed up", "to refuel", "to turn"], correctAnswer: "to slow down", category: .vocabulary),
        EnglishQuestion(question: "Quel est le contraire de « temporary » ?", options: ["permanent", "brief", "seasonal", "fragile"], correctAnswer: "permanent", category: .vocabulary),
        EnglishQuestion(question: "Quel est le contraire de « to allow » ?", options: ["to forbid", "to permit", "to require", "to postpone"], correctAnswer: "to forbid", category: .vocabulary),
        EnglishQuestion(question: "Quel est le contraire de « to tighten » ?", options: ["to loosen", "to fasten", "to inspect", "to twist"], correctAnswer: "to loosen", category: .vocabulary),
        EnglishQuestion(question: "Quel est le contraire de « to hire » (an employee) ?", options: ["to dismiss", "to recruit", "to promote", "to train"], correctAnswer: "to dismiss", category: .vocabulary),
        EnglishQuestion(question: "Quel est le contraire de « shallow » (water) ?", options: ["deep", "narrow", "calm", "muddy"], correctAnswer: "deep", category: .vocabulary),
        EnglishQuestion(question: "Quel est le contraire de « guilty » ?", options: ["innocent", "responsible", "ashamed", "convicted"], correctAnswer: "innocent", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « The new medicine had no ___ on the pain. »", options: ["effect", "affect", "affects", "affectation"], correctAnswer: "effect", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « He refused to lie about the incident: for him it was a matter of ___. »", options: ["principle", "principal", "principals", "principality"], correctAnswer: "principle", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « The aircraft carries a full ___ of eight cabin crew members. »", options: ["complement", "compliment", "completion", "complimentary"], correctAnswer: "complement", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « Be careful not to ___ your boarding pass. »", options: ["lose", "loose", "loosen", "loss"], correctAnswer: "lose", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « Could you ___ me on which route to take? »", options: ["advise", "advice", "advises", "advising"], correctAnswer: "advise", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « I forgot my pen — could you ___ me yours? »", options: ["lend", "borrow", "hire", "take"], correctAnswer: "lend", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « This instrument is extremely ___ to changes in temperature. »", options: ["sensitive", "sensible", "sensational", "senseless"], correctAnswer: "sensitive", category: .vocabulary),
        EnglishQuestion(question: "« To be under the weather » means:", options: ["to feel slightly ill", "to be caught in a storm", "to be extremely busy", "to arrive late"], correctAnswer: "to feel slightly ill", category: .vocabulary),
        EnglishQuestion(question: "« To bite the bullet » means:", options: ["to force yourself to do something unpleasant", "to lose your temper suddenly", "to make a serious mistake", "to speak without thinking"], correctAnswer: "to force yourself to do something unpleasant", category: .vocabulary),
        EnglishQuestion(question: "Someone who is « on cloud nine » is:", options: ["extremely happy", "completely lost", "very tired", "slightly annoyed"], correctAnswer: "extremely happy", category: .vocabulary),
        EnglishQuestion(question: "« To call it a day » means:", options: ["to stop working for the day", "to postpone a meeting until tomorrow", "to work extra hours", "to fix a date for an event"], correctAnswer: "to stop working for the day", category: .vocabulary),
        EnglishQuestion(question: "Something that happens « once in a blue moon » happens:", options: ["very rarely", "every month", "suddenly", "only at night"], correctAnswer: "very rarely", category: .vocabulary),
        EnglishQuestion(question: "« To let the cat out of the bag » means:", options: ["to reveal a secret by accident", "to make a difficult choice", "to escape from a trap", "to waste a good opportunity"], correctAnswer: "to reveal a secret by accident", category: .vocabulary),
        EnglishQuestion(question: "For an aircraft, « to take off » means:", options: ["to leave the ground", "to slow down on the runway", "to return to the parking stand", "to unload the cargo"], correctAnswer: "to leave the ground", category: .vocabulary),
        EnglishQuestion(question: "« To put off a meeting » means:", options: ["to postpone it to a later date", "to cancel it for good", "to make it shorter", "to attend it in person"], correctAnswer: "to postpone it to a later date", category: .vocabulary),
        EnglishQuestion(question: "« To look after someone » means:", options: ["to take care of them", "to search for them", "to glance at them quickly", "to look for information about them"], correctAnswer: "to take care of them", category: .vocabulary),
        EnglishQuestion(question: "« He gave up after three attempts. » This means:", options: ["he stopped trying", "he finally succeeded", "he started again from the beginning", "he asked someone for help"], correctAnswer: "he stopped trying", category: .vocabulary),
        EnglishQuestion(question: "« The aircraft ran out of de-icing fluid. » « To run out of something » means:", options: ["to have no more of it left", "to leave a place in a hurry", "to buy a large quantity of it", "to use it for the first time"], correctAnswer: "to have no more of it left", category: .vocabulary),
        EnglishQuestion(question: "At the airport, « to check in » means:", options: ["to register for your flight before departure", "to go through the security control", "to get on board the aircraft", "to collect your baggage after landing"], correctAnswer: "to register for your flight before departure", category: .vocabulary),
        EnglishQuestion(question: "« To turn down an offer » means:", options: ["to refuse it", "to accept it immediately", "to negotiate a better one", "to make it public"], correctAnswer: "to refuse it", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « Children have to ___ their homework every evening. »", options: ["do", "make", "take", "give"], correctAnswer: "do", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « The flight was delayed by ___ rain. »", options: ["heavy", "strong", "large", "powerful"], correctAnswer: "heavy", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « Please ___ attention to the safety demonstration. »", options: ["pay", "do", "take", "make"], correctAnswer: "pay", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « The trainee is ___ good progress. »", options: ["making", "doing", "taking", "having"], correctAnswer: "making", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « I need a ___ coffee to stay awake. »", options: ["strong", "heavy", "hard", "powerful"], correctAnswer: "strong", category: .vocabulary),
        EnglishQuestion(question: "Complétez : « If we don't hurry, we'll ___ our flight. »", options: ["miss", "lose", "fail", "lack"], correctAnswer: "miss", category: .vocabulary),
        EnglishQuestion(question: "« Actually, the departure gate has changed. » Le mot « actually » signifie ici :", options: ["En fait", "Actuellement", "Activement", "Finalement"], correctAnswer: "En fait", category: .vocabulary),
        EnglishQuestion(question: "« The delay was long, but we eventually took off. » Le mot « eventually » signifie ici :", options: ["finalement", "éventuellement", "occasionnellement", "immédiatement"], correctAnswer: "finalement", category: .vocabulary),
        EnglishQuestion(question: "« She attended the safety briefing. » Le verbe « to attend » signifie ici :", options: ["assister à", "attendre", "animer", "annuler"], correctAnswer: "assister à", category: .vocabulary),
        EnglishQuestion(question: "« A library » se traduit en français par :", options: ["une bibliothèque", "une librairie", "une maison d'édition", "un libre-service"], correctAnswer: "une bibliothèque", category: .vocabulary),
        EnglishQuestion(question: "« He was very sympathetic when I told him about the incident. » « Sympathetic » signifie ici :", options: ["compatissant", "sympathique", "distant", "drôle"], correctAnswer: "compatissant", category: .vocabulary),
        EnglishQuestion(question: "« She passed her exam. » Cela signifie :", options: ["Elle a réussi son examen.", "Elle a passé l'épreuve, sans que l'on sache le résultat.", "Elle s'est inscrite à l'examen.", "Elle a raté son examen."], correctAnswer: "Elle a réussi son examen.", category: .vocabulary),
        EnglishQuestion(question: "In an aircraft, the cockpit is:", options: ["the compartment from which the pilots fly the aircraft", "the cabin where the passengers are seated", "the hold where the baggage is stored", "the tower from which controllers work"], correctAnswer: "the compartment from which the pilots fly the aircraft", category: .vocabulary),
        EnglishQuestion(question: "A runway is:", options: ["a strip of ground used for take-off and landing", "a road connecting the terminals of an airport", "a corridor of air used for navigation", "an area where aircraft are parked and refuelled"], correctAnswer: "a strip of ground used for take-off and landing", category: .vocabulary),
        EnglishQuestion(question: "An aircraft that is taxiing is:", options: ["moving on the ground between the stand and the runway", "flying at low altitude just before landing", "being pushed backwards by a tug", "waiting at the stand with the engines shut down"], correctAnswer: "moving on the ground between the stand and the runway", category: .vocabulary),
        EnglishQuestion(question: "At the airport, « boarding » is:", options: ["the passengers getting on the aircraft", "the passengers leaving the aircraft after landing", "the loading of freight into the hold", "the checking of passports at the border"], correctAnswer: "the passengers getting on the aircraft", category: .vocabulary),
        EnglishQuestion(question: "A flight with a delay is a flight that:", options: ["leaves later than scheduled", "has been cancelled by the airline", "has been diverted to another airport", "is flying at a lower altitude than usual"], correctAnswer: "leaves later than scheduled", category: .vocabulary),
        EnglishQuestion(question: "The crew of an aircraft is:", options: ["all the people working on board", "all the passengers travelling on board", "the ground staff working at the check-in desks", "the group of aircraft owned by an airline"], correctAnswer: "all the people working on board", category: .vocabulary),
        EnglishQuestion(question: "At an airport, a gate is:", options: ["the point in the terminal where passengers board the aircraft", "the entrance to the airport car park", "the barrier at the end of a runway", "the counter where boarding passes are issued"], correctAnswer: "the point in the terminal where passengers board the aircraft", category: .vocabulary),
        EnglishQuestion(question: "Which sentence is correct?", options: ["I have two pieces of luggage.", "I have two luggages.", "I have two luggage.", "I have a luggage."], correctAnswer: "I have two pieces of luggage.", category: .vocabulary),
        EnglishQuestion(question: "Turbulence is:", options: ["irregular movements of the air that shake the aircraft", "a strong wind blowing across the runway", "a thick layer of cloud that reduces visibility", "a sudden loss of engine power"], correctAnswer: "irregular movements of the air that shake the aircraft", category: .vocabulary),
        EnglishQuestion(question: "The altitude of an aircraft is:", options: ["its vertical distance above sea level", "its speed relative to the ground", "the distance remaining to its destination", "the angle of its wings relative to the airflow"], correctAnswer: "its vertical distance above sea level", category: .vocabulary),
    ]

    // MARK: - Vocabulary Questions (100+)
    static let vocabularyQuestions: [EnglishQuestion] = [
        // Aviation Vocabulary
        EnglishQuestion(question: "The opposite of 'ascend' is:", options: ["descend", "climb", "rise", "increase"], correctAnswer: "descend", category: .vocabulary),
        EnglishQuestion(question: "A 'cockpit' is:", options: ["passenger cabin", "pilot's compartment", "cargo area", "fuel tank"], correctAnswer: "pilot's compartment", category: .vocabulary),
        EnglishQuestion(question: "'Turbulence' refers to:", options: ["smooth air", "irregular air movement", "high altitude", "low pressure"], correctAnswer: "irregular air movement", category: .vocabulary),
        EnglishQuestion(question: "'Altitude' refers to:", options: ["speed", "direction", "height", "distance"], correctAnswer: "height", category: .vocabulary),
        EnglishQuestion(question: "'To abort' a mission means to:", options: ["complete it", "cancel it", "extend it", "plan it"], correctAnswer: "cancel it", category: .vocabulary),
        EnglishQuestion(question: "The 'fuselage' is the:", options: ["wing", "tail", "main body", "engine"], correctAnswer: "main body", category: .vocabulary),
        EnglishQuestion(question: "'Clearance' in aviation means:", options: ["cleaning", "authorization", "visibility", "distance"], correctAnswer: "authorization", category: .vocabulary),
        EnglishQuestion(question: "A 'headwind' is a wind that:", options: ["comes from behind", "comes from ahead", "comes from the side", "goes upward"], correctAnswer: "comes from ahead", category: .vocabulary),
        EnglishQuestion(question: "'To taxi' means to:", options: ["take off", "land", "move on ground", "fly"], correctAnswer: "move on ground", category: .vocabulary),
        EnglishQuestion(question: "'Mayday' is used for:", options: ["routine calls", "emergencies", "weather reports", "navigation"], correctAnswer: "emergencies", category: .vocabulary),
        EnglishQuestion(question: "'ETA' stands for:", options: ["Estimated Time of Arrival", "Engine Test Alert", "Exit Through Aisle", "Emergency Team Action"], correctAnswer: "Estimated Time of Arrival", category: .vocabulary),
        EnglishQuestion(question: "A 'briefing' is a:", options: ["short meeting for information", "long report", "written document", "technical manual"], correctAnswer: "short meeting for information", category: .vocabulary),
        EnglishQuestion(question: "A 'tailwind' helps the plane to:", options: ["slow down", "speed up", "turn", "climb"], correctAnswer: "speed up", category: .vocabulary),
        EnglishQuestion(question: "'To navigate' means to:", options: ["fly fast", "direct a course", "land", "take off"], correctAnswer: "direct a course", category: .vocabulary),
        EnglishQuestion(question: "The 'runway' is used for:", options: ["parking", "takeoff and landing", "maintenance", "refueling"], correctAnswer: "takeoff and landing", category: .vocabulary),

        // Common Synonyms
        EnglishQuestion(question: "The word 'expedite' means:", options: ["delay", "speed up", "cancel", "postpone"], correctAnswer: "speed up", category: .vocabulary),
        EnglishQuestion(question: "A synonym for 'urgent' is:", options: ["patient", "pressing", "slow", "relaxed"], correctAnswer: "pressing", category: .vocabulary),
        EnglishQuestion(question: "A synonym for 'commence' is:", options: ["end", "begin", "pause", "stop"], correctAnswer: "begin", category: .vocabulary),
        EnglishQuestion(question: "A synonym for 'concise' is:", options: ["long", "brief", "detailed", "complex"], correctAnswer: "brief", category: .vocabulary),
        EnglishQuestion(question: "A synonym for 'terminate' is:", options: ["start", "end", "continue", "pause"], correctAnswer: "end", category: .vocabulary),
        EnglishQuestion(question: "A synonym for 'acquire' is:", options: ["lose", "obtain", "give", "sell"], correctAnswer: "obtain", category: .vocabulary),
        EnglishQuestion(question: "A synonym for 'enhance' is:", options: ["reduce", "improve", "maintain", "decrease"], correctAnswer: "improve", category: .vocabulary),
        EnglishQuestion(question: "A synonym for 'verify' is:", options: ["deny", "confirm", "doubt", "reject"], correctAnswer: "confirm", category: .vocabulary),
        EnglishQuestion(question: "A synonym for 'significant' is:", options: ["minor", "important", "trivial", "small"], correctAnswer: "important", category: .vocabulary),
        EnglishQuestion(question: "A synonym for 'demonstrate' is:", options: ["hide", "show", "conceal", "suppress"], correctAnswer: "show", category: .vocabulary),

        // Common Antonyms
        EnglishQuestion(question: "The opposite of 'depart' is:", options: ["leave", "arrive", "exit", "go"], correctAnswer: "arrive", category: .vocabulary),
        EnglishQuestion(question: "The opposite of 'increase' is:", options: ["grow", "decrease", "expand", "rise"], correctAnswer: "decrease", category: .vocabulary),
        EnglishQuestion(question: "The opposite of 'accept' is:", options: ["agree", "reject", "receive", "take"], correctAnswer: "reject", category: .vocabulary),
        EnglishQuestion(question: "The opposite of 'temporary' is:", options: ["brief", "permanent", "short", "fleeting"], correctAnswer: "permanent", category: .vocabulary),
        EnglishQuestion(question: "The opposite of 'success' is:", options: ["victory", "failure", "achievement", "win"], correctAnswer: "failure", category: .vocabulary),
        EnglishQuestion(question: "The opposite of 'maximum' is:", options: ["most", "minimum", "highest", "greatest"], correctAnswer: "minimum", category: .vocabulary),
        EnglishQuestion(question: "The opposite of 'ancient' is:", options: ["old", "modern", "historic", "antique"], correctAnswer: "modern", category: .vocabulary),
        EnglishQuestion(question: "The opposite of 'mandatory' is:", options: ["required", "optional", "compulsory", "necessary"], correctAnswer: "optional", category: .vocabulary),
        EnglishQuestion(question: "The opposite of 'complex' is:", options: ["complicated", "simple", "difficult", "hard"], correctAnswer: "simple", category: .vocabulary),
        EnglishQuestion(question: "The opposite of 'expand' is:", options: ["grow", "contract", "increase", "enlarge"], correctAnswer: "contract", category: .vocabulary),

        // Business/Professional Vocabulary
        EnglishQuestion(question: "'Deadline' means:", options: ["start date", "final date", "meeting", "project"], correctAnswer: "final date", category: .vocabulary),
        EnglishQuestion(question: "'To delegate' means to:", options: ["do yourself", "assign to others", "ignore", "forget"], correctAnswer: "assign to others", category: .vocabulary),
        EnglishQuestion(question: "'Feasible' means:", options: ["impossible", "possible", "unlikely", "difficult"], correctAnswer: "possible", category: .vocabulary),
        EnglishQuestion(question: "'To implement' means to:", options: ["plan", "put into action", "think about", "consider"], correctAnswer: "put into action", category: .vocabulary),
        EnglishQuestion(question: "'Priority' refers to:", options: ["last item", "most important item", "optional task", "minor detail"], correctAnswer: "most important item", category: .vocabulary),
        EnglishQuestion(question: "'To collaborate' means to:", options: ["work alone", "work together", "compete", "argue"], correctAnswer: "work together", category: .vocabulary),
        EnglishQuestion(question: "'Efficient' means:", options: ["wasteful", "productive", "slow", "lazy"], correctAnswer: "productive", category: .vocabulary),
        EnglishQuestion(question: "'To comply' means to:", options: ["refuse", "follow rules", "argue", "disagree"], correctAnswer: "follow rules", category: .vocabulary),
        EnglishQuestion(question: "'Agenda' refers to:", options: ["random topics", "list of items to discuss", "final report", "conclusion"], correctAnswer: "list of items to discuss", category: .vocabulary),
        EnglishQuestion(question: "'To postpone' means to:", options: ["cancel", "delay", "advance", "finish"], correctAnswer: "delay", category: .vocabulary),

        // Academic/Formal Vocabulary
        EnglishQuestion(question: "'To analyze' means to:", options: ["ignore", "examine in detail", "summarize", "skip"], correctAnswer: "examine in detail", category: .vocabulary),
        EnglishQuestion(question: "'Hypothesis' is a:", options: ["proven fact", "tentative explanation", "final conclusion", "random guess"], correctAnswer: "tentative explanation", category: .vocabulary),
        EnglishQuestion(question: "'Relevant' means:", options: ["unimportant", "connected to the topic", "random", "outdated"], correctAnswer: "connected to the topic", category: .vocabulary),
        EnglishQuestion(question: "'To evaluate' means to:", options: ["ignore", "assess", "forget", "skip"], correctAnswer: "assess", category: .vocabulary),
        EnglishQuestion(question: "'Comprehensive' means:", options: ["partial", "complete", "basic", "simple"], correctAnswer: "complete", category: .vocabulary),
        EnglishQuestion(question: "'To summarize' means to:", options: ["expand", "give main points briefly", "detail", "elaborate"], correctAnswer: "give main points briefly", category: .vocabulary),
        EnglishQuestion(question: "'Adequate' means:", options: ["insufficient", "enough", "excessive", "lacking"], correctAnswer: "enough", category: .vocabulary),
        EnglishQuestion(question: "'To clarify' means to:", options: ["confuse", "make clear", "complicate", "obscure"], correctAnswer: "make clear", category: .vocabulary),
        EnglishQuestion(question: "'Objective' means:", options: ["biased", "impartial", "subjective", "personal"], correctAnswer: "impartial", category: .vocabulary),
        EnglishQuestion(question: "'To deduce' means to:", options: ["guess randomly", "conclude logically", "assume", "imagine"], correctAnswer: "conclude logically", category: .vocabulary),

        // Common Confusing Words
        EnglishQuestion(question: "'Affect' is usually a ___, 'effect' is usually a ___.", options: ["noun, verb", "verb, noun", "both verbs", "both nouns"], correctAnswer: "verb, noun", category: .vocabulary),
        EnglishQuestion(question: "To 'accept' means to receive; to 'except' means to:", options: ["receive", "exclude", "include", "accept"], correctAnswer: "exclude", category: .vocabulary),
        EnglishQuestion(question: "'Principal' (main) vs 'principle' (rule) - The ___ reason is important.", options: ["principle", "principal", "both", "neither"], correctAnswer: "principal", category: .vocabulary),
        EnglishQuestion(question: "'Stationary' means not moving; 'stationery' means:", options: ["movement", "writing materials", "standing still", "fixed"], correctAnswer: "writing materials", category: .vocabulary),
        EnglishQuestion(question: "'Complement' completes; 'compliment' means:", options: ["to add", "to praise", "to complete", "to finish"], correctAnswer: "to praise", category: .vocabulary),
        EnglishQuestion(question: "'Loose' means not tight; 'lose' means:", options: ["to win", "to fail to keep", "to loosen", "to release"], correctAnswer: "to fail to keep", category: .vocabulary),
        EnglishQuestion(question: "'Their' is possessive; 'there' indicates:", options: ["ownership", "place", "time", "action"], correctAnswer: "place", category: .vocabulary),
        EnglishQuestion(question: "'Weather' refers to atmospheric conditions; 'whether' is:", options: ["a conjunction", "a noun", "an adjective", "a verb"], correctAnswer: "a conjunction", category: .vocabulary),
        EnglishQuestion(question: "'Advice' (noun) vs 'advise' (verb) - I ___ you to study.", options: ["advice", "advise", "both", "neither"], correctAnswer: "advise", category: .vocabulary),
        EnglishQuestion(question: "'Ensure' means to make certain; 'insure' relates to:", options: ["certainty", "insurance", "security", "safety"], correctAnswer: "insurance", category: .vocabulary),

        // Idioms and Expressions
        EnglishQuestion(question: "'To break the ice' means to:", options: ["freeze something", "start a conversation", "end a meeting", "cause problems"], correctAnswer: "start a conversation", category: .vocabulary),
        EnglishQuestion(question: "'Once in a blue moon' means:", options: ["frequently", "rarely", "always", "sometimes"], correctAnswer: "rarely", category: .vocabulary),
        EnglishQuestion(question: "'To be on the same page' means:", options: ["reading together", "to agree", "to disagree", "same book"], correctAnswer: "to agree", category: .vocabulary),
        EnglishQuestion(question: "'A piece of cake' means something is:", options: ["delicious", "easy", "difficult", "sweet"], correctAnswer: "easy", category: .vocabulary),
        EnglishQuestion(question: "'To cost an arm and a leg' means:", options: ["cheap", "very expensive", "painful", "dangerous"], correctAnswer: "very expensive", category: .vocabulary),
        EnglishQuestion(question: "'Under the weather' means:", options: ["outside", "feeling ill", "in rain", "cold"], correctAnswer: "feeling ill", category: .vocabulary),
        EnglishQuestion(question: "'To beat around the bush' means to:", options: ["be direct", "avoid the main topic", "garden", "hurry"], correctAnswer: "avoid the main topic", category: .vocabulary),
        EnglishQuestion(question: "'The ball is in your court' means:", options: ["playing tennis", "it's your decision", "sports", "games"], correctAnswer: "it's your decision", category: .vocabulary),
        EnglishQuestion(question: "'To bite off more than you can chew' means:", options: ["eating too much", "take on too much", "hungry", "greedy"], correctAnswer: "take on too much", category: .vocabulary),
        EnglishQuestion(question: "'Hit the nail on the head' means:", options: ["construction", "be exactly right", "hurt yourself", "working"], correctAnswer: "be exactly right", category: .vocabulary),

        // Technical/General Vocabulary
        EnglishQuestion(question: "'Simultaneous' means:", options: ["one after another", "at the same time", "before", "after"], correctAnswer: "at the same time", category: .vocabulary),
        EnglishQuestion(question: "'Approximate' means:", options: ["exact", "nearly correct", "precise", "accurate"], correctAnswer: "nearly correct", category: .vocabulary),
        EnglishQuestion(question: "'Subsequent' means:", options: ["before", "following", "previous", "prior"], correctAnswer: "following", category: .vocabulary),
        EnglishQuestion(question: "'Preliminary' means:", options: ["final", "introductory", "last", "concluding"], correctAnswer: "introductory", category: .vocabulary),
        EnglishQuestion(question: "'Consecutive' means:", options: ["random", "in a row", "scattered", "occasional"], correctAnswer: "in a row", category: .vocabulary),
        EnglishQuestion(question: "'Unanimous' means:", options: ["divided", "all in agreement", "partial", "some"], correctAnswer: "all in agreement", category: .vocabulary),
        EnglishQuestion(question: "'Inevitable' means:", options: ["avoidable", "unavoidable", "possible", "unlikely"], correctAnswer: "unavoidable", category: .vocabulary),
        EnglishQuestion(question: "'Ambiguous' means:", options: ["clear", "unclear", "obvious", "certain"], correctAnswer: "unclear", category: .vocabulary),
        EnglishQuestion(question: "'Redundant' means:", options: ["necessary", "unnecessary/repetitive", "important", "essential"], correctAnswer: "unnecessary/repetitive", category: .vocabulary),
        EnglishQuestion(question: "'Obsolete' means:", options: ["new", "outdated", "modern", "current"], correctAnswer: "outdated", category: .vocabulary),
        EnglishQuestion(question: "'Meticulous' means:", options: ["careless", "very careful", "quick", "lazy"], correctAnswer: "very careful", category: .vocabulary),
        EnglishQuestion(question: "'Profound' means:", options: ["shallow", "very deep", "simple", "basic"], correctAnswer: "very deep", category: .vocabulary),
        EnglishQuestion(question: "'Fluctuate' means to:", options: ["stay constant", "vary irregularly", "remain stable", "fix"], correctAnswer: "vary irregularly", category: .vocabulary),
        EnglishQuestion(question: "'Deteriorate' means to:", options: ["improve", "get worse", "enhance", "better"], correctAnswer: "get worse", category: .vocabulary),
        EnglishQuestion(question: "'Accelerate' means to:", options: ["slow down", "speed up", "stop", "pause"], correctAnswer: "speed up", category: .vocabulary),
    ]
}

// MARK: - ViewModel
@MainActor
@Observable
final class AnglaisQCMViewModel {
    var questions: [EnglishQuestion] = []
    var currentIndex: Int = 0
    var totalQuestions: Int = 30
    var timeRemaining: Int = 450 // 7min30 = 450 secondes
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var selectedAnswer: String?
    var showFeedback: Bool = false
    var shuffledOptions: [String] = [] // Options mélangées pour la question actuelle

    private var timerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    var currentQuestion: EnglishQuestion? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    var accuracy: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }

    /// Écart au rythme nécessaire pour traiter toutes les questions, en
    /// secondes : positif si le candidat est en avance.
    ///
    /// Les candidats citent la gestion du temps comme leur principale
    /// difficulté sur cette épreuve ; sans repère, on ne s'aperçoit du retard
    /// qu'une fois qu'il est trop tard.
    var avanceSurLeRythme: Int {
        guard totalQuestions > 0 else { return 0 }
        let budgetParQuestion = Double(dureeTotale) / Double(totalQuestions)
        let attenduRestant = budgetParQuestion * Double(totalQuestions - currentIndex)
        return timeRemaining - Int(attenduRestant.rounded())
    }

    static let dureeTotale = 450
    var dureeTotale: Int { Self.dureeTotale }

    func startGame() {
        // Sélectionner 30 questions aléatoires parmi 300
        // Sert d'abord les questions jamais vues, pour qu'un candidat qui
        // enchaîne les parties parcoure toute la banque avant de recroiser
        // une question.
        questions = BanqueRotation.tirer(EnglishQuestion.allQuestions,
                                         nombre: totalQuestions,
                                         cle: "anglais") { $0.question }

        currentIndex = 0
        timeRemaining = 450
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        selectedAnswer = nil
        showFeedback = false
        shuffleCurrentOptions()
        startTimer()
    }

    private func shuffleCurrentOptions() {
        if let question = currentQuestion {
            shuffledOptions = question.options.shuffled()
        }
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 450) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            endGame()
        }
    }

    func selectAnswer(_ answer: String) {
        guard selectedAnswer == nil, let question = currentQuestion else { return }

        // Le chrono se suspend pendant l'affichage de la correction : sur
        // trente questions, ces attentes prélevaient une vingtaine de secondes
        // sur un budget de 450, sans que le joueur puisse rien en faire.
        timerTask?.cancel()
        selectedAnswer = answer
        showFeedback = true

        if answer == question.correctAnswer {
            correctAnswers += 1
            HapticManager.success()
        } else {
            wrongAnswers += 1
            HapticManager.error()
        }

        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(800))
            if Task.isCancelled { return }
            moveToNext()
        }
    }

    private func moveToNext() {
        currentIndex += 1
        selectedAnswer = nil
        showFeedback = false

        if currentIndex >= questions.count {
            endGame()
        } else {
            shuffleCurrentOptions()
            reprendreTimer()
        }
    }

    /// Relance le compte à rebours là où il s'était arrêté.
    private func reprendreTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: TimeInterval(timeRemaining)) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            endGame()
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
        return GameResult(gameType: .anglaisQCM, score: Double(correctAnswers),
                          correctAnswers: correctAnswers, totalItems: totalQuestions,
                          duration: Double(450 - timeRemaining))
    }

    func stopGame() {
        timerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - View
struct AnglaisQCMView: View {
    @State private var viewModel = AnglaisQCMViewModel()

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
        .navigationTitle("Anglais")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .anglaisQCM)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Anglais QCM",
                    rules: [
                        RuleItem(icon: "list.bullet", text: "30 QCM (grammaire + vocabulaire)"),
                        RuleItem(icon: "timer", text: "7 minutes 30 au total"),
                        RuleItem(icon: "clock", text: "~15 secondes par question"),
                        RuleItem(icon: "shuffle", text: "Questions aléatoires parmi 300")
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

            Image(systemName: "textformat.abc")
                .font(.system(size: 80))
                .foregroundStyle(Theme.accentViolet)

            Text("Test d'Anglais")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("30 QCM (grammaire + vocabulaire)", systemImage: "list.bullet")
                    Label("7 minutes 30 au total", systemImage: "timer")
                    Label("~15 secondes par question", systemImage: "clock")
                    Label("Questions aléatoires parmi 300", systemImage: "shuffle")
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
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Q\(viewModel.currentIndex + 1)/\(viewModel.totalQuestions)")
                    .font(.headline)

                Spacer()

                // Timer
                Text(viewModel.timeString)
                    .font(.title3.monospacedDigit().weight(.semibold))
                    .foregroundStyle(viewModel.timeRemaining < 60 ? .red : .primary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Theme.surface)
                    .clipShape(Capsule())
            }

            // Score
            HStack(spacing: 16) {
                Label("\(viewModel.correctAnswers)", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(Theme.vert)
                Label("\(viewModel.wrongAnswers)", systemImage: "xmark.circle.fill")
                    .foregroundStyle(Theme.rouge)
            }
            .font(.subheadline)

            Spacer()

            if let question = viewModel.currentQuestion {
                // Category badge
                Text(question.category.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Theme.accentViolet.opacity(0.15))
                    .foregroundStyle(Theme.rouge)
                    .clipShape(Capsule())

                // Question
                Text(question.question)
                    .font(.title3.weight(.medium))
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                // Options (mélangées)
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
                }
            }

            Spacer()
        }
    }

    private func optionBackground(_ option: String, question: EnglishQuestion) -> Color {
        if viewModel.showFeedback {
            if option == question.correctAnswer {
                return Theme.vert
            } else if option == viewModel.selectedAnswer {
                return Theme.rouge
            }
        }
        return Color(.systemGray5)
    }

    private func optionForeground(_ option: String, question: EnglishQuestion) -> Color {
        if viewModel.showFeedback && (option == question.correctAnswer || option == viewModel.selectedAnswer) {
            return .white
        }
        return .primary
    }

    private var gameOverView: some View {
        VStack(spacing: 32) {
            Spacer()

            EnTeteDeFin(taux: viewModel.accuracy)

            VStack(spacing: 16) {
                ResultRow(label: "Bonnes réponses", value: "\(viewModel.correctAnswers)")
                ResultRow(label: "Mauvaises réponses", value: "\(viewModel.wrongAnswers)")
                ResultRow(label: "Non répondues", value: "\(viewModel.totalQuestions - viewModel.correctAnswers - viewModel.wrongAnswers)")
                Divider()
                ResultRow(label: "Précision", value: String(format: "%.0f%%", viewModel.accuracy))
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
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnglaisQCMView()
    }
}
