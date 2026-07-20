//
//  NewCartViewModel.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//

import Foundation
import Combine

@MainActor
final class NewCartViewModel: ObservableObject {
    
    // MARK: - Properties
    let tableId: Int
    @Published var cartItems: [CartItems] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(tableId: Int) {
        self.tableId = tableId
        setupCartObserver()
    }
    
    // MARK: - Cart Observer
    private func setupCartObserver() {
        CartManager.shared.$tableCarts
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.cartItems = CartManager.shared.getCart(for: self.tableId)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Computed Properties
    var subtotal: Double {
        cartItems.reduce(0.0) { $0 + (Double($1.quantity) * $1.menuItem.price) }
    }
    
    var serviceFee: Double {
        subtotal * 0.10
    }
    
    var total: Double {
        subtotal + serviceFee
    }
    
    // MARK: - Actions
    func incrementQuantity(for item: CartItems) {
        CartManager.shared.updateQuantity(tableId: tableId, menuItem: item.menuItem, change: 1)
    }
    
    func decrementQuantity(for item: CartItems) {
        CartManager.shared.updateQuantity(tableId: tableId, menuItem: item.menuItem, change: -1)
    }
    
    func goToKitchen() -> Double {
        let orderTotal = total
        RestaurantStateManager.shared.finalizeCartToTable(tableId: tableId, items: cartItems)
        CartManager.shared.clearCart(tableId: tableId)
        return orderTotal
    }
}
