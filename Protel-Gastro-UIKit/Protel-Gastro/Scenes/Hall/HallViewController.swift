//
//  HallViewController.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//

import UIKit
import SnapKit

final class HallViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = HallViewModel()
    private var clockTimer: Timer?
    // MARK: - UI Components
    private let topSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "RESTORAN"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Salon Düzeni"
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .themeOrange
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let doluCountLabel = UILabel()
    private let bosCountLabel = UILabel()
    private let siparisCountLabel = UILabel()

    #warning("tüm UI bileşenlerini lazy var yapmanı ne gibi bir sorunu olabilir ben selfe ihtiyacı olanları yaptım")
    private lazy var doluCardView: UIView = createStatCard(icon: "person.2.fill", color: .themeOrange, title: "Dolu", countLabel: doluCountLabel)
    private lazy var bosCardView: UIView = createStatCard(icon: "fork.knife", color: .systemGreen, title: "Boş", countLabel: bosCountLabel)
    private lazy var toplamSiparisCardView: UIView = createStatCard(icon: "ticket.fill", color: .systemBlue, title: "Sipariş", countLabel: siparisCountLabel)
    
    private lazy var cardsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [doluCardView, bosCardView, toplamSiparisCardView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        updateUpperCards()
        updateCurrentTime()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        updateUpperCards()
        collectionView.reloadData()
        clockTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
                self?.updateCurrentTime()
            }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clockTimer?.invalidate()
        clockTimer = nil
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .themeBackground
        
        view.addSubview(topSubtitleLabel)
        view.addSubview(titleLabel)
        view.addSubview(timeLabel)
        view.addSubview(cardsStackView)
        view.addSubview(collectionView)
        
        topSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topSubtitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(20)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        cardsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(64)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(cardsStackView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(TableCell.self, forCellWithReuseIdentifier: TableCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func createStatCard(icon: String, color: UIColor, title: String, countLabel: UILabel) -> UIView {
        let card = UIView()
        card.backgroundColor = .themeCardBackground
        card.layer.cornerRadius = 16
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = color
        
        countLabel.textColor = .white
        countLabel.font = .systemFont(ofSize: 20, weight: .bold)
        countLabel.text = "0"
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .themeSecondaryText
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        card.addSubview(iconView)
        card.addSubview(countLabel)
        card.addSubview(titleLabel)
        
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(12)
            make.top.equalToSuperview().offset(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(countLabel.snp.leading)
            make.top.equalTo(countLabel.snp.bottom).offset(2)
        }
        return card
    }
    
    private func updateUpperCards() {
        doluCountLabel.text = "\(viewModel.fullTableCount)"
        bosCountLabel.text = "\(viewModel.emptyTableCount)"
        siparisCountLabel.text = "\(viewModel.totalOrderCount)"
    }
    private func updateCurrentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = formatter.string(from: Date())
    }
}

// MARK: - UICollectionViewDataSource & DelegateFlowLayout
extension HallViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tables.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCell.identifier, for: indexPath) as? TableCell else {
            return UICollectionViewCell()
        }
        let masa = viewModel.tables[indexPath.item]
        cell.configure(with: masa)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 32) / 3
        return CGSize(width: width, height: width * 1.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTable = viewModel.tables[indexPath.item]
        
        if selectedTable.isFull {
            let billVC = BillViewController(tableId: selectedTable.id)
            navigationController?.pushViewController(billVC, animated: true)
        } else {
            let menuVC = MenuViewController(tableId: selectedTable.id)
            navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
