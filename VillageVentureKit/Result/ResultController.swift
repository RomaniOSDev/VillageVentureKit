
import UIKit
import SnapKit

class ResultController: UIViewController {
    
    let viewModel = BaseViewModel.shared
    let coreData = CoreManager.shared
    var countMatch = 0
    var selectedMode = ModeGame.easy
    var isGameOver = false
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "backgroundImage")
        return view
    }()
   
    private var timeTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 22, weight: .bold)
        
        return view
    }()
    private var resultTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 22, weight: .bold)
        return view
    }()
    
    private var resultView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var starView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var againButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "againButton"),
                                for: .normal)
        view.tag = 1
        return view
    }()
    private var backToMenu: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "backToMenu"),
                                for: .normal)
        view.tag = 2
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(named: "backgroundCustom")
        setupeSubview()
        addConstraints()
        setupeButton()
        switch selectedMode {
        case .easy:
            
            if isGameOver == false {
                timeTitle.text = "Level Complete – \(selectedMode.name)"
                resultTitle.text = "Matches: \(countMatch)/5"
            } else {
                timeTitle.text = "Game Over – \(selectedMode.name)"
                resultTitle.text = "Matches: \(countMatch)/5"
            }
        case .medium:
            if isGameOver == false {
                timeTitle.text = "Level Complete – \(selectedMode.name)"
                resultTitle.text = "Matches: \(countMatch)/5"
            } else {
                timeTitle.text = "Game Over – \(selectedMode.name)"
                resultTitle.text = "Matches: \(countMatch)/5"
            }
        case .hard:
            if isGameOver == false {
                timeTitle.text = "Level Complete – \(selectedMode.name)"
                resultTitle.text = "Matches: \(countMatch)/5"
            } else {
                timeTitle.text = "Game Over – \(selectedMode.name)"
                resultTitle.text = "Matches: \(countMatch)/5"
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.loadGameView()
        }
    }
    private func loadGameView() {
        UIView.animate(withDuration: 0.5) {
            self.backToMenu.snp.updateConstraints { make in
                make.bottomMargin.equalToSuperview().inset(20)
            }
            self.view.layoutIfNeeded()
        }
        if isGameOver == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.animate(withDuration: 0.2) {
                    self.starView.alpha = 1.0
                }
            }
        }
        if selectedMode == .hard {
            starView.image = UIImage(named: "chikenWInView")
        } else {
            starView.image = UIImage(named: "starView")
            rotation()
        }
    }
    private func rotation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = CGFloat.pi * 2
        animation.duration = 5.0
        animation.isCumulative = true
        animation.repeatCount = 4
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        starView.layer.add(animation,
                           forKey: "rotationAnimation")
    }
    private func setupeSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(timeTitle)
        view.addSubview(resultTitle)
        
        view.addSubview(resultView)
        resultView.addSubview(starView)
        starView.alpha = 0.0
        
        view.addSubview(againButton)
        view.addSubview(backToMenu)
    }
    private func setupeButton() {
        againButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        backToMenu.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
    }
    
    @objc func buttonSelector(_ sender: UIButton) {
        starView.layer.removeAllAnimations()
        switch sender.tag {
        case 1:
            viewModel.viewAnimate(view: againButton)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigationController?.popViewController(animated: false)
            }
        case 2:
            viewModel.viewAnimate(view: backToMenu)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigationController?.popToRootViewController(animated: false)
            }
        default:
            break
        }
    }
    private func addConstraints() {
        backgroundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        timeTitle.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(15)
            make.left.equalTo(20)
            make.height.equalTo(23)
            make.width.equalToSuperview().inset(20)
        }
        resultTitle.snp.makeConstraints { make in
            make.top.equalTo(timeTitle.snp.bottom)
            make.left.equalTo(20)
            make.height.equalTo(23)
            make.width.equalToSuperview().inset(20)
        }
        
        resultView.snp.makeConstraints { make in
            make.top.equalTo(resultTitle.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalTo(againButton.snp.top)
        }
        starView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(50)
            make.width.equalToSuperview().inset(50)
        }
        
        againButton.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(backToMenu.snp.top).inset(-10)
        }
        backToMenu.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(-300)
        }
    }
}
