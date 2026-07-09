//
//  UrunViewModel.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 9.07.2026.
//

import Foundation

class UrunViewModel {
    
    private let product: MenuItem
    
    init(product: MenuItem) {
            self.product = product
        }
    
    func calculateTotalPrice(for count: Int) -> String {
        let total = Double(count) * product.price
        return String(format: "%.2f ₺", total) 
    }
}
