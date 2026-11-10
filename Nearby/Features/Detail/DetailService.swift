//
//  DetailService.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import Foundation

final class DetailService {
    func fetchCoverImage(urlString: String, completion: @escaping @Sendable (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL(url: urlString)))
            }
            return nil
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let result: Result<Data, NetworkError>

            if let error {
                result = .failure(.networkFailure(error))
            } else if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                if let data {
                    result = .success(data)
                } else {
                    result = .failure(.noData)
                }
            } else {
                result = .failure(.invalidResponse)
            }

            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
        return task
    }
}
