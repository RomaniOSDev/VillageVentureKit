
import UIKit
import SnapKit

class WelcomeController: UIViewController {
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        gameInit.navigation = navigationController
        
        navigationController?.navigationBar.isHidden = true
        setupeSubview()
        addConstraints()
        
        if coreData.getResultDataArray()?.isEmpty == true {
            coreData.addResultDefaults()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vc = HomeController()
            self.navigationController?.viewControllers = [vc]
        }
    }
    private func setupeSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImageView)
    }
    private func addConstraints() {
        backgroundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
    }
}
