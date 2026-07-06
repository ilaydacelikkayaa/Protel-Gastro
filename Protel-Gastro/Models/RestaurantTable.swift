//
//  Untitled.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 6.07.2026.
//

import Foundation

struct RestaurantTable {
    let id: Int
    var name: String { "Masa \(id)" }
    var isFull: Bool = false
    var currentSubtotal: Double = 0.0
    var guestCount: Int = 0
    var orderTime: String? 
}
