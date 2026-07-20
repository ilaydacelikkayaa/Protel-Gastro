//
//  CartManager.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 17.07.2026.
//

import Foundation
import Combine

final class CartManager: ObservableObject {
    
    // MARK: - Properties
    static let shared = CartManager()
    
  
    @Published var tableCarts: [Int: [CartItems]] = [:]
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Business Logic
    func getCart(for tableId: Int) -> [CartItems] {
        return tableCarts[tableId] ?? []
    }
    
    func addItem(tableId: Int, menuItem: MenuItem, quantity: Int, kitchenNote: String?) {
        var currentCart = getCart(for: tableId)
        
        if let index = currentCart.firstIndex(where: { $0.menuItem.id == menuItem.id && $0.kitchenNote == kitchenNote }) {
            currentCart[index].quantity += quantity
        } else {
            let newItem = CartItems(menuItem: menuItem, quantity: quantity, kitchenNote: kitchenNote)
            currentCart.append(newItem)
        }
        
        tableCarts[tableId] = currentCart
    }
    
    func getTotalPrice(tableId: Int) -> Double {
        let currentCart = getCart(for: tableId)
        return currentCart.reduce(0.0) { $0 + $1.totalItemPrice }
    }
    
    func getTotalCount(tableId: Int) -> Int {
        let currentCart = getCart(for: tableId)
        return currentCart.reduce(0) { $0 + $1.quantity }
    }
    
    func updateQuantity(tableId: Int, menuItem: MenuItem, change: Int) {
        var currentCart = getCart(for: tableId)
        
        if let index = currentCart.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            currentCart[index].quantity += change
            if currentCart[index].quantity <= 0 {
                currentCart.remove(at: index)
            }
        }
        
        tableCarts[tableId] = currentCart
    }
    
    func clearCart(tableId: Int) {
        tableCarts[tableId] = []
    }
}
