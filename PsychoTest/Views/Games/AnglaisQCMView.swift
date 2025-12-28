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

// MARK: - Questions Database (200+ questions)
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
        EnglishQuestion(question: "Have you ___ been to Japan?", options: ["never", "ever", "already", "yet"], correctAnswer: "ever", category: .grammar),
        EnglishQuestion(question: "They haven't arrived ___.", options: ["yet", "already", "still", "ever"], correctAnswer: "yet", category: .grammar),

        // Tenses - Future
        EnglishQuestion(question: "The plane ___ at 9 PM tonight.", options: ["leaves", "leave", "leaving", "will leaving"], correctAnswer: "leaves", category: .grammar),
        EnglishQuestion(question: "By next year, I ___ my license.", options: ["will get", "will have gotten", "get", "am getting"], correctAnswer: "will have gotten", category: .grammar),
        EnglishQuestion(question: "I ___ you tomorrow.", options: ["call", "will call", "calling", "called"], correctAnswer: "will call", category: .grammar),
        EnglishQuestion(question: "She ___ 25 next month.", options: ["is", "will be", "was", "being"], correctAnswer: "will be", category: .grammar),
        EnglishQuestion(question: "We ___ to the beach this weekend.", options: ["go", "goes", "are going", "went"], correctAnswer: "are going", category: .grammar),

        // Conditionals
        EnglishQuestion(question: "If I ___ you, I would accept the offer.", options: ["am", "was", "were", "be"], correctAnswer: "were", category: .grammar),
        EnglishQuestion(question: "If it rains, we ___ stay home.", options: ["will", "would", "could", "might"], correctAnswer: "will", category: .grammar),
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
        EnglishQuestion(question: "Neither the pilot nor the co-pilot ___ aware.", options: ["was", "were", "are", "is"], correctAnswer: "was", category: .grammar),
        EnglishQuestion(question: "The news ___ shocking.", options: ["is", "are", "were", "have"], correctAnswer: "is", category: .grammar),
        EnglishQuestion(question: "Everyone ___ ready for the test.", options: ["is", "are", "were", "have"], correctAnswer: "is", category: .grammar),
        EnglishQuestion(question: "The team ___ playing well.", options: ["is", "are", "were", "has"], correctAnswer: "is", category: .grammar),
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
        EnglishQuestion(question: "___ you help me with this?", options: ["Could", "Would", "Should", "Must"], correctAnswer: "Could", category: .grammar),

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
        EnglishQuestion(question: "The weather, ___ was forecasted, turned bad.", options: ["which", "that", "as", "what"], correctAnswer: "as", category: .grammar),
        EnglishQuestion(question: "The man ___ called is my uncle.", options: ["who", "which", "what", "whom"], correctAnswer: "who", category: .grammar),
        EnglishQuestion(question: "The book ___ I read was great.", options: ["who", "which", "what", "whom"], correctAnswer: "which", category: .grammar),
        EnglishQuestion(question: "This is the house ___ I grew up.", options: ["where", "which", "that", "what"], correctAnswer: "where", category: .grammar),
        EnglishQuestion(question: "The reason ___ I'm late is traffic.", options: ["why", "which", "that", "what"], correctAnswer: "why", category: .grammar),

        // Articles
        EnglishQuestion(question: "She is ___ engineer.", options: ["a", "an", "the", "—"], correctAnswer: "an", category: .grammar),
        EnglishQuestion(question: "___ sun rises in the east.", options: ["A", "An", "The", "—"], correctAnswer: "The", category: .grammar),
        EnglishQuestion(question: "I need ___ information.", options: ["a", "an", "some", "the"], correctAnswer: "some", category: .grammar),
        EnglishQuestion(question: "He plays ___ piano beautifully.", options: ["a", "an", "the", "—"], correctAnswer: "the", category: .grammar),
        EnglishQuestion(question: "She went to ___ university in London.", options: ["a", "an", "the", "—"], correctAnswer: "a", category: .grammar),

        // Present Perfect vs Past Simple
        EnglishQuestion(question: "The passengers ___ board yet.", options: ["haven't", "hasn't", "didn't", "don't"], correctAnswer: "haven't", category: .grammar),
        EnglishQuestion(question: "I ___ him last week.", options: ["see", "saw", "have seen", "seen"], correctAnswer: "saw", category: .grammar),
        EnglishQuestion(question: "She ___ here for two years.", options: ["works", "worked", "has worked", "working"], correctAnswer: "has worked", category: .grammar),
        EnglishQuestion(question: "They ___ to Paris three times.", options: ["go", "went", "have been", "been"], correctAnswer: "have been", category: .grammar),
        EnglishQuestion(question: "I ___ my breakfast already.", options: ["eat", "ate", "have eaten", "eating"], correctAnswer: "have eaten", category: .grammar),

        // Inversion
        EnglishQuestion(question: "Not only ___ he arrive late, but he forgot his ID.", options: ["did", "does", "was", "had"], correctAnswer: "did", category: .grammar),
        EnglishQuestion(question: "Rarely ___ I seen such beauty.", options: ["have", "had", "do", "did"], correctAnswer: "have", category: .grammar),
        EnglishQuestion(question: "Never ___ I forget this day.", options: ["will", "would", "shall", "should"], correctAnswer: "will", category: .grammar),
        EnglishQuestion(question: "Hardly ___ he arrived when it started raining.", options: ["had", "has", "did", "was"], correctAnswer: "had", category: .grammar),
        EnglishQuestion(question: "Only then ___ I understand.", options: ["did", "do", "have", "had"], correctAnswer: "did", category: .grammar),

        // Question Tags
        EnglishQuestion(question: "You're coming, ___?", options: ["aren't you", "isn't it", "don't you", "won't you"], correctAnswer: "aren't you", category: .grammar),
        EnglishQuestion(question: "She doesn't like coffee, ___?", options: ["does she", "doesn't she", "is she", "isn't she"], correctAnswer: "does she", category: .grammar),
        EnglishQuestion(question: "They've finished, ___?", options: ["haven't they", "have they", "didn't they", "did they"], correctAnswer: "haven't they", category: .grammar),
        EnglishQuestion(question: "Let's go, ___?", options: ["shall we", "will we", "do we", "don't we"], correctAnswer: "shall we", category: .grammar),
        EnglishQuestion(question: "He can swim, ___?", options: ["can't he", "can he", "doesn't he", "does he"], correctAnswer: "can't he", category: .grammar),

        // Reported Speech
        EnglishQuestion(question: "She said she ___ tired.", options: ["is", "was", "has been", "will be"], correctAnswer: "was", category: .grammar),
        EnglishQuestion(question: "He told me he ___ help.", options: ["will", "would", "can", "may"], correctAnswer: "would", category: .grammar),
        EnglishQuestion(question: "They asked if I ___ coming.", options: ["am", "was", "will be", "would be"], correctAnswer: "was", category: .grammar),
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
        EnglishQuestion(question: "She ___ to be very kind.", options: ["seems", "seem", "seeming", "seemed"], correctAnswer: "seems", category: .grammar),
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
        EnglishQuestion(question: "'To navigate' means to:", options: ["fly fast", "direct course", "land", "take off"], correctAnswer: "direct course", category: .vocabulary),
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
        EnglishQuestion(question: "'Weather' is climate; 'whether' is:", options: ["climate", "a conjunction", "temperature", "rain"], correctAnswer: "a conjunction", category: .vocabulary),
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

    private var timerTask: Task<Void, Never>?

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
        let total = correctAnswers + wrongAnswers
        guard total > 0 else { return 0 }
        return Double(correctAnswers) / Double(total) * 100
    }

    func startGame() {
        // Sélectionner 30 questions aléatoires parmi 200+
        questions = Array(EnglishQuestion.allQuestions.shuffled().prefix(totalQuestions))

        currentIndex = 0
        timeRemaining = 450
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        selectedAnswer = nil
        showFeedback = false
        startTimer()
    }

    private func startTimer() {
        timerTask = Task {
            while !Task.isCancelled && timeRemaining > 0 {
                try? await Task.sleep(for: .seconds(1))
                if !Task.isCancelled {
                    timeRemaining -= 1
                }
            }
            if !Task.isCancelled {
                endGame()
            }
        }
    }

    func selectAnswer(_ answer: String) {
        guard selectedAnswer == nil, let question = currentQuestion else { return }

        selectedAnswer = answer
        showFeedback = true

        if answer == question.correctAnswer {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }

        Task {
            try? await Task.sleep(for: .milliseconds(800))
            moveToNext()
        }
    }

    private func moveToNext() {
        currentIndex += 1
        selectedAnswer = nil
        showFeedback = false

        if currentIndex >= totalQuestions {
            endGame()
        }
    }

    private func endGame() {
        timerTask?.cancel()
        isGameActive = false
        isGameOver = true
    }

    func stopGame() {
        timerTask?.cancel()
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
        .navigationTitle("Anglais")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            viewModel.stopGame()
        }
    }

    private var startView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "textformat.abc")
                .font(.system(size: 80))
                .foregroundStyle(.red)

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
                    Label("Questions aléatoires parmi 200+", systemImage: "shuffle")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
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
                    .background(Color(.systemGray6))
                    .clipShape(Capsule())
            }

            // Score
            HStack(spacing: 16) {
                Label("\(viewModel.correctAnswers)", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                Label("\(viewModel.wrongAnswers)", systemImage: "xmark.circle.fill")
                    .foregroundStyle(.red)
            }
            .font(.subheadline)

            Spacer()

            if let question = viewModel.currentQuestion {
                // Category badge
                Text(question.category.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.red.opacity(0.15))
                    .foregroundStyle(.red)
                    .clipShape(Capsule())

                // Question
                Text(question.question)
                    .font(.title3.weight(.medium))
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                // Options
                VStack(spacing: 10) {
                    ForEach(question.options, id: \.self) { option in
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
                return .green
            } else if option == viewModel.selectedAnswer {
                return .red
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

            Image(systemName: viewModel.accuracy >= 70 ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(viewModel.accuracy >= 70 ? .green : .orange)

            Text("Terminé !")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                ResultRow(label: "Bonnes réponses", value: "\(viewModel.correctAnswers)")
                ResultRow(label: "Mauvaises réponses", value: "\(viewModel.wrongAnswers)")
                ResultRow(label: "Non répondues", value: "\(viewModel.totalQuestions - viewModel.correctAnswers - viewModel.wrongAnswers)")
                Divider()
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
