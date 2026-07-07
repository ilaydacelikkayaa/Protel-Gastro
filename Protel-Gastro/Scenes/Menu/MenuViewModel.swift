//
//  MenuViewModel.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 7.07.2026.
//

import Foundation

final class MenuViewModel{
    
    var allMenuItems: [MenuItem] = []
    var categories: [String] = []
    var filteredItems: [MenuItem] = []
    var onDataUpdated: (() -> Void)?
    
 func fetchMenuData(){
        
        NetworkManager.shared.fetchProducts{ [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let storeProducts):
                print("API ürün sayısı:", storeProducts.count)

                self.allMenuItems = storeProducts.map { $0.toMenuItem() }

                print("MenuItem sayısı:", self.allMenuItems.count)
                print("Kategoriler:", self.allMenuItems.map { $0.menuCategory })

                let uniqueCategories = Set(self.allMenuItems.map { $0.menuCategory })
                self.categories = Array(uniqueCategories).sorted()

                print("Kategori sayısı:", self.categories.count)

                self.filteredItems = self.allMenuItems

                self.onDataUpdated?()
            case .failure(let error):
                print("Menü verisi çekilirken hata oluştu: \(error)")
            }
        }
    }

    func numberOfItems() -> Int {
        return filteredItems.count
    }

    func item(at index: Int) -> MenuItem {
        return filteredItems[index]
    }
    
    func filterMenu(by category:String?){
        guard let category = category, !category.isEmpty else{
            self.filteredItems = self.allMenuItems
                    self.onDataUpdated?()
                    return
        }
        self.filteredItems = self.allMenuItems.filter { $0.menuCategory == category }
        self.onDataUpdated?()
    }
    func searchMenu(with text: String) {
        if text.isEmpty {
            self.filteredItems = self.allMenuItems
        } else {
            self.filteredItems = self.allMenuItems.filter { item in
                item.name.localizedCaseInsensitiveContains(text)
            }
        }
        self.onDataUpdated?()
    }
}
