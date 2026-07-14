//
//  RestaurantRouter.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 8.07.2026.
//



import Foundation

// MARK: - Restaurant Router
enum RestaurantRouter {
    case fetchProducts
    case fetchProductDetail(id: Int)
    case fetchMeals(category:String)
    
    var url: URL? {
        switch self {
        case .fetchProducts:
            let urlString = Constants.API.productURL + Constants.API.productsEndpoint
            return URL(string: urlString)
            
        case .fetchProductDetail(let id):
            let urlString = Constants.API.productURL + Constants.API.productsEndpoint + "/\(id)"
            return URL(string: urlString)
        case .fetchMeals(let category):
            let urlString = Constants.API.foodURL + "/api/json/v1/1/filter.php?c=\(category)"
            return URL(string: urlString)
        }
     
        
    }
}
