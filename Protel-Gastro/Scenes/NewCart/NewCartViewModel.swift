//
//  NewCartViewModel.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 13.07.2026.
//

import Foundation

class NewCartViewModel {
    
    let tableId: Int
    
    var cartItem: [CartItems] {
        return CartManager.shared.getCart(for: tableId)
    }
    
    var subtotal: Double {
        return cartItem.reduce(0.0) { $0 + (Double($1.quantity) * $1.menuItem.price) }
    }
    
    var serviceFee: Double {
        return subtotal * 0.10
    }
    
    var total: Double {
        return subtotal + serviceFee
    }
    
    init(tableId: Int) {
        self.tableId = tableId
    }
    
    func incrementQuantity(for item: CartItems) {
        CartManager.shared.updateQuantity(tableId:tableId, menuItem: item.menuItem, change: 1)
    }

    func decrementQuantity(for item: CartItems) {
        CartManager.shared.updateQuantity(tableId: tableId, menuItem: item.menuItem, change: -1)
    }
    
    func goToKitchen() -> Double {
            let orderTotal = total
            
            RestaurantStateManager.shared.finalizeCartToTable(tableId: tableId, items: cartItem)
            
        CartManager.shared.clearCart(tableId: tableId)
            
            return orderTotal
        }
}
