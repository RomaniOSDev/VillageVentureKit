
import UIKit
import SnapKit
import AppsFlyerLib

class HomeController: UIViewController {
    
    let viewModel = BaseViewModel.shared
    let coreData = CoreManager.shared
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "backgroundImage")
        return view
    }()
    private var logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "appLogo")
        return view
    }()
    private var playButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "playImage"),
                                for: .normal)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupeSubview()
        addConstraints()
        playButton.addTarget(self,
                             action: #selector(playGame),
                             for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.loadHomeView()
        }
    }
    private func loadHomeView() {
        UIView.animate(withDuration: 0.5) {
            self.logoImageView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-100)
            }
            self.playButton.snp.updateConstraints { make in
                make.bottomMargin.equalToSuperview().inset(20)
            }
            self.view.layoutIfNeeded()
        }
    }
    private func setupeSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImageView)
        view.addSubview(playButton)
    }
    @objc func playGame() {
        viewModel.viewAnimate(view: playButton)
        deinitView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            let vc = SelectModeController()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    private func deinitView() {
        UIView.animate(withDuration: 0.6) {
            self.logoImageView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-1000)
            }
            self.playButton.snp.updateConstraints { make in
                make.bottomMargin.equalToSuperview().inset(-300)
            }
            self.view.layoutIfNeeded()
        }
    }
    private func addConstraints() {
        backgroundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        playButton.snp.makeConstraints { make in
            make.height.equalTo(140)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(-300)
        }
    }
}
