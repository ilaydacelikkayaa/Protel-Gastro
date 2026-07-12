//
//  ImageLoader.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 12.07.2026.
//
import UIKit

final class ImageLoader{
    
    static let shared = ImageLoader()
    
    private init(){}
    
    func loadImage(from urlString:String, completion:@escaping (UIImage?)->Void){
        NetworkManager.shared.downloadImage(from: urlString) { result in
            
            switch result {
                
            case .success(let data):
                
                let image = UIImage(data: data)
                
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
