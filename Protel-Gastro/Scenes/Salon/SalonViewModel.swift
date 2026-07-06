//
//  Untitled.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//

import Foundation

final class SalonViewModel {
    

    var tables: [RestaurantTable] {
        return OrderManager.shared.tables
    }
    
        var totalOrderCountString: String {
            let activeOrders = tables.filter { $0.isFull }.count
            return "\(activeOrders)"
        }
    
    var fullTableCountString: String {
        let count = tables.filter { $0.isFull }.count
        return "\(count) Dolu"
    }
    
    var emptyTableCountString: String {
        let count = tables.filter { !$0.isFull }.count
        return "\(count) Boş"
    }
}
