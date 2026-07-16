//
//  NewCartViewController.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//

import SnapKit
import UIKit

class NewCartViewController: UIViewController {
    
    private let viewModel: NewCartViewModel
    
    // MARK: - Top UI Components
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let subheaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Mutfağa göndermeden önce kontrol edin"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    // MARK: - Summary Card UI Components
    private let summaryContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let subtotalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ara Toplam"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let subtotalValueLabel: UILabel = {
        let label = UILabel()
        label.text = "85 ₺"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let serviceFeeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Servis Bedeli (%10)"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let serviceFeeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "9 ₺"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0)
        return view
    }()
    
    private let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Genel Toplam"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let totalValueLabel: UILabel = {
        let label = UILabel()
        label.text = "94 ₺"
        label.textColor = .systemOrange
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    // MARK: - Bottom Action Button
    private let kitchenButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .themeOrange
        button.layer.cornerRadius = 16
        button.setTitle("Siparişi Mutfağa Gönder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    // MARK: - Init
    init(tableId: Int) {
        self.viewModel = NewCartViewModel(tableId: tableId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .themeBackground
        setupUI()
        configureData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(headerLabel)
        view.addSubview(subheaderLabel)
        view.addSubview(tableView)
        view.addSubview(summaryContainerView)
        view.addSubview(kitchenButton)
        
        summaryContainerView.addSubview(subtotalTitleLabel)
        summaryContainerView.addSubview(subtotalValueLabel)
        summaryContainerView.addSubview(serviceFeeTitleLabel)
        summaryContainerView.addSubview(serviceFeeValueLabel)
        summaryContainerView.addSubview(separatorLine)
        summaryContainerView.addSubview(totalTitleLabel)
        summaryContainerView.addSubview(totalValueLabel)
        
        // MARK: - Constraints
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        subheaderLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(4)
            make.leading.equalTo(headerLabel.snp.leading)
        }
        
        kitchenButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        kitchenButton.addTarget(self, action: #selector(kitchenButtonTapped), for: .touchUpInside)
        
        summaryContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(kitchenButton.snp.top).offset(-24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subheaderLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(summaryContainerView.snp.top).offset(-16)
        }
        
        // MARK: - Summary Card Inner Constraints
        subtotalTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        subtotalValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(subtotalTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        serviceFeeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(subtotalTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
        }
        
        serviceFeeValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(serviceFeeTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(serviceFeeTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        totalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        totalValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    private func configureSummaryCard(subtotal: Double, serviceFee: Double, total: Double) {
        subtotalValueLabel.text = String(format: "%.2f ₺", subtotal)
        serviceFeeValueLabel.text = String(format: "%.2f ₺", serviceFee)
        totalValueLabel.text = String(format: "%.2f ₺", total)
    }
    
    private func configureData() {
        headerLabel.text = "Masa \(viewModel.tableId) — Yeni Sepet"
        
        configureSummaryCard(
            subtotal: viewModel.subtotal,
            serviceFee: viewModel.serviceFee,
            total: viewModel.total
        )
    }
    private func refreshScreen() {
        tableView.reloadData()
        configureData()
    }
    
    @objc private func kitchenButtonTapped() {
        let finalAmount = viewModel.goToKitchen()
        
        let successVC = OrderSuccessViewController(tableId: viewModel.tableId, orderAmount: finalAmount)
        
        navigationController?.pushViewController(successVC, animated: true)
    }
}

// MARK: - UITableViewDataSource & Delegate
extension NewCartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier, for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        
        let currentItem = viewModel.cartItem[indexPath.row]
        
        cell.configure(with: currentItem)
        
        cell.didTapPlus = { [weak self] in
            self?.viewModel.incrementQuantity(for: currentItem)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        cell.didTapMinus = { [weak self] in
            self?.viewModel.decrementQuantity(for: currentItem)
            tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}
