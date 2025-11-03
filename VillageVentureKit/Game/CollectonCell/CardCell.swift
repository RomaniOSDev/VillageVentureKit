
import UIKit
import SnapKit

final class CardCell: UICollectionViewCell {
    
    weak var delegate: CellDelegate?
    var defaultImage = String()
    var timeShow = 1.0
    
    private var cardView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
        setupeConstraint()
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func selectCard(_ image: String) {
        cardView.image = UIImage(named: image)
    }
    func configuresCell(_ image: String) {
        cardView.image = UIImage(named: defaultImage)
        showCard(image)
    }
    private func showCard(_ image: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            UIView.transition(with: self.cardView,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: { [weak self] in
                guard let self else { return }
                cardView.image = UIImage(named: image)
            })
            self.hideCard()
        }
    }
    private func hideCard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeShow) {
            
            UIView.transition(with: self.cardView,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: { [weak self] in
                guard let self else { return }
                cardView.image = UIImage(named: defaultImage)
                delegate?.startGame()
            })
        }
    }
    func hideCardGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeShow) {
            
            UIView.transition(with: self.cardView,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: { [weak self] in
                guard let self else { return }
                cardView.image = UIImage(named: defaultImage)
            })
        }
    }
}
private extension CardCell {
    func initialization() {
        contentView.addSubview(cardView)
    }
    func setupeConstraint() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
