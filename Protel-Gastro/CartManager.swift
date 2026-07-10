//
//  CartManager.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 10.07.2026.
//

import Foundation

final class CartManager{
    //Tüm uygulamada sadece tek bir sepet merkezi olacak
    static let shared = CartManager()
    
    private init(){}
    
    private(set) var items: [CartItem] = []
    
    var onCartUpdated: (() -> Void)?
    // MARK: - Business Logic
    
    func addItem(menuItem:MenuItem,quantity:Int,kitchenNote:String?){
        if let index = items.firstIndex(where: {$0.menuItem.id == menuItem.id && $0.kitchenNote == kitchenNote}){
            items[index].quantity += quantity
        }
        else{
            let newItem = CartItem(menuItem: menuItem, quantity: quantity, kitchenNote: kitchenNote)
            items.append(newItem)
        }
        onCartUpdated?()
    }
    func getTotalPrice() -> Double {
        return items.reduce(0.0) { $0 + $1.totalItemPrice }
    }
    
    func getTotalCount() -> Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}
