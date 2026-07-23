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
    private let stateManager = RestaurantStateManager.shared
    //dinleme baglantısını cancellables icinde tasıyoruz
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        stateManager.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
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
