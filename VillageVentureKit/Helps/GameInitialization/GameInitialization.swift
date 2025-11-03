
import UIKit
import AppsFlyerLib

let gameInit = GameInitialization.shared
let applicationID = 6747254968

class GameInitialization {
    
    static let shared = GameInitialization()
    var navigation: UINavigationController?
    private let viewModel = BaseViewModel.shared
    private var gameState: GameState_VV = .baseGame
    
    
    func setAppsFlyerForAppDelegaet(_ delegate: AppsFlyerLibDelegate) {
        AppsFlyerLib.shared().appsFlyerDevKey = DataInitialization_VV.appsFlyerKey.value
        AppsFlyerLib.shared().appleAppID = DataInitialization_VV.appId.value
        AppsFlyerLib.shared().delegate = delegate
    }
}

enum GameState_VV: String {
    case unknown
    case firstLaunch
    case correctlyConfigured
    case baseGame

}
enum OneSignalValue_VV {
    case appID
    
    var key: String {
        switch self {
        case .appID: return "3a3f9180-bce6-4105-a55c-a373a0267760"
        }
    }
}

enum DataInitialization_VV {
    case appId
    case appsFlyerKey
    case url
    case privacyURL
    
    case stateKey
    case linkKey
    case correctlyLink
    
    var value: String {
        switch self {
        case .appId: return "id\(applicationID)"
        case .appsFlyerKey: return "j57NgDuWLTnzYS8qWegG37"
        case .url: return ""
            
        case .privacyURL: return "https://telegra.ph/Privacy-Policy--Village-Ventures-06-13"
            
        case .stateKey: return "stateVillageVentures"
        case .linkKey: return "linkVillageVentures"
        case .correctlyLink: return UserDefaults.standard.string(forKey: DataInitialization_VV.linkKey.value) ?? ""
        }
    }
}
