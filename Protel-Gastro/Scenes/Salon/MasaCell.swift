//
//  MasaCell.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//

import UIKit
import SnapKit

final class MasaCell: UICollectionViewCell {
    static let identifier = "MasaCell"
    
    private let topLabel: UILabel = {
            let label = UILabel()
            label.text = "MASA"
            label.textColor = .themeSecondaryText
            label.font = .systemFont(ofSize: 12, weight: .bold)
            label.textAlignment = .center
            return label
        }()
    let numberLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = .systemFont(ofSize: 48, weight: .bold)
            label.textAlignment = .center
            return label
        }()
    let statusLabel: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
            backgroundColor = .themeCardBackground
            layer.cornerRadius = 16 // Köşeleri biraz daha yumuşattık
            
            // Tasarımdaki o şık turuncu noktayı (Dolu masalar için) ileride eklemek üzere
            // kartın kenarlık yapısını hazırlıyoruz
            layer.borderWidth = 1
            layer.borderColor = UIColor.clear.cgColor
            
            addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(16)
                make.leading.trailing.equalToSuperview().inset(8)
            }
        }
    
    func configure(with masa: RestaurantTable) {
            numberLabel.text = "\(masa.id)"
            
            if masa.isFull {
                backgroundColor = UIColor.themeOrange.withAlphaComponent(0.15) 
                layer.borderColor = UIColor.themeOrange.cgColor
                numberLabel.textColor = .themeOrange
                topLabel.textColor = .themeOrange
                statusLabel.text = String(format: "%.0f ₺", masa.currentSubtotal)
                statusLabel.textColor = .white
            } else {
                backgroundColor = .themeCardBackground
                layer.borderColor = UIColor.clear.cgColor
                numberLabel.textColor = .white
                topLabel.textColor = .themeSecondaryText
                statusLabel.text = "Boş"
                statusLabel.textColor = .themeSecondaryText
            }
        }
    }
