//
//  BillViewModel.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 13.07.2026.
//

import Foundation

final class BillViewModel {
    
    // MARK: - Properties
    private let tableId: Int
    
    private(set) var finalizedItems: [CartItems] = []
    
    // MARK: - Init
    init(tableId: Int) {
        self.tableId = tableId
        loadData()
    }
    
    // MARK: - Methods
    func loadData() {
        self.finalizedItems = RestaurantStateManager.shared.getCart(for: tableId)
    }
    
    // MARK: - Hesaplama Lojikleri (Hesaplanan Mülkler)
    var subtotal: Double {
        return finalizedItems.reduce(0.0) { $0 + ($1.menuItem.price * Double($1.quantity)) }
    }
    
    var serviceCharge: Double {
        return subtotal * 0.10
    }
    
    var generalTotal: Double {
        return subtotal + serviceCharge
    }
    
    var title: String {
        return "Masa \(tableId) — Adisyon"
    }
    // MARK: - Actions
    func closeTable() {
        RestaurantStateManager.shared.closeTable(tableId: tableId)
    }
}
