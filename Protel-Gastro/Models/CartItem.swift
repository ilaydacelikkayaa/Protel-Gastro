//
//  CartItem.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//
import Foundation

struct CartItem {
    let menuItem: MenuItem
    var quantity: Int
    
    var totalItemPrice: Double {
        return menuItem.priceDouble * Double(quantity)
    }
}
