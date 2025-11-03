
import UIKit
import SnapKit

class ResultListController: UIViewController {
    
    let viewModel = BaseViewModel.shared
    let coreData = CoreManager.shared
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "backgroundImage")
        return view
    }()
    
    private var headerView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "headerResultView")
        return view
    }()
    
    private var resultView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "resultListView")
        return view
    }()
    
    private var levelTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 35, weight: .bold)
        return view
    }()
    
    private var matchesTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 35, weight: .bold)
        return view
    }()
    private var timeTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 35, weight: .bold)
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var homeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "homeButton"),
                                for: .normal)
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
        
        levelTitle.text = "Level: \(coreData.getResultData()?.levelCount ?? 0) / 3"
        matchesTitle.text = "Matches: \(coreData.getResultData()?.matchesCount ?? 0) / 6"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: coreData.getResultData()?.bestTime ?? Date())
        timeTitle.text = "Best time: \(timeString)"
    }
    private func loadHomeView() {
        UIView.animate(withDuration: 0.5) {
            self.headerView.snp.updateConstraints { make in
                make.topMargin.equalToSuperview().inset(10)
            }
            self.homeButton.snp.updateConstraints { make in
                make.bottomMargin.equalToSuperview().inset(20)
            }
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.3) {
                self.resultView.alpha = 1.0
            }
        }
    }
    private func setupeSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(headerView)
        view.addSubview(resultView)
        resultView.alpha = 0.0
        resultView.addSubview(levelTitle)
        resultView.addSubview(matchesTitle)
        resultView.addSubview(timeTitle)

        view.addSubview(homeButton)
    }
    private func setupeButton() {
        homeButton.addTarget(self, action: #selector(backToView), for: .touchUpInside)
    }
    @objc func backToView() {
        viewModel.viewAnimate(view: homeButton)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.navigationController?.popViewController(animated: false)
        }
    }
    private func addConstraints() {
        backgroundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(-200)
            make.width.equalTo(200)
            make.height.equalTo(130)
            make.centerX.equalToSuperview()
        }
        resultView.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.width.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        
        if viewModel.isOldDevice() == false {
            levelTitle.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(30)
                make.left.equalTo(20)
                make.width.equalToSuperview().inset(20)
                make.height.equalTo(50)
            }
            matchesTitle.snp.makeConstraints { make in
                make.top.equalTo(levelTitle.snp.bottom).offset(40)
                make.left.equalTo(20)
                make.width.equalToSuperview().inset(20)
                make.height.equalTo(40)
            }
            timeTitle.snp.makeConstraints { make in
                make.top.equalTo(matchesTitle.snp.bottom).offset(50)
                make.left.equalTo(45)
                make.width.equalToSuperview().inset(45)
                make.height.equalTo(40)
            }
        } else {
            levelTitle.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(30)
                make.left.equalTo(20)
                make.width.equalToSuperview().inset(20)
                make.height.equalTo(40)
            }
            matchesTitle.snp.makeConstraints { make in
                make.top.equalTo(levelTitle.snp.bottom).offset(50)
                make.left.equalTo(20)
                make.width.equalToSuperview().inset(20)
                make.height.equalTo(40)
            }
            timeTitle.snp.makeConstraints { make in
                make.top.equalTo(matchesTitle.snp.bottom).offset(58)
                make.left.equalTo(40)
                make.width.equalToSuperview().inset(40)
                make.height.equalTo(40)
            }
        }
        
        homeButton.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(-300)
        }
    }
}
