//
//  BillViewModel.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class BillViewModel: ObservableObject {
    @Published var finalizedItems: [CartItems] = []
    @Published var showCloseConfirmation = false

    private let tableId: Int

    init(tableId: Int) {
        self.tableId = tableId
        loadData()
    }
    func loadData() {
          self.finalizedItems = RestaurantStateManager.shared.getCart(for: tableId)
      }
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
    func requestCloseTable() {
        showCloseConfirmation = true
    }
    func closeTable() {
        
        RestaurantStateManager.shared.closeTable(
            tableId: tableId
        )
    }
}
