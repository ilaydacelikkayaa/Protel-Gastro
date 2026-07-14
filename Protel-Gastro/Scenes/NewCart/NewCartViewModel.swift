//
//  NewCartViewModel.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 13.07.2026.
//

import Foundation

class NewCartViewModel {
    
    let tableId: Int
    
    var cartItem: [CartItem] {
        return CartManager.shared.getCart(for: tableId)
    }
    
    var subtotal: Double {
        return cartItem.reduce(0.0) { $0 + (Double($1.quantity) * $1.menuItem.price) }
    }
    
    var servicefee: Double {
        return subtotal * 0.10
    }
    
    var total: Double {
        return subtotal + servicefee
    }
    
    init(tableId: Int) {
        self.tableId = tableId
    }
    
    func incrementQuantity(for item: CartItem) {
        CartManager.shared.updateQuantity(tableId:tableId, menuItem: item.menuItem, change: 1)
    }

    func decrementQuantity(for item: CartItem) {
        CartManager.shared.updateQuantity(tableId: tableId, menuItem: item.menuItem, change: -1)
    }
    
    func goToKitchen() {
        if let index = RestaurantStateManager.shared.tables.firstIndex(where: { $0.id == tableId }) {
            RestaurantStateManager.shared.tables[index].isFull = true
            RestaurantStateManager.shared.tables[index].currentSubtotal = total
        }
        RestaurantStateManager.shared.finalizeCartToTable(tableId: tableId, items: cartItem)
        CartManager.shared.resetCart(tableId: tableId)
    }
}
