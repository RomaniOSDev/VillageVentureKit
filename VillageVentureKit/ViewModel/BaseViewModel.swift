

import UIKit

class BaseViewModel {
    
    static let shared = BaseViewModel()
    
    func viewAnimate(view: UIView) {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            view.transform = CGAffineTransform(scaleX: 0.95,
                                               y: 0.95)
        }, completion: { finished in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                view.transform = CGAffineTransform(scaleX: 1,
                                                   y: 1)
            })
        })
    }
    func isOldDevice() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                return windowScene.screen.bounds.height > 800
            }
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            let modelName = UIDevice.current.modelName
            let oldiPadModels = ["iPad4", "iPad5", "iPad6", "iPad7", "iPad8", "iPad2", "iPad3", "Ipad", "iPadOS", "iPad"]
            return !oldiPadModels.contains(where: modelName.contains)
        }
        return true
    }
}

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier,
            element in
            guard let value = element.value as? Int8,
                  value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
