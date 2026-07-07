//
//  Menu.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//
 
import SnapKit
import UIKit

class MenuViewController: UIViewController {
    private let viewModel = MenuViewModel()
    
    private let kategoriCollectionView:UICollectionView={
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
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
    
    override func viewDidLoad() {
        view.backgroundColor = .themeBackground
        
        setupBindings()
        setUp()
        viewModel.fetchMenuData()
        
    }
    private func setUp() {
        view.addSubview(kategoriCollectionView)
        view.addSubview(urunCollectionView)
        
        kategoriCollectionView.snp.makeConstraints{
            make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
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
                }
            }
        if !self.viewModel.categories.isEmpty {
            let defaultIndexPath = IndexPath(item: 0, section: 0)
            self.kategoriCollectionView.selectItem(at: defaultIndexPath, animated: false, scrollPosition: .left)
        }
        }
}
extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        if collectionView == kategoriCollectionView {
            print("Kategori:", viewModel.categories.count)
            return viewModel.categories.count
        }

        print("Ürün:", viewModel.filteredItems.count)
        return viewModel.filteredItems.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == kategoriCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KategoriCell.reuseIdentifier, for: indexPath) as? KategoriCell else {
                return UICollectionViewCell()
            }
            let kategoriIsmi = viewModel.categories[indexPath.item]
            cell.configure(with: kategoriIsmi)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YemekCell.reuseIdentifier, for: indexPath) as? YemekCell else {
                return UICollectionViewCell()
            }
            let yemekModeli = viewModel.item(at: indexPath.item)
            cell.configure(with: yemekModeli)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView ==  kategoriCollectionView{
            return CGSize(width: 100, height: 40)
        }
        else{
            return CGSize(width: collectionView.frame.width - 32, height: 120)
        }
    }
}
