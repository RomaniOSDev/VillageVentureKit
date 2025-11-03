
import UIKit
import SnapKit
import CoreData

protocol CellDelegate: AnyObject {
    func startGame()
}

class GameController: UIViewController {
    
    let viewModel = BaseViewModel.shared
    let coreData = CoreManager.shared
    private let cellIdentifier = "cellIdentifier"
    var selectedMode = ModeGame.easy
    
    private var indexGame = 0
    
    private var result = 0
    private var numberOfPairs = 0
    private var totalSeconds = 0
    private var timer: Timer?
    
    var data: [DataGame]?
    private var cards: [Cards]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var tapCell = 0
    var countMatch = 0
    
    private var totalSelect = 0
    
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isUserInteractionEnabled = true
        view.register(CardCell.self,
                      forCellWithReuseIdentifier: cellIdentifier)
        return view
    }()
    
    private var nextButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setBackgroundImage(UIImage(named: "nextButton"),
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
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.setValue(nil,
                                       forKey: "SelectCadr")
        tapCell = 0
        timeTitle.textColor = .white
        totalSelect = 0
        
        numberOfPairs = selectedMode.pairs
        totalSeconds = selectedMode.time
        
        timeTitle.text = "Remaining time: 00:00"
        resultTitle.text = "Correct cards: \(result)/\(numberOfPairs)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.loadGameView()
        }
        setupeGame()
        collectionView.reloadData()
    }
    private func setupeGame() {
        if indexGame <= 4 {
            countMatch += 1
            cards = data?[indexGame].cards
            cards?.shuffle()
        } else {
            openResult()
        }
    }
    private func loadGameView() {
        UIView.animate(withDuration: 0.5) {
            self.nextButton.snp.updateConstraints { make in
                make.bottomMargin.equalToSuperview().inset(20)
            }
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.2) {
                self.collectionView.alpha = 1.0
            }
        }
    }
    private func setupeSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(timeTitle)
        view.addSubview(resultTitle)
        
        view.addSubview(collectionView)
        collectionView.alpha = 0.0
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(nextButton)
        nextButton.isHidden = true
        
        collectionView.isUserInteractionEnabled = false
        nextButton.isUserInteractionEnabled = false
    }
    private func setupeButton() {
        nextButton.addTarget(self, action: #selector(nextCards), for: .touchUpInside)
    }
    @objc func nextCards() {
        viewModel.viewAnimate(view: nextButton)
        
        
        
    }
    private func saveResult() {
        let defMinutes = selectedMode.time / 60
        let defSeconds = selectedMode.time % 60
        let gefTime = String(format: "%02d:%02d",
                               defMinutes,
                               defSeconds)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let time = String(format: "%02d:%02d",
                          minutes,
                          seconds)
        
        let totalTime = stringToInt(gefTime) ?? 0
        let timerTime = stringToInt(time) ?? 0
        let resultTime = totalTime - timerTime
        
        coreData.editBestTime("00:\(resultTime)")
        coreData.editLevel(Int16(selectedMode.level))
        coreData.editMatches(Int16(indexGame))
        
    }
    func stringToInt(_ timeString: String) -> Int? {
        let components = timeString.split(separator: ":")
        guard components.count == 2,
              let minutes = Int(components[0]),
              let seconds = Int(components[1]) else {
            return nil
        }
        return minutes * 60 + seconds
    }
    private func openResult() {
        saveResult()
        timer?.invalidate()
        timer = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let vc = ResultController()
            vc.countMatch = self.countMatch
            vc.selectedMode = self.selectedMode
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    private func openGameOver() {
        timer?.invalidate()
        timer = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let vc = ResultController()
            vc.isGameOver = true
            vc.countMatch = self.countMatch
            vc.selectedMode = self.selectedMode
            self.navigationController?.pushViewController(vc, animated: false)
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(resultTitle.snp.bottom)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
//            make.bottom.equalTo(nextButton.snp.top)
            make.bottomMargin.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(-300)
        }
    }
     private func startTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateCounter),
                                     userInfo: nil,
                                     repeats: true)
    }
    @objc private func updateCounter() {
        if totalSeconds > 0 {
            totalSeconds -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timer = nil
            openGameOver()
            timeTitle.textColor = .systemRed
        }
    }
    private func updateTimerLabel() {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let time = String(format: "%02d:%02d",
                          minutes,
                          seconds)
        timeTitle.text = "Remaining time: \(time)"
    }
}
extension GameController: UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch selectedMode {
        case .easy:
            return cards?.count ?? 0
        case .medium:
            return cards?.count ?? 0
        case .hard:
            return cards?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? CardCell,
              let data = cards?[indexPath.item] else { return UICollectionViewCell() }
        cell.timeShow = self.data?[indexGame].mode.showTime ?? 0
        cell.defaultImage = selectedMode.defaultCard
        cell.configuresCell(data.image)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCell,
           let data = cards?[indexPath.item] {
            tapCell += 1
            switch tapCell {
            case 1:
                UserDefaults.standard.setValue(data.index,
                                               forKey: "SelectCadr")
            case 2:
                if data.index == UserDefaults.standard.integer(forKey: "SelectCadr") {
                    result += 1
                    resultTitle.text = "Correct cards: \(result)/\(numberOfPairs)"
                } else {
                    collectionView.isUserInteractionEnabled = false
                    timeTitle.textColor = .systemRed
                    timer?.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.openGameOver()
                    }
                }
                UserDefaults.standard.setValue(nil,
                                               forKey: "SelectCadr")
                tapCell = 0
            default:
                break
            }
            UIView.transition(with: cell,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: {
                cell.selectCard(data.image)
            })
            totalSelect += 1
            if totalSelect == selectedMode.pairs * 2 {
                totalSelect = 0
                indexGame += 1
                self.collectionView.isUserInteractionEnabled = false
                nextButton.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.setupeGame()
                    self.result = 0
                    self.resultTitle.text = "Correct cards: \( self.result)/\(self.numberOfPairs)"
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch selectedMode {
        case .easy:
            let width = (collectionView.bounds.width - 40) / 2
            return CGSize(width: width,
                          height: width * 1.4)
        case .medium:
            let width = (collectionView.bounds.width - 65) / 2
            return CGSize(width: width,
                          height: width * 1.2)
        case .hard:
            let width = (collectionView.bounds.width - 65) / 3
            return CGSize(width: width,
                          height: width * 1.2)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30,
                            left: 10,
                            bottom: 20,
                            right: 10)
    }
}
extension GameController: CellDelegate {
    func startGame() {
        startTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.collectionView.isUserInteractionEnabled = true
            self.nextButton.isUserInteractionEnabled = true
        }
    }
}
