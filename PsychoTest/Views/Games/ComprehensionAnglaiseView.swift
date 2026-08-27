import SwiftUI
import AVFoundation

// MARK: - Modèle

/// Comment le texte est présenté au candidat.
enum ModeTexte: String {
    case lecture
    case ecoute
}

struct QuestionTexte: Equatable {
    let question: String
    let options: [String]
    let correctAnswer: String
}

/// Un texte de compréhension et ses questions.
///
/// À partir de 2026, l'anglais du PSY0 évalue Listening, Reading et Speaking,
/// et le TOEIC n'est plus exigé : la compréhension écrite et orale devient
/// donc une épreuve à part entière, distincte du QCM de grammaire.
struct TexteAnglais {
    let titre: String
    let mode: ModeTexte
    let texte: String
    let questions: [QuestionTexte]
}

enum ComprehensionGenerator {
    static let tous: [TexteAnglais] = [
        TexteAnglais(
            titre: "Life on the Line",
            mode: .lecture,
            texte: "Ask airline pilots what surprised them most about the job, and few mention the flying itself. What catches newcomers off guard is the paperwork of time: a career measured in duty periods, rest minima and rosters published a fortnight ahead. A long-haul captain may cross eight time zones on Monday and be told to sleep at noon on Wednesday, not because she feels tired but because the return flight demands it. Sleep becomes a professional skill rather than a private habit.\n\nThe flying hours themselves are famously uneven. Cruise can be quiet for hours, punctuated by radio calls and fuel checks, while the twenty minutes of an approach into a crowded European hub demand everything at once. Pilots describe the job as long stretches of routine framed by short bursts of concentrated decision-making — and insist that the routine is precisely what makes the bursts manageable.\n\nThen there is the crew. On most airlines, the two people sharing a flight deck have never met before the briefing and will not fly together again. Standard procedures, identical training and a shared vocabulary make that possible. Strangers become a functioning team in twenty minutes, which is perhaps the profession's least celebrated achievement.",
            questions: [
                QuestionTexte(question: "Why does the long-haul captain go to sleep at noon on Wednesday?", options: ["Because jet lag has left her exhausted at that hour", "Because she must be rested for a duty that starts later", "Because company rules forbid activity between flights", "Because she was unable to sleep the previous night"], correctAnswer: "Because she must be rested for a duty that starts later"),
                QuestionTexte(question: "What does the sentence \"Sleep becomes a professional skill rather than a private habit\" suggest?", options: ["Pilots sleep considerably less than people in other jobs", "Pilots must manage their sleep deliberately as part of the work", "Airlines monitor how many hours their pilots sleep at home", "Pilots learn to fall asleep in almost any environment"], correctAnswer: "Pilots must manage their sleep deliberately as part of the work"),
                QuestionTexte(question: "According to pilots quoted in the text, what makes the intense phases of a flight manageable?", options: ["The long routine periods that surround them", "The small number of aircraft near major hubs", "The fact that approaches last only twenty minutes", "The presence of automation during the approach"], correctAnswer: "The long routine periods that surround them"),
                QuestionTexte(question: "What does the text present as remarkable about airline crews?", options: ["That colleagues who are strangers form an effective team almost immediately", "That airlines deliberately avoid pairing the same pilots twice", "That pilots build lasting friendships during pre-flight briefings", "That crews are chosen for their compatible personalities"], correctAnswer: "That colleagues who are strangers form an effective team almost immediately"),
                QuestionTexte(question: "How would you describe the author's attitude to the profession?", options: ["Critical of rosters that damage pilots' health", "Admiring of an aspect of the job that usually goes unnoticed", "Nostalgic for a time when flying was less regulated", "Neutral and purely technical throughout"], correctAnswer: "Admiring of an aspect of the job that usually goes unnoticed")
            ]
        ),
        TexteAnglais(
            titre: "The Quiet Jet",
            mode: .lecture,
            texte: "When the Sud Aviation Caravelle first flew in the mid-1950s, its designers had made a decision that looked eccentric and turned out to be inspired: they moved the engines off the wings and bolted them to the rear fuselage. Rivals kept their engines under the wing, where they were easier to reach. The Caravelle's arrangement left the wing clean and the cabin remarkably quiet, since the noise was now behind the passengers rather than beside them.\n\nAirlines noticed. The aircraft had been designed for short European sectors at a time when most jets were being built to cross oceans, and it arrived exactly as the continent's business traffic was expanding. Passengers who had endured the vibration of piston airliners found the difference startling; crews appreciated an aeroplane that could operate from modest runways.\n\nThe Caravelle also borrowed its nose and cockpit from the British Comet, under an agreement with de Havilland that saved years of development. That pragmatism was typical of the programme. The type was eventually overtaken by aircraft carrying more passengers on less fuel, but its silhouette shaped a generation of designs, and for a decade it gave European manufacturers something they had badly lacked: proof that they could sell a jet abroad.",
            questions: [
                QuestionTexte(question: "Why was the cabin of the Caravelle unusually quiet?", options: ["Because its engines were quieter than those of its rivals", "Because the source of the noise had been moved behind the passengers", "Because the clean wing generated less turbulence in the cabin", "Because it flew shorter sectors at lower power settings"], correctAnswer: "Because the source of the noise had been moved behind the passengers"),
                QuestionTexte(question: "What made the Caravelle commercially well timed?", options: ["It was the first jet airliner ever built in Europe", "It could fly transatlantic routes more cheaply than its rivals", "It suited short routes just as European business traffic was growing", "It was the only jet able to use runways of any length"], correctAnswer: "It suited short routes just as European business traffic was growing"),
                QuestionTexte(question: "What does the agreement with de Havilland illustrate about the programme?", options: ["A readiness to reuse an existing solution in order to save time", "That the aircraft was essentially a copy of the Comet", "That British firms controlled French aircraft design", "That the Comet's cockpit was considered the safest available"], correctAnswer: "A readiness to reuse an existing solution in order to save time"),
                QuestionTexte(question: "What lasting importance does the text attribute to the Caravelle?", options: ["It showed that European manufacturers could compete on export markets", "It made rear-mounted engines the standard for all later jets", "It brought the era of piston-engined airliners to an end", "It remained the most widely produced jet of its generation"], correctAnswer: "It showed that European manufacturers could compete on export markets")
            ]
        ),
        TexteAnglais(
            titre: "Listening to the Talking",
            mode: .lecture,
            texte: "There is a moment in every airline conversion course that instructors watch for. The trainee has learned the checklists, flown the simulator sessions and can recite the limitations of the aircraft from memory. Then something is deliberately allowed to go wrong at the worst possible moment, and the instructor stops looking at the flying and starts listening to the talking.\n\nModern training assumes that technical competence is the entry ticket, not the qualification. What separates a candidate who passes from one who does not is usually the ability to share a mental picture: to say out loud what is happening, to ask the other pilot for an opinion, and to accept being contradicted by someone junior. Airlines learned this expensively. A number of accidents decades ago involved aircraft that were perfectly serviceable and crews who were individually competent but collectively silent.\n\nSo the simulator has become a stage as much as a machine. Sessions are recorded and replayed, and the debriefing frequently spends more time on a hesitant sentence than on a rough landing. Trainees sometimes find this uncomfortable. Instructors regard the discomfort as the point: habits of communication cannot be improvised on the day they are needed.",
            questions: [
                QuestionTexte(question: "What does \"technical competence is the entry ticket, not the qualification\" mean here?", options: ["Technical skill matters less to airlines than it once did", "Mastering the aircraft is necessary but not enough to pass", "Only the most gifted technicians are admitted to the course", "The technical examination takes place before the course begins"], correctAnswer: "Mastering the aircraft is necessary but not enough to pass"),
                QuestionTexte(question: "Why is the failure introduced \"at the worst possible moment\"?", options: ["To reveal behaviours that only appear under real pressure", "To check that the trainee has memorised the correct procedure", "To make the course difficult enough to eliminate weak candidates", "To reproduce the type of failure that occurs most often in service"], correctAnswer: "To reveal behaviours that only appear under real pressure"),
                QuestionTexte(question: "What was the lesson drawn from the accidents mentioned?", options: ["That the aircraft of the period were technically unreliable", "That crews of that era had received insufficient technical training", "That competent individuals can fail as a team when nobody speaks up", "That junior pilots were promoted too quickly"], correctAnswer: "That competent individuals can fail as a team when nobody speaks up"),
                QuestionTexte(question: "Why does a debriefing dwell on a hesitant sentence rather than a rough landing?", options: ["Because hesitation shows that the crew's shared understanding broke down", "Because the landing is assessed by a different instructor", "Because trainees' English is being evaluated at the same time", "Because a rough landing has no consequence for safety"], correctAnswer: "Because hesitation shows that the crew's shared understanding broke down"),
                QuestionTexte(question: "How do instructors view the discomfort felt by trainees?", options: ["As a regrettable side effect of recording the sessions", "As evidence that the selection process failed", "As exactly what the exercise is meant to produce", "As a reason to shorten the debriefing"], correctAnswer: "As exactly what the exercise is meant to produce")
            ]
        ),
        TexteAnglais(
            titre: "Weak Signals",
            mode: .lecture,
            texte: "Few industries publish their mistakes as willingly as aviation. Airlines run confidential reporting schemes under which a crew member who has made an error — descended early, missed a call, taxied onto the wrong stretch of tarmac — can file a report and, in almost all circumstances, expect no disciplinary consequence. The logic is blunt: an organisation only learns from the events it hears about, and it hears about them only if telling the truth is safe.\n\nThe results are unglamorous and cumulative. A single report about a confusing taxiway sign rarely makes news. Fifty reports about the same sign, arriving from fifty different crews over two years, will eventually move an airport to repaint it. Analysts speak of \"weak signals\": individually trivial events whose repetition points to a design or a procedure that will one day trap someone less lucky.\n\nThe system has limits. Immunity does not extend to deliberate or reckless behaviour, and a reporting culture cannot survive if crews suspect that reports are quietly read by managers looking for names. Protecting the reporter is therefore not a courtesy but the mechanism itself. Where that trust erodes, reports do not stop being written — they stop being honest.",
            questions: [
                QuestionTexte(question: "Why do airlines choose not to punish crews who report their own errors?", options: ["Because most errors turn out not to be the crew's fault", "Because the information would otherwise never reach the organisation", "Because managers have no way of verifying what is reported", "Because such schemes are imposed on airlines by law"], correctAnswer: "Because the information would otherwise never reach the organisation"),
                QuestionTexte(question: "What is the point of the example of the taxiway sign?", options: ["That airports react far too slowly to safety concerns", "That repetition turns insignificant events into usable evidence", "That signage is the main cause of ground incidents", "That crews tend to complain about minor inconveniences"], correctAnswer: "That repetition turns insignificant events into usable evidence"),
                QuestionTexte(question: "According to the last sentence, what is the real danger when crews lose confidence in the system?", options: ["Reports continue to arrive but their content becomes unreliable", "Crews stop filing reports altogether", "Managers gain access to the names of those who report", "Airlines are forced to reintroduce disciplinary measures"], correctAnswer: "Reports continue to arrive but their content becomes unreliable"),
                QuestionTexte(question: "What does the phrase \"not a courtesy but the mechanism itself\" imply about protecting reporters?", options: ["That reporters deserve to be treated with respect by their managers", "That confidentiality is guaranteed to employees by their contract", "That the whole system stops working without that protection", "That politeness has no place in safety investigations"], correctAnswer: "That the whole system stops working without that protection")
            ]
        ),
        TexteAnglais(
            titre: "Eight Minutes Ahead",
            mode: .lecture,
            texte: "From the outside, an en-route control centre looks disappointing. There are no windows and nothing to see: a hall of dim screens, quiet voices and controllers who barely move. The drama is entirely internal.\n\nA controller working a busy sector may be responsible for twenty aircraft at once, each with its own speed, level and intention, and none of them visible. The skill is not reaction but projection: holding in mind where each aircraft will be in eight minutes, and noticing which two futures are about to collide. Experienced controllers describe building a mental picture that they update continuously, and they say the worst moment of a shift is not heavy traffic but interruption — a telephone call, a question from a colleague — after which the picture has to be rebuilt.\n\nLanguage is engineered accordingly. Standard phraseology exists to eliminate ambiguity: numbers are pronounced in a fixed way, instructions follow a fixed order, and the pilot reads back what was said so that a misheard word is caught immediately. It sounds robotic to a visitor. To the people using it, that flatness is a feature — nothing in the exchange invites interpretation, and everything can be checked.",
            questions: [
                QuestionTexte(question: "Why does the centre look \"disappointing\" to an outsider?", options: ["Because the demanding part of the work is invisible", "Because the equipment is visibly out of date", "Because too few controllers are on duty at any time", "Because the controllers themselves find the work monotonous"], correctAnswer: "Because the demanding part of the work is invisible"),
                QuestionTexte(question: "What does \"noticing which two futures are about to collide\" describe?", options: ["Identifying aircraft whose predicted paths would conflict", "Watching aircraft that are already dangerously close together", "Comparing two flight plans filed for the same route", "Anticipating which weather systems will affect the sector"], correctAnswer: "Identifying aircraft whose predicted paths would conflict"),
                QuestionTexte(question: "Why do controllers consider interruptions worse than heavy traffic?", options: ["Because they may miss a radio call while answering", "Because the mental picture must then be reconstructed from scratch", "Because colleagues rarely understand the sector being worked", "Because heavy traffic can always be predicted in advance"], correctAnswer: "Because the mental picture must then be reconstructed from scratch"),
                QuestionTexte(question: "Why do users defend the \"robotic\" character of standard phraseology?", options: ["Because it is a tradition inherited from early radio equipment", "Because its lack of expressiveness leaves no room for interpretation", "Because it was designed for controllers who are not native speakers", "Because it allows instructions to be transmitted more quickly"], correctAnswer: "Because its lack of expressiveness leaves no room for interpretation")
            ]
        ),
        TexteAnglais(
            titre: "A Chemistry Problem",
            mode: .lecture,
            texte: "Aviation has a chemistry problem. Batteries store far less energy per kilogram than kerosene, and an aircraft must carry its energy with it for the whole journey; the heavier the store, the less useful load remains. For very short hops the arithmetic is beginning to work. For a twelve-hour flight it is not close.\n\nThat is why much of the industry's attention has moved to fuels that behave exactly like kerosene but are made differently — from used cooking oil, from agricultural residues, or, more ambitiously, from hydrogen combined with carbon captured from the air. Their appeal is unromantic: they require no new aircraft, no new engines and no new pipelines. An existing fleet can burn them tomorrow.\n\nThe obstacles are volume and price. Such fuels represent a very small share of what airlines consume, and they cost substantially more than the fossil equivalent. Supporters argue that this is what every young industry looks like, and that mandates and long-term contracts will bring costs down. Sceptics reply that the feedstocks with the best economics are also the most limited, and that the harder question — how much flying, not merely how it is fuelled — is being politely postponed.",
            questions: [
                QuestionTexte(question: "Why are batteries described as unsuitable for long flights?", options: ["Because their weight for the energy they hold reduces the payload", "Because they cannot be recharged once the aircraft is airborne", "Because they lose efficiency at the temperatures found at altitude", "Because they cost far more than the equivalent quantity of kerosene"], correctAnswer: "Because their weight for the energy they hold reduces the payload"),
                QuestionTexte(question: "What is presented as the main advantage of the alternative fuels described?", options: ["They can be produced in unlimited quantities", "They are compatible with aircraft and infrastructure already in service", "They are already cheaper than fossil kerosene", "They deliver more thrust than conventional fuel"], correctAnswer: "They are compatible with aircraft and infrastructure already in service"),
                QuestionTexte(question: "What does the author mean by \"Their appeal is unromantic\"?", options: ["That they are made from unglamorous waste materials", "That their attraction lies in practicality rather than novelty", "That the public finds the idea difficult to accept", "That the companies producing them are poorly known"], correctAnswer: "That their attraction lies in practicality rather than novelty"),
                QuestionTexte(question: "What objection do sceptics raise?", options: ["That such fuels do not reduce emissions at all", "That the cheapest feedstocks exist only in limited quantities", "That airlines refuse to sign long-term supply contracts", "That mandates would be impossible to enforce"], correctAnswer: "That the cheapest feedstocks exist only in limited quantities"),
                QuestionTexte(question: "What does \"politely postponed\" suggest about the question of how much we fly?", options: ["That it has already been settled in favour of continued growth", "That it is being deliberately avoided rather than answered", "That regulators will decide it in the near future", "That everyone involved regards it as unimportant"], correctAnswer: "That it is being deliberately avoided rather than answered")
            ]
        ),
        TexteAnglais(
            titre: "Reading the Rings",
            mode: .lecture,
            texte: "Every year, a tree adds a new layer of wood beneath its bark. In temperate climates that layer forms a visible ring, wide in generous years and narrow when water is scarce. Because all the trees in one region live through the same weather, their rings share a pattern, and that shared pattern is what makes tree-ring dating possible.\n\nThe method rests on a procedure called cross-dating. Researchers begin with a living tree, whose outermost ring corresponds to the year it was sampled. They then look for an older timber, a beam from a farmhouse for instance, whose ring sequence overlaps with the early years of the living tree. Matching that overlap fixes the older sample in time, and the chain can be extended backwards, beam by beam, over thousands of years.\n\nThe results serve more than botany. Archaeologists date buildings to a precise year rather than a vague century. Climate specialists read the widths as a record of past droughts. Art historians examine the wooden panels behind old paintings, since a panel cannot have been painted before the tree that produced it was felled.\n\nThe limits matter too. Tropical trees, growing in constant warmth, often produce no clear annual rings at all, and where the outer rings have rotted away, only a minimum age can be established.",
            questions: [
                QuestionTexte(question: "How can a farmhouse beam be dated when no record of its felling survives?", options: ["Part of its ring sequence coincides with a sequence whose dates are already known", "The total number of its rings indicates the year in which it was cut", "Its outermost ring, like that of a living tree, corresponds to the year of sampling", "Farmhouse beams were traditionally cut in the year the house was built"], correctAnswer: "Part of its ring sequence coincides with a sequence whose dates are already known"),
                QuestionTexte(question: "Why does the author mention art historians?", options: ["To show that the method can establish the earliest date at which an object could have been made", "To show that paintings can be dated more precisely than buildings", "To suggest that old panels were usually cut from reused building beams", "To indicate that art historians were the first to apply the technique"], correctAnswer: "To show that the method can establish the earliest date at which an object could have been made"),
                QuestionTexte(question: "What follows from the fact that a timber's outer rings have decayed?", options: ["The date obtained tells us the tree was felled no earlier than that year, but possibly later", "The sample can no longer be dated by this method at all", "The remaining rings become too narrow to be measured reliably", "The timber must come from a species that grows in a warm climate"], correctAnswer: "The date obtained tells us the tree was felled no earlier than that year, but possibly later"),
                QuestionTexte(question: "Why is the technique of limited use in tropical regions?", options: ["A climate without marked seasons does not produce distinct yearly layers", "Tropical timber decays before it can be collected", "Tropical regions contain no buildings old enough to be worth dating", "Tropical species grow so fast that their rings overlap"], correctAnswer: "A climate without marked seasons does not produce distinct yearly layers"),
                QuestionTexte(question: "What does the phrase 'the chain can be extended backwards, beam by beam' imply about each new sample added?", options: ["It must have rings in common with a sample already dated", "It must be older than the previous sample by a fixed interval", "It must belong to the same tree species as the living tree", "It must come from a building whose construction date is documented"], correctAnswer: "It must have rings in common with a sample already dated")
            ]
        ),
        TexteAnglais(
            titre: "Cooling the Street",
            mode: .lecture,
            texte: "A city is usually several degrees warmer than the countryside around it. Asphalt and brick absorb sunlight during the day and release it slowly after dark, so the gap is often widest at night, when residents most need coolness in order to sleep.\n\nPlanners have two broad options. The first is to make surfaces reflective: pale roofs and light-coloured pavements send sunlight back rather than storing it. The second is to plant trees, which cool in two ways, by casting shade and by releasing water vapour through their leaves.\n\nMeasurements suggest the two strategies are not interchangeable. Reflective surfaces lower the air temperature across a whole district, yet a pedestrian standing beside a pale wall may actually feel hotter, since the reflected light strikes the body directly. Trees do less for the district as a whole, but they transform the experience of the individual street.\n\nTrees also cost more. They need water in exactly the seasons when water is scarce, they take decades to reach a useful size, and a species chosen for today's conditions may struggle in tomorrow's. Paint, by contrast, is cheap and immediate, and must be renewed as it weathers and darkens.\n\nMost cities, unsurprisingly, end up combining the two.",
            questions: [
                QuestionTexte(question: "Why is the difference between city and countryside greatest at night?", options: ["Hard urban surfaces give back the heat they stored during the day", "Cities consume far more energy once the working day is over", "Trees stop releasing water vapour once the sun has set", "The breeze that cools the countryside dies down after dark"], correctAnswer: "Hard urban surfaces give back the heat they stored during the day"),
                QuestionTexte(question: "How can a pale wall make a passer-by feel hotter?", options: ["The light it sends back reaches the body directly, even though the surrounding air is cooler", "It stores more heat than a dark wall and radiates it towards passers-by", "It blocks the movement of air along the street", "It raises the air temperature of the whole district"], correctAnswer: "The light it sends back reaches the body directly, even though the surrounding air is cooler"),
                QuestionTexte(question: "What does the text suggest about the low cost of reflective paint?", options: ["It is partly offset by the need to reapply it as the surface ages", "It makes paint the only sensible choice for cities with small budgets", "It is explained by the fact that paint lasts longer than a tree", "It matters less than the fact that paint works instantly"], correctAnswer: "It is partly offset by the need to reapply it as the surface ages"),
                QuestionTexte(question: "What is the main point of the comparison made in the third paragraph?", options: ["The two methods act on different scales, one on the district, the other on the street", "Trees outperform reflective surfaces on every measure", "Reflective surfaces are being abandoned by planners", "The two methods give the same result for very different costs"], correctAnswer: "The two methods act on different scales, one on the district, the other on the street")
            ]
        ),
        TexteAnglais(
            titre: "Following the Blue Dot",
            mode: .lecture,
            texte: "Before satellite navigation, a driver arriving in an unfamiliar city had little choice but to build a rough map in their head: a river on the left, a station to the north, a sequence of turns that could be reversed on the way back. The device removed that obligation. It issues one instruction at a time, and each instruction can be obeyed without any sense of where the destination actually lies.\n\nResearchers distinguish two ways of finding a route. In the first, you follow a memorised chain of cues: turn left after the church. In the second, you hold an overall layout in mind and can improvise when a road is closed. Turn-by-turn guidance encourages the first and gives the second very little to do.\n\nThis is not a straightforward loss. Drivers using navigation systems get lost less often, arrive sooner and, in unfamiliar places, take safer roads. The cost appears only when the tool fails, or when someone is asked to describe a city they have crossed a hundred times.\n\nSome designers propose a compromise: systems that occasionally announce a landmark instead of a distance, or that indicate the direction of the destination without prescribing the route. The aim is not to make navigation harder, but to leave the driver something to think about.",
            questions: [
                QuestionTexte(question: "What distinguishes the second way of finding a route from the first?", options: ["It allows the driver to work out an alternative when the planned way is blocked", "It relies on landmarks rather than on street names", "It is used by pedestrians, whereas the first is used by drivers", "It is quicker but leaves more room for mistakes"], correctAnswer: "It allows the driver to work out an alternative when the planned way is blocked"),
                QuestionTexte(question: "Why does the author write that this is 'not a straightforward loss'?", options: ["Because the systems bring real benefits that have to be set against the drawback", "Because the drawback disappears once the driver has enough practice", "Because researchers have not yet agreed on the evidence", "Because only inexperienced drivers are concerned"], correctAnswer: "Because the systems bring real benefits that have to be set against the drawback"),
                QuestionTexte(question: "According to the text, when does the disadvantage of turn-by-turn guidance become apparent?", options: ["When the device stops working, or when the driver has to describe the area from memory", "When traffic conditions force a change of route", "When the driver is in a city they have never visited", "When the same journey is repeated day after day"], correctAnswer: "When the device stops working, or when the driver has to describe the area from memory"),
                QuestionTexte(question: "What do the compromises proposed by designers have in common?", options: ["They withhold part of the guidance so that the driver has to situate themselves", "They do away with spoken instructions altogether", "They lengthen routes deliberately in order to train the memory", "They replace the map with a written list of directions"], correctAnswer: "They withhold part of the guidance so that the driver has to situate themselves"),
                QuestionTexte(question: "What does the first paragraph suggest about a driver who has only ever followed step-by-step instructions?", options: ["They may reach their destination without knowing in which direction it lies", "They will arrive later than a driver using a paper map", "They become unable to recognise familiar landmarks", "They will refuse to drive if the device is unavailable"], correctAnswer: "They may reach their destination without knowing in which direction it lies")
            ]
        ),
        TexteAnglais(
            titre: "The Illusion of Learning",
            mode: .lecture,
            texte: "Ask students how they revise and most will describe the same routine: read the chapter, underline the important parts, read it again the night before. The method has one great advantage. It feels effective. Each rereading is smoother than the last, and that fluency is easily mistaken for knowledge.\n\nMemory specialists recommend something less comfortable. Instead of rereading, close the book and try to reproduce the content from memory. The attempt is slow, full of errors and frequently unpleasant, and it produces markedly better retention weeks later. Spreading sessions out has a similar effect: material reviewed on three separate days is remembered longer than the same material covered in one long evening, even though the total time spent is identical.\n\nThe obstacle is not ignorance of these findings but the feeling they produce. A student who tests themselves is confronted with everything they cannot yet recall, and concludes that the method is failing. A student who rereads finishes the evening with a pleasant impression of mastery, an impression that survives right up to the examination.\n\nThe practical advice that follows is unusually simple. When a revision technique feels difficult, that is not a reason to abandon it, and when it feels easy, that is not evidence that it is working.",
            questions: [
                QuestionTexte(question: "Why does rereading give students confidence?", options: ["The text becomes easier to process with each pass, and that ease is taken for mastery", "Underlining shows them exactly how much of the chapter they have covered", "It takes less time than the methods specialists recommend", "It is done close enough to the examination for the material to stay fresh"], correctAnswer: "The text becomes easier to process with each pass, and that ease is taken for mastery"),
                QuestionTexte(question: "According to the third paragraph, what mainly stops students from adopting the recommended methods?", options: ["The unpleasant feeling those methods create while they are being used", "The fact that most students have never heard of this research", "The extra hours the methods require", "The fact that teachers keep recommending rereading"], correctAnswer: "The unpleasant feeling those methods create while they are being used"),
                QuestionTexte(question: "Which principle does the last paragraph put forward?", options: ["How a method feels while you use it says little about how well it works", "The harder a revision technique is, the better it must be", "A technique that feels easy should always be dropped", "Students should revise in whatever way they find most enjoyable"], correctAnswer: "How a method feels while you use it says little about how well it works"),
                QuestionTexte(question: "What would the author most probably say about a student who rereads and feels ready?", options: ["That the confidence is genuine but a poor predictor of what will be recalled", "That the confidence proves the chapter has been understood", "That the confidence will collapse the day before the examination", "That the student must in fact have spread their sessions out"], correctAnswer: "That the confidence is genuine but a poor predictor of what will be recalled")
            ]
        ),
        TexteAnglais(
            titre: "The Runner Who Never Finishes",
            mode: .lecture,
            texte: "In elite distance races, some competitors are not trying to win. A pacemaker, or hare, is paid to run the first half of the race at a precise, pre-arranged speed and then step off the track. The job is to remove two burdens from the athletes behind: the effort of judging the pace, and, on a windy day, a significant share of the air resistance.\n\nThe arrangement suits everyone involved. Organisers want records, because records attract broadcasters. Athletes chasing a time want the metronome. And the pacemaker, usually a strong runner without the finishing speed to beat such a field, earns a fee and the attention of sponsors.\n\nIt also has critics. A race, they argue, is meant to be a contest of tactics as well as fitness, and a runner who has never had to decide when to accelerate has not really been tested. Championship finals, significantly, use no pacemakers. They are often slow, cautious affairs decided by a violent last lap, and the times bear no comparison with those set in paced races.\n\nThat is why two runners with very different personal bests may finish a championship in the opposite order. The clock and the medal reward different skills.",
            questions: [
                QuestionTexte(question: "Why is the pacemaker described as a 'metronome'?", options: ["Because they hold a speed agreed in advance, which the others can simply follow", "Because they gradually increase the tempo to break their rivals", "Because they are paid according to the time they spend on the track", "Because they set the rhythm of the final lap"], correctAnswer: "Because they hold a speed agreed in advance, which the others can simply follow"),
                QuestionTexte(question: "Why is a pacemaker rarely a contender for victory?", options: ["They lack the final burst of speed needed to beat runners of that level", "They are not fit enough to cover the full distance", "The rules forbid a paid pacemaker from finishing the race", "They are generally at the end of their career"], correctAnswer: "They lack the final burst of speed needed to beat runners of that level"),
                QuestionTexte(question: "According to the text, why are championship finals often slow?", options: ["Without a pacemaker the runners hold back and wait, and the race is settled at the end", "The best athletes usually skip championships to chase records elsewhere", "The athletes are worn out by the earlier rounds", "Broadcasters prefer a close finish to a fast time"], correctAnswer: "Without a pacemaker the runners hold back and wait, and the race is settled at the end"),
                QuestionTexte(question: "What is the critics' objection, as the text states it?", options: ["Pacemaking removes the tactical judgement that a race is supposed to test", "Pacemaking favours one particular competitor over the rest of the field", "Pacemakers are paid more than the athletes who finish the race", "Records set behind a pacemaker are not physically credible"], correctAnswer: "Pacemaking removes the tactical judgement that a race is supposed to test")
            ]
        ),
        TexteAnglais(
            titre: "What the Group Already Knows",
            mode: .lecture,
            texte: "Put five people in a room to make a decision and something predictable happens. The discussion fills up with facts that everyone already had before the meeting began, while a piece of information held by a single person is often mentioned once, if at all, and then quietly dropped.\n\nThe reason is not stupidity. Shared facts are easier to introduce, because someone else will immediately confirm them, and confirmation is rewarding. A unique fact, by contrast, arrives without support, and the person who raises it risks looking mistaken, or simply off-topic. Groups therefore converge on the version of reality they held collectively at the start, the very version they met in order to improve.\n\nSeveral remedies exist, and they have little to do with encouraging people to speak up. Asking each member to write down a conclusion before the discussion opens preserves opinions that would otherwise be absorbed by the majority. Assigning explicit roles, such as telling one member that they will be asked about the supplier, makes a contribution legitimate in advance. And a leader who states an opinion first should expect the rest of the meeting to circle around it.\n\nThe common thread is structural. Good decisions depend less on the goodwill of the participants than on the order in which they are asked to speak.",
            questions: [
                QuestionTexte(question: "Why do facts already known to everyone dominate the discussion?", options: ["They are met with immediate agreement, and agreement is pleasant to receive", "They are more likely to be accurate than facts held by one person", "The members who hold unique facts tend to arrive once the meeting has started", "Unique facts are harder for their holder to remember under pressure"], correctAnswer: "They are met with immediate agreement, and agreement is pleasant to receive"),
                QuestionTexte(question: "What is the point of the remark that the group converges on 'the very version they met in order to improve'?", options: ["The way the discussion unfolds works against the purpose of holding it", "The group's starting view turns out to be wrong in most cases", "Meetings should be made considerably shorter", "Members deliberately keep useful information to themselves"], correctAnswer: "The way the discussion unfolds works against the purpose of holding it"),
                QuestionTexte(question: "How does writing down a conclusion before the discussion help?", options: ["It fixes each person's judgement before the majority view can reshape it", "It saves time by shortening the discussion itself", "It obliges each member to defend their view in front of the others", "It lets the leader see in advance who agrees with them"], correctAnswer: "It fixes each person's judgement before the majority view can reshape it"),
                QuestionTexte(question: "What does the text imply that a leader should do in a meeting?", options: ["Keep their own view to themselves until the others have spoken", "Announce their position at the outset so the discussion has a clear direction", "Stay out of the meeting so as not to influence anyone", "Hand out roles only once the discussion has revealed the disagreements"], correctAnswer: "Keep their own view to themselves until the others have spoken"),
                QuestionTexte(question: "What is the main claim of the final paragraph?", options: ["The quality of a decision depends above all on how the discussion is organised", "The willingness of participants to cooperate is what settles the outcome", "Groups should be kept as small as possible", "Important decisions should not be entrusted to groups at all"], correctAnswer: "The quality of a decision depends above all on how the discussion is organised")
            ]
        ),
        TexteAnglais(
            titre: "Cabin announcement before departure",
            mode: .ecoute,
            texte: "Good morning, ladies and gentlemen, and welcome on board. This is your purser speaking. Before we leave the gate, I have a small piece of news for you. Our flight today will be slightly shorter than planned. The winds over the ocean are stronger than usual, and they are pushing us in the right direction. Because of that, we expect to land about twenty minutes early. Please note that our arrival gate has not changed. Passengers with a connecting flight will therefore have a little longer to reach their next aircraft than their ticket suggests. We will still serve the full breakfast, so nothing will be removed from the menu. The cabin crew will now come through the cabin to check that all bags are safely stowed. Thank you for your attention, and enjoy the flight.",
            questions: [
                QuestionTexte(question: "Why will the flight take less time than expected?", options: ["Favourable winds are helping the aircraft along its route", "The crew has chosen a shorter route over the ocean", "The aircraft is flying faster to make up for a late departure", "The breakfast service has been shortened to save time"], correctAnswer: "Favourable winds are helping the aircraft along its route"),
                QuestionTexte(question: "What does the announcement say about passengers who have another flight to catch?", options: ["They will have more time than their ticket indicates", "They must leave the aircraft before the other passengers", "They should ask the crew for a new connection", "Their connecting gate has been changed"], correctAnswer: "They will have more time than their ticket indicates"),
                QuestionTexte(question: "What will the cabin crew do next?", options: ["Walk through the cabin to check the luggage", "Serve breakfast before departure", "Hand out new boarding passes", "Demonstrate the safety equipment"], correctAnswer: "Walk through the cabin to check the luggage")
            ]
        ),
        TexteAnglais(
            titre: "Morning weather briefing",
            mode: .ecoute,
            texte: "Here is the weather briefing for this morning. At the moment, the airfield is covered by a thin layer of fog. Visibility is low, but the fog is shallow and the sky above it is clear. The sun is expected to burn the fog off by the middle of the morning. Until then, departures will continue, but they will be spaced further apart than usual. In the afternoon, the picture changes. A band of showers will move in from the west. These showers will bring gusty winds and a risk of turbulence during the climb. The showers should pass through quickly. By the evening, the wind will drop and the sky will clear again. Crews planning an afternoon departure should expect a bumpy climb, but no significant delay is anticipated for the rest of the day.",
            questions: [
                QuestionTexte(question: "What effect does the fog have on this morning's operations?", options: ["Departures continue, but with longer gaps between them", "All departures are suspended until the fog lifts", "Aircraft must land at another airfield", "Only arrivals are affected, not departures"], correctAnswer: "Departures continue, but with longer gaps between them"),
                QuestionTexte(question: "What is expected to happen in the afternoon?", options: ["Rain showers with gusty winds and turbulence when climbing", "Thicker fog returning over the airfield", "A long period of steady rain lasting into the evening", "Strong winds that will force flights to be cancelled"], correctAnswer: "Rain showers with gusty winds and turbulence when climbing"),
                QuestionTexte(question: "What does the briefing say about the evening?", options: ["Conditions will improve, with less wind and a clear sky", "Fog will form again as the temperature falls", "The showers will still be present but weaker", "The wind will pick up again once the showers have passed"], correctAnswer: "Conditions will improve, with less wind and a clear sky")
            ]
        ),
        TexteAnglais(
            titre: "A message from air traffic control",
            mode: .ecoute,
            texte: "The controller called the crew shortly after take-off. He explained that another aircraft ahead of them was climbing more slowly than expected. To keep a safe distance, he asked the crew to stop their climb and to hold their present level for a few minutes. The captain read the instruction back and levelled off. The controller then added that he would offer a higher level as soon as the traffic ahead was clear. Three minutes later, he called again. The aircraft ahead had turned to the north, and the way was now open. The crew was cleared to continue the climb to their planned cruising level. The captain thanked the controller and resumed the climb. The whole exchange was routine, and the passengers in the cabin noticed nothing unusual.",
            questions: [
                QuestionTexte(question: "Why did the controller interrupt the aircraft's climb?", options: ["Another aircraft ahead was gaining altitude too slowly", "The crew had climbed above the level they were given", "Bad weather was reported at the higher levels", "The aircraft was flying faster than the traffic behind it"], correctAnswer: "Another aircraft ahead was gaining altitude too slowly"),
                QuestionTexte(question: "What allowed the crew to continue climbing?", options: ["The aircraft ahead changed direction and left the route clear", "The controller decided the separation was no longer necessary", "The crew requested a different route to avoid the traffic", "The aircraft ahead finally reached its cruising level"], correctAnswer: "The aircraft ahead changed direction and left the route clear"),
                QuestionTexte(question: "How is the situation described overall?", options: ["As an ordinary exchange with no consequence for the passengers", "As a serious loss of separation between two aircraft", "As a misunderstanding between the captain and the controller", "As an emergency that required an immediate descent"], correctAnswer: "As an ordinary exchange with no consequence for the passengers")
            ]
        ),
        TexteAnglais(
            titre: "The missing suitcase",
            mode: .ecoute,
            texte: "Last week, a passenger arrived at the baggage hall and could not find her suitcase. She waited until the belt was empty, then went to the service desk. The agent asked for her name and her flight, and typed a few details into the computer. Within a minute, he smiled. Her suitcase had never left the departure airport. A bag with a very similar label had been loaded instead. The agent explained that her suitcase would arrive on the next flight, two hours later. He offered to have it delivered to her hotel that same evening, at no cost. The passenger accepted, left the airport, and received her suitcase before dinner. She later wrote to the airline, not to complain, but to thank the agent for being so calm and so clear.",
            questions: [
                QuestionTexte(question: "What had actually happened to the suitcase?", options: ["It had stayed at the airport where the journey began", "It had been sent to the wrong destination by mistake", "It had been damaged and kept back for repair", "It had been taken by another passenger from the belt"], correctAnswer: "It had stayed at the airport where the journey began"),
                QuestionTexte(question: "What did the agent propose to the passenger?", options: ["To have the bag brought to her hotel the same evening, free of charge", "To pay her compensation for the missing bag", "To let her come back to the airport the next day", "To send the bag to her home address in a few days"], correctAnswer: "To have the bag brought to her hotel the same evening, free of charge"),
                QuestionTexte(question: "Why did the passenger write to the airline afterwards?", options: ["To praise the way the agent handled the situation", "To ask for an explanation of the labelling error", "To report that her suitcase had arrived damaged", "To complain about the long wait in the baggage hall"], correctAnswer: "To praise the way the agent handled the situation")
            ]
        ),
        TexteAnglais(
            titre: "A small island airport",
            mode: .ecoute,
            texte: "The airport I want to describe sits on a small island. It has a single runway and a terminal no larger than a school. Everything happens in the same building. Passengers check in, wait, and board within a few steps of one another. The airport handles only a handful of flights each day, mostly to the mainland. Because of the sea on both sides, the wind can change direction very quickly. Pilots who fly there regularly say it is the wind, not the length of the runway, that makes the approach demanding. The airport has no night operations. When the sun goes down, the last aircraft leaves and the building closes. Local people are used to this rhythm. They plan their travel around daylight, and nobody there finds it strange.",
            questions: [
                QuestionTexte(question: "According to the pilots mentioned, what makes landing there difficult?", options: ["The wind, which shifts direction rapidly", "The runway, which is unusually short", "The lack of lighting on the runway", "The number of aircraft arriving at the same time"], correctAnswer: "The wind, which shifts direction rapidly"),
                QuestionTexte(question: "What happens at this airport when the sun sets?", options: ["The last flight departs and the terminal shuts", "Only cargo flights are allowed to operate", "Flights continue with reduced staff", "The airport switches to arrivals only"], correctAnswer: "The last flight departs and the terminal shuts"),
                QuestionTexte(question: "How do local residents react to the airport's limited hours?", options: ["They accept them and organise their trips accordingly", "They complain regularly to the airport authority", "They prefer to travel by sea instead", "They are unaware of the restriction"], correctAnswer: "They accept them and organise their trips accordingly")
            ]
        ),
        TexteAnglais(
            titre: "Two crew members before the flight",
            mode: .ecoute,
            texte: "Two flight attendants met in the crew room before their trip. The first one said she had flown this route many times and knew it well. The second one was doing it for the first time. She asked what she should expect. The first attendant said the flight itself was easy, but the turnaround at the destination was very short. There would be no time to leave the aircraft. She advised her colleague to bring something to eat, because the airport shop closes early in the afternoon. She also mentioned that the cabin can get cold on the return leg, so a jacket is useful. The new colleague thanked her and went to buy a sandwich straight away. Small pieces of advice like these, the new colleague later said, are worth more than any manual.",
            questions: [
                QuestionTexte(question: "What is the main difficulty of this route, according to the experienced attendant?", options: ["The very short stop before the return flight", "The length of the flight itself", "The large number of passengers on board", "The difficult approach at the destination"], correctAnswer: "The very short stop before the return flight"),
                QuestionTexte(question: "Why was the new colleague told to bring food?", options: ["Because the shop at the destination shuts early in the day", "Because no meal is served to the crew on board", "Because the flight is too long to go without eating", "Because food is not allowed to be bought at the destination"], correctAnswer: "Because the shop at the destination shuts early in the day"),
                QuestionTexte(question: "What does the new colleague think of the advice she receives?", options: ["She considers it more useful than official documentation", "She finds it interesting but decides to check the manual", "She thinks her colleague is exaggerating the difficulties", "She would have preferred a written briefing"], correctAnswer: "She considers it more useful than official documentation")
            ]
        ),
        TexteAnglais(
            titre: "Service information in the terminal",
            mode: .ecoute,
            texte: "Attention, please. This is a service announcement for passengers in the main terminal. From next Monday, the moving walkway between the check-in area and the departure gates will be closed for maintenance. The work is expected to last about two weeks. During this period, passengers should allow extra time to reach their gate on foot. A shuttle bus will run every ten minutes for passengers with reduced mobility and for anyone travelling with young children. The shuttle leaves from the door next to the information desk. Staff in blue jackets will be present along the corridor to help you find your way. The shops and restaurants in the terminal remain open as usual, and no flight is affected by this work. We apologise for the inconvenience and thank you for your understanding.",
            questions: [
                QuestionTexte(question: "What will most passengers need to do while the maintenance work is going on?", options: ["Set aside more time to walk to their gate", "Check in at a different part of the terminal", "Report to the information desk before going to their gate", "Use a temporary gate area outside the terminal"], correctAnswer: "Set aside more time to walk to their gate"),
                QuestionTexte(question: "Who is the shuttle bus intended for?", options: ["Passengers with reduced mobility and those with small children", "All passengers using the departure gates", "Only airport staff working in the terminal", "Passengers whose flight is about to close"], correctAnswer: "Passengers with reduced mobility and those with small children"),
                QuestionTexte(question: "What does the announcement say about flights and shops?", options: ["Both continue normally despite the work", "Some shops will close during the maintenance", "A few flights may be delayed by the work", "Shops stay open but flights leave from another terminal"], correctAnswer: "Both continue normally despite the work")
            ]
        ),    ]

    static var lectures: [TexteAnglais] { tous.filter { $0.mode == .lecture } }
    static var ecoutes: [TexteAnglais] { tous.filter { $0.mode == .ecoute } }

    /// Deux textes lus et un écouté, en servant d'abord les inédits.
    static func tirage() -> [TexteAnglais] {
        let lus = BanqueRotation.tirer(lectures, nombre: 2, cle: "comprehension.lecture") { $0.titre }
        let entendus = BanqueRotation.tirer(ecoutes, nombre: 1, cle: "comprehension.ecoute") { $0.titre }
        return lus + entendus
    }
}

/// Lit un texte anglais à voix haute.
///
/// La synthèse vocale du système évite d'avoir à produire et embarquer des
/// fichiers audio, fonctionne hors connexion, et permettra plus tard de faire
/// varier le débit pour entraîner à des voix plus rapides.
@MainActor
final class LecteurAnglais: NSObject, AVSpeechSynthesizerDelegate {
    private let synthetiseur = AVSpeechSynthesizer()

    /// Drapeau propre plutôt que `isSpeaking` : celui-ci reste faux pendant les
    /// quelques instants où la synthèse démarre, si bien que deux appuis
    /// rapprochés passaient tous les deux et consommaient les deux écoutes.
    private(set) var estEnTrainDeParler = false

    override init() {
        super.init()
        synthetiseur.delegate = self
    }

    func lire(_ texte: String, vitesse: Float = 0.48) {
        arreter()
        estEnTrainDeParler = true
        let phrase = AVSpeechUtterance(string: texte)
        phrase.voice = AVSpeechSynthesisVoice(language: "en-US")
        phrase.rate = vitesse
        phrase.pitchMultiplier = 1.0
        synthetiseur.speak(phrase)
    }

    func arreter() {
        estEnTrainDeParler = false
        if synthetiseur.isSpeaking {
            synthetiseur.stopSpeaking(at: .immediate)
        }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                                       didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor in estEnTrainDeParler = false }
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                                       didCancel utterance: AVSpeechUtterance) {
        Task { @MainActor in estEnTrainDeParler = false }
    }
}

// MARK: - ViewModel

@MainActor
@Observable
final class ComprehensionViewModel {
    /// Où en est le candidat sur le texte courant.
    enum Etape { case decouverte, questions }

    var textes: [TexteAnglais] = []
    var indexTexte: Int = 0
    var indexQuestion: Int = 0
    var etape: Etape = .decouverte
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var timeRemaining: Int = 480
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var selectedAnswer: String?
    var showFeedback: Bool = false
    var ecoutesRestantes: Int = 2

    /// Les options dans l'ordre affiché.
    ///
    /// Sans mélange, l'ordre est celui du corpus — où la bonne réponse se
    /// trouve en première position dans 77 % des cas. Toucher le premier
    /// bouton suffisait alors à répondre juste sans lire le texte.
    private(set) var optionsAffichees: [String] = []

    private let lecteur = LecteurAnglais()
    private var timerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    static let duree = 480

    var texteCourant: TexteAnglais? {
        indexTexte < textes.count ? textes[indexTexte] : nil
    }

    var questionCourante: QuestionTexte? {
        guard let texte = texteCourant, indexQuestion < texte.questions.count else { return nil }
        return texte.questions[indexQuestion]
    }

    private func melangerOptions() {
        optionsAffichees = questionCourante?.options.shuffled() ?? []
    }

    var totalQuestions: Int {
        textes.reduce(0) { $0 + $1.questions.count }
    }

    /// Rapporté au nombre total de questions du tirage, et non aux seules
    /// questions traitées : sinon abandonner après une bonne réponse affichait
    /// 100 %.
    var accuracy: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }

    func startGame() {
        textes = ComprehensionGenerator.tirage()
        indexTexte = 0
        indexQuestion = 0
        etape = .decouverte
        correctAnswers = 0
        wrongAnswers = 0
        selectedAnswer = nil
        showFeedback = false
        ecoutesRestantes = 2
        timeRemaining = Self.duree
        isGameActive = true
        isGameOver = false
        startTimer()
    }

    private func startTimer() {
        lancerTimer(pour: TimeInterval(Self.duree))
    }

    /// Relance le compte à rebours là où il s'était arrêté.
    private func reprendreTimer() {
        lancerTimer(pour: TimeInterval(timeRemaining))
    }

    private func lancerTimer(pour duree: TimeInterval) {
        timerTask?.cancel()
        guard duree > 0 else { return endGame() }
        timerTask = Countdown.start(seconds: duree) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            endGame()
        }
    }

    /// Lance la lecture à voix haute, dans la limite des écoutes autorisées.
    func ecouter() {
        guard let texte = texteCourant, texte.mode == .ecoute, ecoutesRestantes > 0 else { return }
        // Une lecture déjà en cours ne consomme pas une seconde écoute : deux
        // appuis rapprochés faisaient perdre les deux d'un coup.
        guard !lecteur.estEnTrainDeParler else { return }
        ecoutesRestantes -= 1
        lecteur.lire(texte.texte)
    }

    func passerAuxQuestions() {
        lecteur.arreter()
        etape = .questions
        indexQuestion = 0
        selectedAnswer = nil
        showFeedback = false
        melangerOptions()
    }

    func repondre(_ reponse: String) {
        guard !showFeedback, let question = questionCourante else { return }
        // Suspendu pendant la correction, comme sur le QCM d'anglais
        timerTask?.cancel()
        selectedAnswer = reponse
        showFeedback = true

        if reponse == question.correctAnswer {
            correctAnswers += 1
            HapticManager.success()
        } else {
            wrongAnswers += 1
            HapticManager.error()
        }

        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(1400))
            if Task.isCancelled { return }
            avancer()
        }
    }

    private func avancer() {
        guard let texte = texteCourant else { return endGame() }
        selectedAnswer = nil
        showFeedback = false
        reprendreTimer()

        if indexQuestion + 1 < texte.questions.count {
            indexQuestion += 1
            melangerOptions()
        } else if indexTexte + 1 < textes.count {
            indexTexte += 1
            indexQuestion = 0
            etape = .decouverte
            ecoutesRestantes = 2
        } else {
            endGame()
        }
    }

    private func endGame() {
        timerTask?.cancel()
        transitionTask?.cancel()
        lecteur.arreter()
        isGameActive = false
        isGameOver = true
    }

    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        return GameResult(gameType: .anglaisComprehension, score: Double(correctAnswers),
                          correctAnswers: correctAnswers,
                          totalItems: max(1, totalQuestions),
                          duration: Double(Self.duree - timeRemaining))
    }

    func stopGame() {
        timerTask?.cancel()
        transitionTask?.cancel()
        lecteur.arreter()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - Vue

struct ComprehensionAnglaiseView: View {
    @State private var viewModel = ComprehensionViewModel()

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
        .sortieProtegee(enPartie: viewModel.isGameActive) { viewModel.stopGame() }
        .navigationTitle("Compréhension")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .anglaisComprehension)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Compréhension",
                    rules: [
                        RuleItem(icon: "doc.text", text: "Deux textes à lire, un à écouter"),
                        RuleItem(icon: "speaker.wave.2", text: "Le texte écouté n'est jamais affiché"),
                        RuleItem(icon: "repeat", text: "Deux écoutes possibles, pas plus"),
                        RuleItem(icon: "questionmark.circle", text: "Les réponses se déduisent du texte seul"),
                        RuleItem(icon: "timer", text: "8 minutes pour l'ensemble")
                    ],
                    accentColor: Theme.accentViolet,
                    isGameActive: viewModel.isGameActive
                )
            }
        }
        .onDisappear { viewModel.stopGame() }
    }

    private var startView: some View {
        ScrollView {
            VStack(spacing: 22) {
                Image(systemName: "text.book.closed.fill")
                    .font(.system(size: 68))
                    .foregroundStyle(Theme.accentViolet)
                Text("Compréhension").font(.largeTitle.weight(.bold))

                ReglesCompactes(regles: [
                    "Deux textes à lire, un à écouter",
                    "Le texte écouté n'est jamais affiché : deux écoutes au maximum",
                    "Chaque réponse se déduit du texte, jamais de tes connaissances"
                ], teinte: Theme.accentViolet)

                Text("À partir de 2026, l'anglais du PSY0 évalue la compréhension écrite et orale : le TOEIC n'est plus demandé.")
                    .font(.caption)
                    .foregroundStyle(Theme.texteFaible)
                    .multilineTextAlignment(.center)

                Text("3 textes, 8 minutes")
                    .font(.callout)
                    .foregroundStyle(Theme.texteFaible)

                Button {
                    viewModel.startGame()
                } label: {
                    Text("Commencer")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.accentViolet)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.vertical, 8)
        }
    }

    @ViewBuilder
    private var gameView: some View {
        if let texte = viewModel.texteCourant {
            VStack(spacing: 12) {
                HStack {
                    Text("Texte \(viewModel.indexTexte + 1)/\(viewModel.textes.count)")
                        .font(.headline)
                    Spacer()
                    TimerView(timeRemaining: viewModel.timeRemaining,
                              totalTime: ComprehensionViewModel.duree)
                }

                switch viewModel.etape {
                case .decouverte:
                    decouverte(texte)
                case .questions:
                    questions(texte)
                }

                Spacer(minLength: 0)
            }
        }
    }

    @ViewBuilder
    private func decouverte(_ texte: TexteAnglais) -> some View {
        if texte.mode == .lecture {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(texte.titre)
                        .font(.bloc)
                        .foregroundStyle(Theme.texteFort)
                    Text(texte.texte)
                        .font(.system(size: 15))
                        .foregroundStyle(Theme.texteFort)
                        .lineSpacing(3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(14)
                .background(Theme.surface, in: RoundedRectangle(cornerRadius: Theme.rayon))
                .overlay(RoundedRectangle(cornerRadius: Theme.rayon)
                    .strokeBorder(Theme.filet, lineWidth: 1))
            }
            Button {
                viewModel.passerAuxQuestions()
            } label: {
                Text("Passer aux questions")
                    .font(.carte)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(Theme.accentViolet, in: RoundedRectangle(cornerRadius: 11))
            }
        } else {
            VStack(spacing: 18) {
                Spacer()
                Image(systemName: "headphones")
                    .font(.system(size: 54))
                    .foregroundStyle(Theme.accentViolet)
                Text("Écoute attentivement")
                    .font(.bloc)
                Text("Le texte ne sera pas affiché. Tu peux l'écouter deux fois au maximum.")
                    .font(.caption)
                    .foregroundStyle(Theme.texteFaible)
                    .multilineTextAlignment(.center)

                Button {
                    viewModel.ecouter()
                } label: {
                    Label(viewModel.ecoutesRestantes == 2 ? "Écouter" : "Réécouter",
                          systemImage: "play.fill")
                        .font(.carte)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .background(viewModel.ecoutesRestantes > 0 ? Theme.accentViolet : Theme.filet,
                                    in: RoundedRectangle(cornerRadius: 11))
                }
                .disabled(viewModel.ecoutesRestantes == 0)

                Text("\(viewModel.ecoutesRestantes) écoute\(viewModel.ecoutesRestantes > 1 ? "s" : "") restante\(viewModel.ecoutesRestantes > 1 ? "s" : "")")
                    .font(.caption2)
                    .foregroundStyle(Theme.texteFaible)

                Button {
                    viewModel.passerAuxQuestions()
                } label: {
                    Text("Passer aux questions")
                        .font(.carte)
                        .foregroundStyle(Theme.accentViolet)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                }
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func questions(_ texte: TexteAnglais) -> some View {
        if let question = viewModel.questionCourante {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    if texte.mode == .lecture {
                        DisclosureGroup("Revoir le texte") {
                            Text(texte.texte)
                                .font(.system(size: 14))
                                .foregroundStyle(Theme.texteFaible)
                                .lineSpacing(2)
                                .padding(.top, 6)
                        }
                        .font(.system(size: 15, weight: .semibold))
                        .tint(Theme.accentViolet)
                        .frame(minHeight: 44)
                    }

                    Text("Question \(viewModel.indexQuestion + 1)/\(texte.questions.count)")
                        .font(.etiquette)
                        .tracking(1.2)
                        .foregroundStyle(Theme.texteFaible)

                    Text(question.question)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Theme.texteFort)
                        .fixedSize(horizontal: false, vertical: true)

                    VStack(spacing: 8) {
                        ForEach(viewModel.optionsAffichees, id: \.self) { option in
                            Button {
                                viewModel.repondre(option)
                            } label: {
                                HStack {
                                    Text(option)
                                        .font(.system(size: 15))
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer(minLength: 4)
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(fond(option, question: question),
                                            in: RoundedRectangle(cornerRadius: 11))
                                .foregroundStyle(couleurTexte(option, question: question))
                            }
                            .buttonStyle(.plain)
                            .disabled(viewModel.showFeedback)
                        }
                    }
                }
                .padding(.bottom, 8)
            }
        }
    }

    private func fond(_ option: String, question: QuestionTexte) -> Color {
        guard viewModel.showFeedback else { return Theme.surface }
        if option == question.correctAnswer { return Theme.vert }
        if option == viewModel.selectedAnswer { return Theme.rouge }
        return Theme.surface
    }

    private func couleurTexte(_ option: String, question: QuestionTexte) -> Color {
        guard viewModel.showFeedback else { return Theme.texteFort }
        if option == question.correctAnswer || option == viewModel.selectedAnswer { return .white }
        return Theme.texteFaible
    }

    private var gameOverView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: viewModel.accuracy >= 70 ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(viewModel.accuracy >= 70 ? Theme.vert : Theme.rouge)
            Text("Terminé !").font(.largeTitle.weight(.bold))

            VStack(spacing: 12) {
                ResultRow(label: "Bonnes réponses",
                          value: "\(viewModel.correctAnswers)/\(viewModel.correctAnswers + viewModel.wrongAnswers)")
                ResultRow(label: "Précision", value: String(format: "%.0f%%", viewModel.accuracy))
            }
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Theme.accentViolet)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        ComprehensionAnglaiseView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
