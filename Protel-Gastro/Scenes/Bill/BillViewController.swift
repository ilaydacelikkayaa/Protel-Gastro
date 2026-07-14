import UIKit
import SnapKit

final class BillViewController: UIViewController {
    
    // MARK: - Properties
    private let tableId: Int
    // 🎯 Artık doğrudan ViewModel ile konuşuyoruz
    private let viewModel: BillViewModel
    
    init(tableId: Int) {
        self.tableId = tableId
        self.viewModel = BillViewModel(tableId: tableId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components (Tüm tanımlamalar aynı kalıyor...)
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        button.layer.cornerRadius = 22
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let closeTableButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        button.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: config), for: .normal)
        button.tintColor = .systemRed // Kırmızı vurgu
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        button.layer.cornerRadius = 22
        return button
    }()
    
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
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let subtotalValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let serviceChargeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Servis Bedeli (%10)"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let serviceChargeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1.0)
        return view
    }()
    
    private let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Genel Toplam"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let totalValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .themeOrange
        label.textAlignment = .right
        return label
    }()
    
    private let addOrderButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .themeOrange
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "plus")
        config.imagePadding = 8
        
        var titleAttr = AttributedString("Sipariş Ekle")
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        viewModel.loadData()
        updateUI()
    }
    
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(closeTableButton)
        view.addSubview(summaryContainerView)
        view.addSubview(addOrderButton)
        
        summaryContainerView.addSubview(subtotalTitleLabel)
        summaryContainerView.addSubview(subtotalValueLabel)
        summaryContainerView.addSubview(serviceChargeTitleLabel)
        summaryContainerView.addSubview(serviceChargeValueLabel)
        summaryContainerView.addSubview(dividerLine)
        summaryContainerView.addSubview(totalTitleLabel)
        summaryContainerView.addSubview(totalValueLabel)
        
        // MARK: - SnapKit Constraints
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(44)
        }
        closeTableButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.leading.equalTo(backButton.snp.trailing).offset(16)
            make.trailing.equalTo(closeTableButton.snp.leading).offset(-16)
        }
        
        addOrderButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        summaryContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(addOrderButton.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(160)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(summaryContainerView.snp.top).offset(-16)
        }
        
        subtotalTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        subtotalValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(subtotalTitleLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        serviceChargeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(subtotalTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
        
        serviceChargeValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(serviceChargeTitleLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        dividerLine.snp.makeConstraints { make in
            make.top.equalTo(serviceChargeTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        totalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerLine.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
        }
        
        totalValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalTitleLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BillCell.self, forCellReuseIdentifier: BillCell.identifier)
        
        addOrderButton.addTarget(self, action: #selector(addOrderButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        closeTableButton.addTarget(self, action: #selector(closeTableButtonTapped), for: .touchUpInside)
    }
    
    private func updateUI() {
        titleLabel.text = viewModel.title
        subtotalValueLabel.text = String(format: "%.2f ₺", viewModel.subtotal)
        serviceChargeValueLabel.text = String(format: "%.2f ₺", viewModel.serviceCharge)
        totalValueLabel.text = String(format: "%.2f ₺", viewModel.generalTotal)
        tableView.reloadData()
    }
    
    @objc private func addOrderButtonTapped() {
        let menuVC = MenuViewController(tableId: self.tableId)
        navigationController?.pushViewController(menuVC, animated: true)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func closeTableButtonTapped() {
            let alert = UIAlertController(
                title: "Hesabı Kapat",
                message: "Masa \(self.tableId) hesabını kapatıp masayı boşaltmak istediğinize emin misiniz?",
                preferredStyle: .alert
            )
            
            let confirmAction = UIAlertAction(title: "Evet, Kapat", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.closeTable()
                self.navigationController?.popViewController(animated: true) // Salona geri döner
            }
            
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    }


// MARK: - UITableView Veri Kaynağı
extension BillViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.finalizedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BillCell.identifier, for: indexPath) as? BillCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.finalizedItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
