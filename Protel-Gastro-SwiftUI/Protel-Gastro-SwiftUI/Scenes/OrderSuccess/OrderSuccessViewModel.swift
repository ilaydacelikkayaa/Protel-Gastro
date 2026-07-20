//
//  OrderSuccessViewModel.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//

import Foundation

final class OrderSuccessViewModel{
    let tableId: Int
    let orderAmount: Double
    
    init(tableId: Int, orderAmount: Double) {
        self.tableId = tableId
        self.orderAmount = orderAmount
    }
    var titleText: String {
            "Sipariş Mutfağa\nGönderildi!"
        }
        
        var subtitleText: String {
            "Masa \(tableId) siparişi mutfağa iletildi."
        }
        
        var amountText: String {
            String(format: "%.2f ₺", orderAmount)
        }
}
