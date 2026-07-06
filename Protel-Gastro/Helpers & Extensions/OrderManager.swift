//
//  OrderManager.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//
import Foundation
final class OrderManager{
    
    static let shared = OrderManager()
    
    private init() {
        setupInitialTables()
    }
    
    var tables: [RestaurantTable] = []
    private var tableCarts: [Int: [CardItem]] = [:]
    
    private func setupInitialTables() {
        for i in 1...12 {
            tables.append(RestaurantTable(id: i))
        }
        tables[1].isFull = true
        tables[1].currentSubtotal = 320.0
        tables[1].guestCount = 2
        tables[1].orderTime = "18:45"
    }
    
    var totalRevenue:Double{
        return tables.reduce(0.0){ $0 + $1.currentSubtotal}
    }
    
    func getCard(for tableId:Int) -> [CardItem]{
        return tableCarts[tableId] ?? []
    }
}
