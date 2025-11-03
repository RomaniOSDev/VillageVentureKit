
import UIKit
import SnapKit
import StoreKit

extension SKStoreReviewController {
    public static func requestRateApp() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}

class SettingsController: UIViewController {
    
    let viewModel = BaseViewModel.shared
    let coreData = CoreManager.shared
//    private let privacyURL = "https://telegra.ph/Privacy-Policy--Village-Ventures-06-13"
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "backgroundImage")
        return view
    }()
    
    private var infoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "infoView")
        return view
    }()
    private var closeInfo: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "closeView"),
                                for: .normal)
        view.tag = 5
        return view
    }()
    
    private var resultButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "resultButton"),
                                for: .normal)
        view.tag = 6
        return view
    }()
    private var policyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "policyButton"),
                                for: .normal)
        view.tag = 1
        return view
    }()
    private var infoButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "infoButton"),
                                for: .normal)
        view.tag = 2
        return view
    }()
    private var rateButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "rateButton"),
                                for: .normal)
        view.tag = 3
        return view
    }()
    
    private var homeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "homeButton"),
                                for: .normal)
        view.tag = 4
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(named: "backgroundCustom")
        setupeSubview()
        addConstraints()
        setupeButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.loadHomeView()
        }
    }
    private func loadHomeView() {
        UIView.animate(withDuration: 0.5) {
            self.policyButton.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(120)
                make.bottom.equalTo(self.infoButton.snp.top).inset(-20)
            }
            self.rateButton.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(110)
                make.top.equalTo(self.infoButton.snp.bottom).offset(20)
            }
            self.resultButton.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(110)
                make.bottom.equalTo(self.policyButton.snp.top).inset(-20)
            }
            self.homeButton.snp.updateConstraints { make in
                make.bottomMargin.equalToSuperview().inset(20)
            }
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.3) {
                self.infoButton.alpha = 1.0
            }
        }
    }
    private func setupeSubview() {
        view.addSubview(backgroundImage)
        
        view.addSubview(infoView)
        infoView.alpha = 0.0
        view.addSubview(closeInfo)
        closeInfo.alpha = 0.0
        
        view.addSubview(policyButton)
        view.addSubview(infoButton)
        infoButton.alpha = 0.0
        view.addSubview(rateButton)
        view.addSubview(resultButton)

        view.addSubview(homeButton)
    }
    private func setupeButton() {
        resultButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        policyButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        rateButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        closeInfo.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
    }
    @objc func buttonSelector(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            viewModel.viewAnimate(view: policyButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                let vc = WebController()
                vc.isPolicy = true
                vc.urlString = DataInitialization_VV.privacyURL.value
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case 2:
            viewModel.viewAnimate(view: infoButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                UIView.animate(withDuration: 0.3) {
                    self.policyButton.alpha = 0.0
                    self.infoButton.alpha = 0.0
                    self.rateButton.alpha = 0.0
                    self.resultButton.alpha = 0.0
                    self.infoView.alpha = 1.0
                    self.closeInfo.alpha = 1.0
                }
            }
        case 3:
            viewModel.viewAnimate(view: rateButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                SKStoreReviewController.requestRateApp()
            }
        case 4:
            viewModel.viewAnimate(view: homeButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.navigationController?.popToRootViewController(animated: false)
            }
        case 5:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                UIView.animate(withDuration: 0.3) {
                    self.policyButton.alpha = 1.0
                    self.infoButton.alpha = 1.0
                    self.rateButton.alpha = 1.0
                    self.resultButton.alpha = 1.0
                    self.infoView.alpha = 0.0
                    self.closeInfo.alpha = 0.0
                }
            }
        case 6:
            viewModel.viewAnimate(view: resultButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                let vc = ResultListController()
                self.navigationController?.pushViewController(vc, animated: false)
            }
        default:
            break
        }
    }
    private func addConstraints() {
        backgroundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        closeInfo.snp.makeConstraints { make in
            make.right.equalTo(infoView.snp.right).inset(5)
            make.bottom.equalTo(infoView.snp.top).inset(-15)
            make.width.height.equalTo(40)
        }
        resultButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(400)
            make.height.equalTo(110)
            make.left.equalTo(-300)
            make.bottom.equalTo(policyButton.snp.top).inset(-20)
        }
        policyButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(400)
            make.height.equalTo(120)
            make.bottom.equalTo(infoButton.snp.top).inset(-20)
        }
        infoButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(110)
        }
        rateButton.snp.makeConstraints { make in
            make.left.equalTo(-300)
            make.height.equalTo(110)
            make.top.equalTo(infoButton.snp.bottom).offset(20)
        }
        homeButton.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(-300)
        }
    }
}
