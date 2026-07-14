//
//  CartCell.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 13.07.2026.
//
import UIKit
import SnapKit

final class CartCell: UITableViewCell {
    static let identifier: String = "CartCell"
    private var currentImageUrl: String?

    var didTapPlus: (() -> Void)?
    var didTapMinus: (() -> Void)?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemOrange
        return label
    }()
    
    private let countStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .systemOrange
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupCellUI()
        
    }
    
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    private func setupCellUI() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(productImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(countStackView)
        
        countStackView.addArrangedSubview(minusButton)
        countStackView.addArrangedSubview(countLabel)
        countStackView.addArrangedSubview(plusButton)
        
        // MARK: - SnapKit Constraints
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        productImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.top).offset(4)
            make.leading.equalTo(productImageView.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(countStackView.snp.leading).offset(-12)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(productImageView.snp.bottom).offset(-4)
            make.leading.equalTo(productImageView.snp.trailing).offset(12)
        }
        
        countStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
        
        minusButton.snp.makeConstraints { make in make.width.height.equalTo(28) }
        plusButton.snp.makeConstraints { make in make.width.height.equalTo(28) }
        
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        countLabel.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(20)
        }
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        countStackView.setContentCompressionResistancePriority(.required, for: .horizontal)
        countStackView.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    // MARK: - Configure Data
    func configure(with item: CartItems) {
        titleLabel.text = item.menuItem.name
        countLabel.text = "\(item.quantity)"
        countLabel.textColor = .white
        
        let totalPrice = item.menuItem.price * Double(item.quantity)
        priceLabel.text = String(format: "%.2f ₺ (%.2f x %d)", totalPrice, item.menuItem.price, item.quantity)
        productImageView.image = nil
        
        let itemViewModel = ProductViewModel(product: item.menuItem)
        
        self.currentImageUrl=item.menuItem.imageUrl
        itemViewModel.fetchImage { [weak self] downloadedImage in
            guard let self = self ,self.currentImageUrl == item.menuItem.imageUrl else { return }
            DispatchQueue.main.async {
                self.productImageView.image = downloadedImage
            }
        }
    }
    
    @objc func minusButtonTapped(){
        didTapMinus?()
    }
    
    @objc func plusButtonTapped(){
        didTapPlus?()
    }
}
