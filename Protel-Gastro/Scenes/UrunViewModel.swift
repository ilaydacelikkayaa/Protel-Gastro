//
//  UrunViewModel.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 9.07.2026.
//

import Foundation

class UrunViewModel {
    
    private let product: MenuItem
    
    init(product: MenuItem) {
        self.product = product
    }
    
    var productName: String {
        return product.name
    }
    
    var productPriceText: String {
        return String(format: "%.2f ₺", product.price)
    }
    
    var orderCountText: String {
        return "Bugün \(product.orderCount) adet sipariş edildi"
    }
    
    var isPopular: Bool {
        return product.rating >= 4.0
    }
    var urlString: String{
        return product.imageUrl
    }
    
    func calculateTotalPrice(for count: Int) -> String {
        let total = Double(count) * product.price
        return String(format: "%.2f ₺", total)
    }
    func fetchImageData(completion: @escaping (Data?) -> Void) {
        NetworkManager.shared.downloadImage(from: urlString) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("Görsel verisi indirilemedi: \(error)")
                completion(nil)
            }
        }
    }
}
