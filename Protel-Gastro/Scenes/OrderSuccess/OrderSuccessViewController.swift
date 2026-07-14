//
//  OrderSuccessViewController.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 13.07.2026.
//

import UIKit
import SnapKit

final class OrderSuccessViewController: UIViewController {
    
    private let viewModel: OrderSuccessViewModel
    
    init(tableId: Int, orderAmount: Double) {
        self.viewModel = OrderSuccessViewModel(tableId: tableId, orderAmount: orderAmount)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private let iconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.themeOrange.withAlphaComponent(0.15)
        view.layer.cornerRadius = 50
        return view
    }()
    
    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "paperplane.fill")
        iv.tintColor = .themeOrange
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let successTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let amountCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.05)
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .themeOrange
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let amountSubLabel: UILabel = {
        let label = UILabel()
        label.text = "sipariş tutarı"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let homeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .themeOrange
        config.baseForegroundColor = .white
        
        var titleAttr = AttributedString("Salona Dön")
        titleAttr.font = .systemFont(ofSize: 18, weight: .bold)
        config.attributedTitle = titleAttr
        
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .themeBackground
        setupUI()
        configureData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func configureData() {
        successTitleLabel.text = viewModel.titleText
        subtitleLabel.text = viewModel.subtitleText
        amountLabel.text = String(format: "%.2f ₺", viewModel.orderAmount)
    }
    
    private func setupUI() {
        view.addSubview(iconContainerView)
        iconContainerView.addSubview(iconView)
        view.addSubview(successTitleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(amountCardView)
        amountCardView.addSubview(amountLabel)
        amountCardView.addSubview(amountSubLabel)
        view.addSubview(homeButton)
        
        // MARK: - SnapKit Constraints
        iconContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(44)
        }
        
        successTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconContainerView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(successTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        amountCardView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(100)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        amountSubLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        homeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func homeButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
