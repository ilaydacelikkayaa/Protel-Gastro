//
//  HallViewModel.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 16.07.2026.
//

import Foundation
import SwiftUI
import Combine

final class HallViewModel:ObservableObject {
    //observedobject yaparak stateManager'ı dinliyoruz.
    @ObservedObject private var stateManager = RestaurantStateManager.shared

    var tables: [RestaurantTable] {
        return stateManager.tables
    }
    
    var fullTableCount: Int {
        return tables.filter { $0.isFull }.count
    }
    
    var emptyTableCount: Int {
        return tables.filter { !$0.isFull }.count
    }
    
    var totalOrderCount: Int {
        return stateManager.totalSentOrdersCount
    }
    
}
