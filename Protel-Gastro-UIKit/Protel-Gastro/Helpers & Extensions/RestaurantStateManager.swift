import Foundation

final class RestaurantStateManager {
    
    // MARK: - Properties
    static let shared = RestaurantStateManager()
    var tables: [RestaurantTable] = []
    
    var totalSentOrdersCount: Int = 0
    
    // MARK: - Init
    private init() {
        setupInitialTables()
    }
    
    // MARK: - Methods
    private func setupInitialTables() {
        for i in 1...50 {
            tables.append(RestaurantTable(id: i))
        }
    }
    
    func getCart(for tableId: Int) -> [CartItems] {
        guard let index = tables.firstIndex(where: { $0.id == tableId }) else { return [] }
        return tables[index].finalizedOrders
    }
    
    func finalizeCartToTable(tableId: Int, items: [CartItems]) {
            guard let index = tables.firstIndex(where: { $0.id == tableId }) else { return }
            
            tables[index].finalizedOrders.append(contentsOf: items)
            tables[index].isFull = true
            
            let sentQuantity = items.reduce(0) { $0 + $1.quantity }
            totalSentOrdersCount += sentQuantity
        }
    
    func closeTable(tableId: Int) {
            guard let index = tables.firstIndex(where: { $0.id == tableId }) else { return }
            
            tables[index].isFull = false
            tables[index].finalizedOrders.removeAll()
        }
    
}
