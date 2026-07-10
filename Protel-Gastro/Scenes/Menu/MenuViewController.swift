//
//  MenuViewController.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = MenuViewModel()
    private let tableName: String
    private let searchController = UISearchController(searchResultsController: nil)
    private var urunCollectionViewBottomConstraint: Constraint?
    init(tableName: String) {
        self.tableName = tableName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI Components
    private let kategoriCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.estimatedItemSize = CGSize(width: 100, height: 50)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let basketBarView: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .themeOrange
        button.layer.cornerRadius = 16
        button.isHidden = true
        return button
    }()
    
    private let urunCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .themeBackground
        self.title = self.tableName
        setupBindings()
        setupUI()
        viewModel.fetchMenuData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Menu görünmeye başladı")
        updateBasketBarStatus()
    }

    private func updateBasketBarStatus() {
        let totalCount = CartManager.shared.getTotalCount()
        let totalPrice = CartManager.shared.getTotalPrice()
        
        if totalCount > 0 {
            basketBarView.isHidden = false
            
            var titleAttr = AttributedString("Sepeti Gör (\(totalCount) Ürün) — \(String(format: "%.2f ₺", totalPrice))")
            titleAttr.font = .systemFont(ofSize: 16, weight: .bold)
            basketBarView.configuration = .filled()
            basketBarView.configuration?.baseForegroundColor = .white
            basketBarView.configuration?.background.backgroundColor = .themeOrange
            basketBarView.configuration?.attributedTitle = titleAttr
            
            urunCollectionViewBottomConstraint?.deactivate()
            urunCollectionView.snp.makeConstraints { make in
                self.urunCollectionViewBottomConstraint = make.bottom.equalTo(basketBarView.snp.top).offset(-8).constraint
            }
            
        } else {
            basketBarView.isHidden = true
            
            urunCollectionViewBottomConstraint?.deactivate()
            urunCollectionView.snp.makeConstraints { make in
                self.urunCollectionViewBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            }
        }
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.addSubview(kategoriCollectionView)
        view.addSubview(urunCollectionView)
        view.addSubview(basketBarView)
        kategoriCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        basketBarView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }

        urunCollectionView.snp.makeConstraints { make in
            make.top.equalTo(kategoriCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            
            self.urunCollectionViewBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
        }
        
        kategoriCollectionView.dataSource = self
        kategoriCollectionView.delegate = self
        urunCollectionView.dataSource = self
        urunCollectionView.delegate = self
        
        kategoriCollectionView.register(KategoriCell.self, forCellWithReuseIdentifier: KategoriCell.reuseIdentifier)
        urunCollectionView.register(YemekCell.self, forCellWithReuseIdentifier: YemekCell.reuseIdentifier)
        basketBarView.addTarget(self, action: #selector(basketBarTapped), for: .touchUpInside)
    }
    
    @objc private func basketBarTapped() {
        print("Sepet sayfasına dinamik olarak \(tableName) verisiyle gidiliyor...")
    }
 
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.kategoriCollectionView.reloadData()
                self.urunCollectionView.reloadData()
                
                if let selectedCategory = self.viewModel.selectedCategory,
                   let index = self.viewModel.categories.firstIndex(of: selectedCategory) {
                    let indexPath = IndexPath(item: index, section: 0)
                    self.kategoriCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                } else if !self.viewModel.categories.isEmpty {
                    let defaultIndexPath = IndexPath(item: 0, section: 0)
                    self.kategoriCollectionView.selectItem(at: defaultIndexPath, animated: false, scrollPosition: .left)
                }
            }
        }
        CartManager.shared.onCartUpdated = { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.updateBasketBarStatus()
                }
            }
    }
    
}

// MARK: - UICollectionViewDataSource & DelegateFlowLayout
extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == kategoriCollectionView {
            return viewModel.categories.count
        }
        return viewModel.filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == kategoriCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KategoriCell.reuseIdentifier, for: indexPath) as? KategoriCell else {
                return UICollectionViewCell()
            }
            let categoryName = viewModel.categories[indexPath.item]
            cell.configure(with: categoryName)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YemekCell.reuseIdentifier, for: indexPath) as? YemekCell else {
                return UICollectionViewCell()
            }
            let itemModel = viewModel.item(at: indexPath.item)
            cell.configure(with: itemModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == kategoriCollectionView {
            return (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize ?? CGSize(width: 100, height: 50)
        } else {
            return CGSize(width: collectionView.frame.width - 32, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == kategoriCollectionView {
            let selectedCategory = viewModel.categories[indexPath.item]
            viewModel.filterMenu(by: selectedCategory)
        }
        else{
            let selectedProduct = viewModel.item(at: indexPath.item)
            let detailVC = UrunDetayViewController(product: selectedProduct)
            
            detailVC.modalPresentationStyle = .overFullScreen
            
            self.present(detailVC, animated: true, completion: nil)
        }
    }
    
}
extension MenuViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.searchMenu(with: searchText)
    }
}
