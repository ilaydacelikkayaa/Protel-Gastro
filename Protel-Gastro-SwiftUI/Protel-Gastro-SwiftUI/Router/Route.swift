//
//  Route.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//

enum Route: Hashable {
    case menu(tableId: Int)
    case cart(tableId: Int)
    case success(tableId: Int, amount: Double)
    case bill(tableId:Int)
}
