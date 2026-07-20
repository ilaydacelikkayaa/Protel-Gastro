//
//  MenuViewModel.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 17.07.2026.
//

import Foundation
import Combine

@MainActor
final class MenuViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var filteredItems: [MenuItem] = []
    @Published var categories: [String] = []
    @Published var selectedCategory: String?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    private var allMenuItems: [MenuItem] = []
    
    // MARK: - Init
    init() {
        fetchMenuData()
    }
    
    // MARK: - Networking & Business Logic
    func fetchMenuData() {
        Task {
            self.isLoading = true
            self.errorMessage = nil
            
            do {
               
                async let fetchedProducts: [StoreProduct] = NetworkManager.shared.fetch(request: .fetchProducts)
                
                let categoriesToFetch = ["Dessert", "Beef", "Chicken", "Seafood", "Pasta"]
                var allDownloadedFoods: [FoodItem] = []
                
                for categoryName in categoriesToFetch {
                    let response: MealResponse = try await NetworkManager.shared.fetch(request: .fetchMeals(category: categoryName))
                    
                    let mappedMeals = response.meals.map { meal -> FoodItem in
                        var updatedMeal = meal
                        updatedMeal.category = categoryName
                        return updatedMeal
                    }
                    allDownloadedFoods.append(contentsOf: mappedMeals)
                }
                
                let storeProducts = try await fetchedProducts
                
                guard !storeProducts.isEmpty else {
                    self.isLoading = false
                    return
                }
                
                var combinedItems: [MenuItem] = []
                
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
                
                if let firstCategory = self.categories.first {
                    self.filterMenu(by: firstCategory)
                }
                
                self.isLoading = false
                
            } catch {
                print("Menü yüklenirken hata oluştu: \(error)")
                self.errorMessage = "Menü yüklenirken bir hata oluştu. Lütfen internet bağlantınızı kontrol edin."
                self.isLoading = false
            }
        }
    }
    
    // MARK: - Business Logic
    func filterMenu(by category: String) {
        self.selectedCategory = category
        
        self.filteredItems = allMenuItems.filter { item in
            return item.category.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == category.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
