//
//  YemekCell.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 7.07.2026.
//

import UIKit
import SnapKit

class YemekCell: UICollectionViewCell {
    static let reuseIdentifier = "yemek-cell"
    
    // MARK: - UI Components
    private let urunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .themeOrange
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        button.setImage(image, for:.normal)
        button.tintColor = .white
        button.backgroundColor = .themeOrange
        button.layer.cornerRadius = 18 
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
        override func prepareForReuse() {
            super.prepareForReuse()
            urunImageView.image = nil 
        }
    // MARK: - Setup UI
    private func setupCell() {
        backgroundColor = .themeCardBackground
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        contentView.addSubview(urunImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(plusButton)
        
        urunImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(12)
            make.width.equalTo(urunImageView.snp.height) // Tam kare yapısı
        }
        
        plusButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
            make.width.height.equalTo(36)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(urunImageView.snp.top)
            make.leading.equalTo(urunImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(urunImageView.snp.bottom)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(plusButton.snp.leading).offset(-12)
        }
    }
    
    // MARK: - Configure Data
    func configure(with item: MenuItem) {
        nameLabel.text = item.name
        descriptionLabel.text = item.ingredients
        priceLabel.text = item.priceString
        if let url = URL(string: item.imageUrl) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.urunImageView.image = image
                    }
                }
            }.resume()
        } else {
            urunImageView.image = UIImage(systemName: "fork.knife")
        }
    }
}
