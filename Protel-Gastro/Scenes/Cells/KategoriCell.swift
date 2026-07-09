import UIKit
import SnapKit

final class KategoriCell: UICollectionViewCell {
    
    static let reuseIdentifier = "KategoriCell"
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .themeCardBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.08).cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        label.numberOfLines = 1
        return label
    }()
    override func layoutSubviews() {
            super.layoutSubviews()
            containerView.layer.cornerRadius = containerView.frame.height / 2
        }
    
    // MARK: Selection
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                if self.isSelected {
                    self.containerView.backgroundColor = .themeOrange
                    self.containerView.layer.borderColor = UIColor.clear.cgColor
                    self.titleLabel.textColor = .white
                    self.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
                } else {
                    self.containerView.backgroundColor = .themeCardBackground
                    self.containerView.layer.borderColor = UIColor.white.withAlphaComponent(0.08).cgColor
                    self.titleLabel.textColor = UIColor.white.withAlphaComponent(0.6)
                    self.transform = .identity
                }
            }
        }
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Setup
    
    private func setupUI() {
        
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: Configure
    
    func configure(with title: String) {
        titleLabel.text = title
        self.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        transform = .identity
    }
}
