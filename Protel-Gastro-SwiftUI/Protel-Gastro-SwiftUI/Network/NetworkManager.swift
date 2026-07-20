import Foundation

// MARK: - Network Error Enum
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
}

// MARK: - Network Manager
final class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Modern Async Generic Fetch Method
    func fetch<T: Decodable>(request: RestaurantRouter) async throws -> T {
        
        guard let url = request.url else {
            throw NetworkError.invalidURL
        }
        
        let data: Data
        let response: URLResponse
        
        do {
            
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw NetworkError.unknown(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData 
        } catch {
            throw NetworkError.decodingError
        }
    }
}
