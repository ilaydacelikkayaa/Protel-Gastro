//
//  Product.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//

import Foundation

// MARK: - API Model
struct StoreProduct: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
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
    let priceString: String
    let priceDouble: Double
    let ingredients: String
    let menuCategory: String
    let imageUrl: String
    let isPopular: Bool
    let orderCountString: String
}

// MARK: - Veri Dönüştürücü
extension StoreProduct {
    func toMenuItem() -> MenuItem {
        let maskedCategory: String
        switch self.category.lowercased() {
        case "electronics":
            maskedCategory = "Başlangıçlar"
        case "jewelery":
            maskedCategory = "Ana Yemekler"
        case "men's clothing":
            maskedCategory = "İçecekler"
        case "women's clothing":
            maskedCategory = "Tatlılar"
        default:
            maskedCategory = "Diğer"
        }
        let isPopularProduct = self.rating.rate >= 4.2
        return MenuItem(
            id: "\(self.id)",
            name: self.title,
            priceString: String(format: "%.2f ₺", self.price),
            priceDouble: self.price,
            ingredients: self.description,
            menuCategory: maskedCategory,
            imageUrl: self.image,
            isPopular: isPopularProduct,
            orderCountString: "Bugün \(self.rating.count) kez sipariş edildi"
        )
    }
}
