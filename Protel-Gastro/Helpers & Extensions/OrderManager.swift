//
//  OrderManager.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//
import Foundation

final class OrderManager{
    
    // MARK: - Properties
    static let shared = OrderManager()
    var tables: [RestaurantTable] = []
    private var tableCarts: [Int: [CartItem]] = [:]
    
    var totalRevenue:Double{
        return tables.reduce(0.0){ $0 + $1.currentSubtotal}
    }
    
    // MARK: - Init
    private init() {
        setupInitialTables()
    }
    
    // MARK: - Methods
    private func setupInitialTables() {
        for i in 1...12 {
            tables.append(RestaurantTable(id: i))
        }
        tables[1].isFull = true
        tables[1].currentSubtotal = 320.0
        tables[1].guestCount = 2
        tables[1].orderTime = "18:45"
    }
    
    func getCart(for tableId:Int) -> [CartItem]{
        return tableCarts[tableId] ?? []
    }
}
