import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Error)
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://fakestoreapi.com"
    
    func fetchProducts(completion: @escaping (Result<[StoreProduct], NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/products") else {
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
                let products = try JSONDecoder().decode([StoreProduct].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
