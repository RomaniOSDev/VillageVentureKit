
import Foundation

enum ModeGame {
    case easy
    case medium
    case hard
    
    var name: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
    var pairs: Int {
        switch self {
        case .easy: return 2
        case .medium: return 3
        case .hard: return 6
        }
    }
    var defaultCard: String {
        switch self {
        case .easy: return "defaultCardEasy"
        case .medium: return "defaultCardMedium"
        case .hard: return "defaultCardHard"
        }
    }
    var time: Int {
        switch self {
        case .easy: return 30
        case .medium: return 40
        case .hard: return 80
        }
    }
    var showTime: Double {
        switch self {
        case .easy: return 1.0
        case .medium: return 2.0
        case .hard: return 3.0
        }
    }
    var level: Int {
        switch self {
        case .easy: return 1
        case .medium: return 2
        case .hard: return 3
        }
    }
}

struct DataGame {
    let mode: ModeGame
    var cards: [Cards]
}

struct Cards {
    let image: String
    let index: Int
}

var easyCards1: [Cards] = [.init(image: "CardEasy1", index: 1),
                           .init(image: "CardEasy1", index: 1),
                           
                           .init(image: "CardEasy2", index: 0),
                           .init(image: "CardEasy2", index: 0)]

var easyCards2: [Cards] = [.init(image: "CardEasy3", index: 1),
                           .init(image: "CardEasy3", index: 1),
                           
                           .init(image: "CardEasy4", index: 0),
                           .init(image: "CardEasy4", index: 0)]

var easyCards3: [Cards] = [.init(image: "CardEasy5", index: 1),
                           .init(image: "CardEasy5", index: 1),
                           
                            .init(image: "CardEasy6", index: 0),
                           .init(image: "CardEasy6", index: 0)]

var easyCards4: [Cards] = [.init(image: "CardEasy7", index: 1),
                           .init(image: "CardEasy7", index: 1),
                           
                            .init(image: "CardEasy8", index: 0),
                           .init(image: "CardEasy8", index: 0)]

var easyCards5: [Cards] = [.init(image: "CardEasy9", index: 1),
                           .init(image: "CardEasy9", index: 1),
                           
                           .init(image: "CardEasy10", index: 0),
                           .init(image: "CardEasy10", index: 0)]
                          

var dataEasyGame: [DataGame] = [.init(mode: .easy, cards: easyCards1),
                                .init(mode: .easy, cards: easyCards2),
                                .init(mode: .easy, cards: easyCards3),
                                .init(mode: .easy, cards: easyCards4),
                                .init(mode: .easy, cards: easyCards5)]



var mediumCards1: [Cards] = [.init(image: "CardMedium1", index: 0),
                             .init(image: "CardMedium1", index: 0),
                             
                             .init(image: "CardMedium2", index: 1),
                             .init(image: "CardMedium2", index: 1),
                             
                             .init(image: "CardMedium3", index: 2),
                             .init(image: "CardMedium3", index: 2)]

var mediumCards2: [Cards] = [.init(image: "CardMedium4", index: 0),
                             .init(image: "CardMedium4", index: 0),
                             
                             .init(image: "CardMedium5", index: 1),
                             .init(image: "CardMedium5", index: 1),
                             
                             .init(image: "CardMedium6", index: 2),
                             .init(image: "CardMedium6", index: 2)]

var mediumCards3: [Cards] = [.init(image: "CardMedium7", index: 0),
                             .init(image: "CardMedium7", index: 0),
                             
                             .init(image: "CardMedium8", index: 1),
                             .init(image: "CardMedium8", index: 1),
                             
                             .init(image: "CardMedium9", index: 2),
                             .init(image: "CardMedium9", index: 2)]

var mediumCards4: [Cards] = [.init(image: "CardMedium10", index: 0),
                             .init(image: "CardMedium10", index: 0),
                             
                             .init(image: "CardMedium11", index: 1),
                             .init(image: "CardMedium11", index: 1),
                             
                             .init(image: "CardMedium12", index: 2),
                             .init(image: "CardMedium12", index: 2)]

var mediumCards5: [Cards] = [.init(image: "CardMedium8", index: 0),
                             .init(image: "CardMedium8", index: 0),
                             
                             .init(image: "CardMedium10", index: 1),
                             .init(image: "CardMedium10", index: 1),
                             
                             .init(image: "CardMedium3", index: 2),
                             .init(image: "CardMedium3", index: 2)]


var dataMediumGame: [DataGame] = [.init(mode: .medium, cards: mediumCards1),
                                  .init(mode: .medium, cards: mediumCards2),
                                  .init(mode: .medium, cards: mediumCards3),
                                  .init(mode: .medium, cards: mediumCards4),
                                  .init(mode: .medium, cards: mediumCards5)]

var hardCards1: [Cards] = [.init(image: "CardHard1", index: 0),
                           .init(image: "CardHard1", index: 0),
                           
                           .init(image: "CardHard2", index: 1),
                           .init(image: "CardHard2", index: 1),
                           
                           .init(image: "CardHard3", index: 2),
                           .init(image: "CardHard3", index: 2),
                           
                           .init(image: "CardHard4", index: 3),
                           .init(image: "CardHard4", index: 3),
                           
                           .init(image: "CardHard5", index: 4),
                           .init(image: "CardHard5", index: 4),
                           
                           .init(image: "CardHard6", index: 5),
                           .init(image: "CardHard6", index: 5)]

var hardCards2: [Cards] = [.init(image: "CardHard7", index: 0),
                           .init(image: "CardHard7", index: 0),
                           
                           .init(image: "CardHard8", index: 1),
                           .init(image: "CardHard8", index: 1),
                           
                           .init(image: "CardHard9", index: 2),
                           .init(image: "CardHard9", index: 2),
                           
                           .init(image: "CardHard10", index: 3),
                           .init(image: "CardHard10", index: 3),
                           
                           .init(image: "CardHard11", index: 4),
                           .init(image: "CardHard11", index: 4),
                           
                           .init(image: "CardHard12", index: 5),
                           .init(image: "CardHard12", index: 5)]

var hardCards3: [Cards] = [.init(image: "CardHard13", index: 0),
                           .init(image: "CardHard13", index: 0),
                           
                           .init(image: "CardHard14", index: 1),
                           .init(image: "CardHard14", index: 1),
                           
                           .init(image: "CardHard15", index: 2),
                           .init(image: "CardHard15", index: 2),
                           
                           .init(image: "CardHard16", index: 3),
                           .init(image: "CardHard16", index: 3),
                           
                           .init(image: "CardHard17", index: 4),
                           .init(image: "CardHard17", index: 4),
                           
                           .init(image: "CardHard18", index: 5),
                           .init(image: "CardHard18", index: 5)]

var hardCards4: [Cards] = [.init(image: "CardHard19", index: 0),
                           .init(image: "CardHard19", index: 0),
                           
                           .init(image: "CardHard20", index: 1),
                           .init(image: "CardHard20", index: 1),
                           
                           .init(image: "CardHard2", index: 2),
                           .init(image: "CardHard2", index: 2),
                           
                           .init(image: "CardHard5", index: 3),
                           .init(image: "CardHard5", index: 3),
                           
                           .init(image: "CardHard7", index: 4),
                           .init(image: "CardHard7", index: 4),
                           
                           .init(image: "CardHard10", index: 5),
                           .init(image: "CardHard10", index: 5)]

var hardCards5: [Cards] = [.init(image: "CardHard3", index: 0),
                           .init(image: "CardHard3", index: 0),
                           
                           .init(image: "CardHard16", index: 1),
                           .init(image: "CardHard16", index: 1),
                           
                           .init(image: "CardHard14", index: 2),
                           .init(image: "CardHard14", index: 2),
                           
                           .init(image: "CardHard11", index: 3),
                           .init(image: "CardHard11", index: 3),
                           
                           .init(image: "CardHard19", index: 4),
                           .init(image: "CardHard19", index: 4),
                           
                           .init(image: "CardHard13", index: 5),
                           .init(image: "CardHard13", index: 5)]

var dataHadrGame: [DataGame] = [.init(mode: .hard, cards: hardCards1),
                                .init(mode: .hard, cards: hardCards2),
                                .init(mode: .hard, cards: hardCards3),
                                .init(mode: .hard, cards: hardCards4),
                                .init(mode: .hard, cards: hardCards5)]
