
import UIKit
import SnapKit
import CoreData

class SelectModeController: UIViewController {
    
    let viewModel = BaseViewModel.shared
    let coreData = CoreManager.shared
    var selectedMode = ModeGame.easy
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "backgroundImage")
        return view
    }()
   
    private var easyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "lightLevel"),
                                for: .normal)
        view.tag = 1
        return view
    }()
    private var mediumButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "mediumLevel"),
                                for: .normal)
        view.tag = 2
        return view
    }()
    private var hardButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "hardLevel"),
                                for: .normal)
        view.tag = 3
        return view
    }()
    
    private var settingsButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "settingsButton"),
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
            self.loadSelectView()
        }
    }
    private func loadSelectView() {
        UIView.animate(withDuration: 0.5) {
            self.easyButton.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(130)
                make.bottom.equalTo(self.mediumButton.snp.top).inset(-20)
            }
            self.hardButton.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(130)
                make.top.equalTo(self.mediumButton.snp.bottom).offset(20)
            }
            self.settingsButton.snp.updateConstraints { make in
                make.bottomMargin.equalToSuperview().inset(20)
            }
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.3) {
                self.mediumButton.alpha = 1.0
            }
        }
    }
    private func deinitSelectView() {
        UIView.animate(withDuration: 0.5) {
            self.easyButton.snp.remakeConstraints { make in
                make.left.equalTo(-400)
                make.height.equalTo(130)
                make.bottom.equalTo(self.mediumButton.snp.top).inset(-20)
            }
            self.hardButton.snp.remakeConstraints { make in
                make.right.equalToSuperview().inset(400)
                make.height.equalTo(130)
                make.top.equalTo(self.mediumButton.snp.bottom).offset(20)
            }
            self.settingsButton.snp.updateConstraints { make in
                make.bottomMargin.equalToSuperview().inset(-200)
            }
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.3) {
            self.mediumButton.alpha = 0.0
        }
    }
    private func setupeSubview() {
        view.addSubview(backgroundImage)
        
        view.addSubview(easyButton)
        view.addSubview(mediumButton)
        mediumButton.alpha = 0.0
        view.addSubview(hardButton)
        view.addSubview(settingsButton)
    }
    private func setupeButton() {
        easyButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        mediumButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        hardButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
    }
    @objc func buttonSelector(_ sender: UIButton) {
        deinitSelectView()
        switch sender.tag {
        case 1:
            selectedMode = .easy
            viewModel.viewAnimate(view: easyButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                let vc = GameController()
                vc.data = dataEasyGame
                vc.selectedMode = self.selectedMode
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case 2:
            selectedMode = .medium
            viewModel.viewAnimate(view: mediumButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                let vc = GameController()
                vc.data = dataMediumGame
                vc.selectedMode = self.selectedMode
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case 3:
            selectedMode = .hard
            viewModel.viewAnimate(view: hardButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                let vc = GameController()
                vc.data = dataHadrGame
                vc.selectedMode = self.selectedMode
                self.navigationController?.pushViewController(vc, animated: false)
            }
        case 4:
            viewModel.viewAnimate(view: settingsButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                let vc = SettingsController()
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
    
        easyButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(400)
            make.height.equalTo(130)
            make.bottom.equalTo(mediumButton.snp.top).inset(-20)
        }
        mediumButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(130)
        }
        hardButton.snp.makeConstraints { make in
            make.left.equalTo(-400)
            make.height.equalTo(130)
            make.top.equalTo(mediumButton.snp.bottom).offset(20)
        }
    
        settingsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.bottomMargin.equalToSuperview().inset(-200)
        }
    }
}
