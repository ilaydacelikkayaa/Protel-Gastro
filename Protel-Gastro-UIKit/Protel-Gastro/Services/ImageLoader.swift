//
//  ImageLoader.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 12.07.2026.
//
import UIKit

final class ImageLoader {
    
    static let shared = ImageLoader()
    
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] result in
            switch result {
                
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                self?.cache.setObject(image, forKey: cacheKey)
                
                DispatchQueue.main.async {
                    completion(image)
                }
                
            case .failure:
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
