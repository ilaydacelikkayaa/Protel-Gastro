//
//  OrderSuccessViewModel.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 13.07.2026.
//

import Foundation

final class OrderSuccessViewModel {
    
    // MARK: - Properties
    private let tableId: Int
     let orderAmount: Double
    
    // MARK: - Init
    init(tableId: Int, orderAmount: Double) {
        self.tableId = tableId
        self.orderAmount = orderAmount
    }
    
    // MARK: - Outputs (Formatlanmış Veriler)
    var titleText: String {
        return "Sipariş Mutfağa\nGönderildi!"
    }
    
    var subtitleText: String {
        return "Masa \(tableId) siparişi mutfağa iletildi."
    }
    
    var amountText: String {
        return String(format: "%.0f ₺", orderAmount)
    }
}
