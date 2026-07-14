//
//  CartManager.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 10.07.2026.
//

import Foundation

final class CartManager{
    //Geçici alışveriş sepeti
    static let shared = CartManager()
    
    private var tableCarts: [Int: [CartItems]] = [:]
    
    private init(){}
    
    
    var onCartUpdated: (() -> Void)?
    
    // MARK: - Business Logic
    func getCart(for tableId: Int) -> [CartItems] {
        return tableCarts[tableId] ?? []
    }
    
    func addItem(tableId:Int,menuItem:MenuItem,quantity:Int,kitchenNote:String?){
        var currentCart = getCart(for: tableId)
        if let index=currentCart.firstIndex(where:{ $0.menuItem.id == menuItem.id && $0.kitchenNote == kitchenNote }) {
            currentCart[index].quantity += quantity
            
        }
        else{
            let newitem=CartItems(menuItem: menuItem, quantity: quantity, kitchenNote: kitchenNote)
            currentCart.append(newitem)
        }
        tableCarts[tableId] = currentCart
        onCartUpdated?()
    }
    
    func getTotalPrice(tableId:Int) -> Double {
        var currentPrice = getCart(for: tableId)
        return currentPrice.reduce(0.0){$0 + $1.totalItemPrice}
    }
    
    func getTotalCount(tableId:Int) -> Int {
        var currentPrice = getCart(for: tableId)
        return currentPrice.reduce(0){$0 + $1.quantity}
    }
    
    func updateQuantity(tableId:Int,menuItem: MenuItem, change: Int){
        var currentCart = getCart(for: tableId)
        if let index = currentCart.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            currentCart[index].quantity += change
            if currentCart[index].quantity <= 0 {
                currentCart.remove(at: index)
            }
        }
        tableCarts[tableId] = currentCart
        onCartUpdated?()
    }
    func clearCart(tableId: Int){
        tableCarts[tableId] = []
    }
}
