//
//  RestaurantTable.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 16.07.2026.
//

import Foundation

struct RestaurantTable {
    let id: Int
    var name: String { "Masa \(id)" }
    var isFull: Bool = false
    var finalizedOrders: [CartItems] = []
    
    var currentSubtotal: Double {
        return finalizedOrders.reduce(0.0) { $0 + ($1.menuItem.price * Double($1.quantity)) }
    }
    
    var currentTotal: Double {
        return currentSubtotal + (currentSubtotal * 0.10)
    }
}
