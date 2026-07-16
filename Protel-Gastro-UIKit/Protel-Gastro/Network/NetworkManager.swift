//
//  NetworkManager.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 8.07.2026.
//



import Foundation

// MARK: - Network Error Enum
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Error)
}

// MARK: - Network Manager
final class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Public Methods
    //generic yapı
    #warning("burada neden async yapısını kullanmadık?")
    func fetch<T: Decodable>(
        request: RestaurantRouter,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ){
        guard let url = request.url else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    // MARK: - Image Download Method
    func downloadImage(from urlString: String, completion: @escaping (Result <Data, NetworkError>)-> Void){
        guard let url = URL(string: urlString) else {
                completion(.failure(.invalidURL))
                return
            }
        URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(.serverError(error)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                completion(.success(data))
            }.resume()
        }
    }
