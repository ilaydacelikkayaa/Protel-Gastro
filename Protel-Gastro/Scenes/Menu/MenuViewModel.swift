//
//  MenuViewModel.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 7.07.2026.
//

import Foundation

final class MenuViewModel {
    
    // MARK: - Properties
    private(set) var allMenuItems: [MenuItem] = []
    private(set) var categories: [String] = []
    private(set) var filteredItems: [MenuItem] = []
    private(set) var selectedCategory: String?
    
    // MARK: - Closures (Data Binding)
    var onDataUpdated: (() -> Void)?
    
    // MARK: - Networking
    func fetchMenuData() {
        NetworkManager.shared.fetchProducts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let storeProducts):
                self.allMenuItems = storeProducts.map { $0.toMenuItem() }
                
                let uniqueCategories = Set(self.allMenuItems.map { $0.menuCategory })
                self.categories = Array(uniqueCategories).sorted()
                
                self.filteredItems = self.allMenuItems
                self.onDataUpdated?()
                
            case .failure(let error):
                print("Menü verisi çekilirken hata oluştu: \(error)")
            }
        }
    }
    
    // MARK: - Helper Methods
    func numberOfItems() -> Int {
        return filteredItems.count
    }
    
    func item(at index: Int) -> MenuItem {
        return filteredItems[index]
    }
    
    // MARK: - Business Logic 
    func filterMenu(by category: String?) {
        self.selectedCategory = category 
        
        guard let category = category, !category.isEmpty else {
            filteredItems = allMenuItems
            onDataUpdated?()
            return
        }
        filteredItems = allMenuItems.filter { $0.menuCategory == category }
        onDataUpdated?()
    }
    
    func searchMenu(with text: String) {
        if text.isEmpty {
            filteredItems = allMenuItems
        } else {
            filteredItems = allMenuItems.filter { item in
                item.name.localizedCaseInsensitiveContains(text)
            }
        }
        onDataUpdated?()
    }
    
}
