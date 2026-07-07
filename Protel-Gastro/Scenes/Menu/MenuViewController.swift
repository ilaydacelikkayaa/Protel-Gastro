//
//  Menu.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//
 
import SnapKit
import UIKit

class MenuViewController: UIViewController {
 
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
        setUp()
        
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
    }

}
extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == kategoriCollectionView {
            return 5
        } else {
            return 10
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeciciCell", for: indexPath)
        return cell
    }
}
