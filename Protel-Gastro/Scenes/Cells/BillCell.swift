//
//  BillCell.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 13.07.2026.
//

import UIKit
import SnapKit

final class BillCell: UITableViewCell {
    static let identifier = "BillCell"
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let countBadgeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let singlePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupCellUI() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(countBadgeView)
        countBadgeView.addSubview(countLabel)
        
        containerView.addSubview(textStackView)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(singlePriceLabel)
        
        containerView.addSubview(totalPriceLabel)
        
        // MARK: - SnapKit Constraints
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        countBadgeView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        countLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textStackView.snp.makeConstraints { make in
            make.leading.equalTo(countBadgeView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(totalPriceLabel.snp.leading).offset(-16)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        totalPriceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        totalPriceLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    // MARK: - Configure Data
    func configure(with item: CartItems) {
        countLabel.text = "\(item.quantity)"
        titleLabel.text = item.menuItem.name
        
        let singlePrice = item.menuItem.price
        let total = singlePrice * Double(item.quantity)
        
        singlePriceLabel.text = String(format: "%.2f ₺ / adet", singlePrice)
        totalPriceLabel.text = String(format: "%.2f ₺", total)
    }
}
