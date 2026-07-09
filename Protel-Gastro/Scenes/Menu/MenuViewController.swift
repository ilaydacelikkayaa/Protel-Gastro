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
        
        setupBindings()
        setupUI()
        viewModel.fetchMenuData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        navigationController?.navigationBar.tintColor = .white
    
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.addSubview(kategoriCollectionView)
        view.addSubview(urunCollectionView)
        
        kategoriCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        urunCollectionView.snp.makeConstraints { make in
            make.top.equalTo(kategoriCollectionView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        kategoriCollectionView.dataSource = self
        kategoriCollectionView.delegate = self
        urunCollectionView.dataSource = self
        urunCollectionView.delegate = self
        
        kategoriCollectionView.register(KategoriCell.self, forCellWithReuseIdentifier: KategoriCell.reuseIdentifier)
        urunCollectionView.register(YemekCell.self, forCellWithReuseIdentifier: YemekCell.reuseIdentifier)
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
                    // Eğer hiçbir şey seçili değilse varsayılan olarak ilkini seç
                    let defaultIndexPath = IndexPath(item: 0, section: 0)
                    self.kategoriCollectionView.selectItem(at: defaultIndexPath, animated: false, scrollPosition: .left)
                }
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
            let selectedProduct=viewModel.item(at:indexPath.item)
            let detailVC = UrunDetayViewController(product:selectedProduct)
            detailVC.modalPresentationStyle = .pageSheet
            if let sheet = detailVC.sheetPresentationController {
                    sheet.detents = [.medium(), .large()]
                    sheet.prefersGrabberVisible = true
                }
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}
