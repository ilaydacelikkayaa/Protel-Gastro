//
//  Product.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 16.07.2026.
//

import Foundation

// MARK: - API Model
struct StoreProduct: Codable {
    let id: Int
    let price: Double
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}

// MARK: - Restoran UI Modeli
struct MenuItem: Identifiable {
    let id: String
    let name: String
    let price: Double
    let rating: Double
    let category: String
    let imageUrl: String
    let orderCount: Int
}
struct MealResponse: Codable {
    let meals: [FoodItem]
}

struct FoodItem: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var category: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strMealThumb
    }
}
