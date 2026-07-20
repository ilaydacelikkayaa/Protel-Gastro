//
//  ProductDetailViewModel.swift
//  Protel-Gastro-SwiftUI
//

import Foundation
import Combine

@MainActor
final class ProductDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    let product: MenuItem
    let tableId: Int
    
    @Published var quantity: Int = 1
    @Published var kitchenNote: String = ""
    
    // MARK: - Init
    init(product: MenuItem, tableId: Int) {
        self.product = product
        self.tableId = tableId
    }
    
    // MARK: - Computed Properties (UIKit'teki getter'ların karşılığı)
    var productName: String {
        return product.name
    }
    
    var productPriceText: String {
        return String(format: "%.2f ₺", product.price)
    }
    
    var orderCountText: String {
        return "Bugün \(product.orderCount) adet sipariş edildi"
    }
    
    var isPopular: Bool {
        return product.rating >= 4.0
    }
    
    var totalPriceText: String {
        let total = Double(quantity) * product.price
        return String(format: "%.2f ₺", total)
    }
    
    // MARK: - Business Logic
    func increaseQuantity() {
        quantity += 1
    }
    
    func decreaseQuantity() {
        guard quantity > 1 else { return }
        quantity -= 1
    }
    
    func addToCart() {
        let trimmedNote = kitchenNote.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalNote = trimmedNote.isEmpty ? nil : trimmedNote
        
        CartManager.shared.addItem(
            tableId: tableId,
            menuItem: product,
            quantity: quantity,
            kitchenNote: finalNote
        )
    }
}
