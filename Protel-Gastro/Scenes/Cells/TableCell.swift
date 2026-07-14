//
//  TableCell.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//

import UIKit
import SnapKit

final class TableCell: UICollectionViewCell {
    
    static let identifier = "MasaCell"
    
    // MARK: - UI Components
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "MASA"
        label.textColor = .themeSecondaryText
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let orangeDotView: UIView = {
        let dot = UIView()
        dot.backgroundColor = .systemOrange
        dot.layer.cornerRadius = 4
        return dot
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .themeSecondaryText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topLabel, numberLabel, statusLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - Highlight Animation
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupCell() {
        backgroundColor = .themeCardBackground
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
        
        contentView.addSubview(orangeDotView)
        contentView.addSubview(stackView)
        
        orangeDotView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.width.height.equalTo(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Configure
    func configure(with masa: RestaurantTable) {
        numberLabel.text = "\(masa.id)"
        
        if masa.isFull {
            backgroundColor = UIColor.themeOrange.withAlphaComponent(0.15)
            layer.borderColor = UIColor.themeOrange.cgColor
            numberLabel.textColor = .themeOrange
            topLabel.textColor = .themeOrange
            statusLabel.text = String(format: "%.0f ₺", masa.currentSubtotal)
            statusLabel.textColor = .white
            orangeDotView.isHidden = false
        } else {
            backgroundColor = .themeCardBackground
            layer.borderColor = UIColor.clear.cgColor
            numberLabel.textColor = .white
            topLabel.textColor = .themeSecondaryText
            statusLabel.text = "Boş"
            statusLabel.textColor = .themeSecondaryText
            orangeDotView.isHidden = true
        }
    }
}
