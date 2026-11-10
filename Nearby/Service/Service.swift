//
//  Service.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import Foundation

final class Service {
    static let shared: Service = Service()
    
    private init() {}
    
    func fetchRequest<T: Decodable & SendableMetatype>(urlString: String, decodeType: T.Type, completion: @escaping @Sendable (Result<T, NetworkError>) -> Void) {
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.networkFailure(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(decodeType, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
