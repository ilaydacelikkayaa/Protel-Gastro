//
//  ProductViewModel.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 9.07.2026.
//

import Foundation
import UIKit

class ProductViewModel {
    
    private let product: MenuItem
    var onQuantityChanged: ((Int) -> Void)?
    var onTotalPriceChanged: ((String) -> Void)?
    
    init(product: MenuItem) {
        self.product = product
    }
    
    var productName: String {
        return product.name
    }
    private(set) var quantity: Int = 1
    
    
    var productPriceText: String {
        return String(format: "%.2f ₺", product.price)
    }
    
    var orderCountText: String {
        return "Bugün \(product.orderCount) adet sipariş edildi"
    }
    
    var isPopular: Bool {
        return product.rating >= 4.0
    }
    var urlString: String{
        return product.imageUrl
    }
    
    func calculateTotalPrice(for count: Int) -> String {
        let total = Double(count) * product.price
        return String(format: "%.2f ₺", total)
    }
    
    func fetchImage(completion: @escaping (UIImage?) ->Void) {
        
        ImageLoader.shared.loadImage(from: urlString){ image in
            completion(image)
        }
    }
    func decreaseQuantity() {
            guard quantity > 1 else { return }
            quantity -= 1
            triggerUpdates()
        }
    
    func increaseQuantity() {
        quantity += 1
        triggerUpdates()
    }
    
    func processKitchenNote(_ text: String?) -> String? {
            guard let text = text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                return nil
            }
            return text
        }
    private func triggerUpdates() {
            onQuantityChanged?(quantity)
            onTotalPriceChanged?(calculateTotalPrice(for: quantity))
        }
}

