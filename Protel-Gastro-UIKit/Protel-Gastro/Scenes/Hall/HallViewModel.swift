import Foundation

final class HallViewModel {
    
    var tables: [RestaurantTable] {
        return RestaurantStateManager.shared.tables
    }
    
    var fullTableCount: Int {
        return tables.filter { $0.isFull }.count
    }
    
    var emptyTableCount: Int {
        return tables.filter { !$0.isFull }.count
    }
    
    var totalOrderCount: Int {
        return RestaurantStateManager.shared.totalSentOrdersCount
    }
    
}
