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
    
    var onErrorOccurred: ((String) -> Void)?
    
    // MARK: - Networking
    func fetchMenuData() {
        let group = DispatchGroup()
        var storeProducts: [StoreProduct] = []
        var allDownloadedFoods: [FoodItem] = []
        let categoriesToFetch = ["Dessert", "Beef", "Chicken", "Seafood", "Pasta"]
        
        group.enter()
        NetworkManager.shared.fetch(request: .fetchProducts) { (result: Result<[StoreProduct], NetworkError>) in
            switch result {
            case .success(let products):
 #warning("sınıfın başına @MainActor yazsaydık? dispatchqueue.main.async kullanımlarını kaldırsaydık?")
                DispatchQueue.main.async {
                    storeProducts = products
                    group.leave()
                }
                
            case .failure(let error):
                print("Fiyatlar çekilirken hata: \(error)")
                DispatchQueue.main.async {
                    self.onErrorOccurred?("Menü yüklenirken bir hata oluştu. Lütfen internet bağlantınızı kontrol edin.")
                }
                group.leave()
            }
            
        }
        
        for categoryName in categoriesToFetch {
            group.enter()
            NetworkManager.shared.fetch(request: .fetchMeals(category: categoryName)) { (result: Result<MealResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    let mappedMeals = response.meals.map { meal -> FoodItem in
                        var updatedMeal = meal
                        updatedMeal.category = categoryName
                        return updatedMeal
                    }
                    DispatchQueue.main.async {
                        allDownloadedFoods.append(contentsOf: mappedMeals)
                        group.leave() //Başarılı gruptan çık
                    }
                    
                case .failure(let error):
                    print("\(categoryName) kategorisi çekilirken hata: \(error)")
                    DispatchQueue.main.async {
                        self.onErrorOccurred?("Menü yüklenirken bir hata oluştu. Lütfen internet bağlantınızı kontrol edin.")
                    }
                    group.leave() // Başarısız: Doğrudan gruptan çık.
                }
                
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            var combinedItems: [MenuItem] = []
            
            guard !storeProducts.isEmpty else { return }
            
            for i in 0..<allDownloadedFoods.count {
                
                let food = allDownloadedFoods[i]
                let mealId = Int(food.idMeal) ?? 0
                
                let product = storeProducts[mealId % storeProducts.count]
                
                let item = MenuItem(
                    id: "\(food.idMeal)-\(i)",
                    name: food.strMeal,
                    price: product.price,
                    rating: product.rating.rate,
                    category: food.category ?? "Diğer",
                    imageUrl: food.strMealThumb,
                    orderCount: product.rating.count
                )
                combinedItems.append(item)
            }
            
            self.allMenuItems = combinedItems
            
            let uniqueCategories = Set(self.allMenuItems.map { $0.category })
            self.categories = Array(uniqueCategories).sorted()
            
            filterMenu(by: self.categories.first ?? "Beef")
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
        
        filteredItems = allMenuItems.filter { item in
            return item.category.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == category.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        }
        onDataUpdated?()
    }
}
