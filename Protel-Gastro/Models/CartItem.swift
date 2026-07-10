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
    var kitchenNote: String?
    
    var totalItemPrice: Double {
        return menuItem.price * Double(quantity)
    }
}
