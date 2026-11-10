//
//  HomeService.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import Foundation

final class HomeService {
    private let baseURL = "https://gist.githubusercontent.com/julianosgarbossa/f3ecf0abab3da68244ffd5db6845ffab/raw/b752173da486b77d35d9721d91d7035fac338fbc/"
    
    func fetchCategories(completion: @escaping @Sendable (Result<[Category], NetworkError>) -> Void) {
        let urlString: String = baseURL + "category.json"
        Service.shared.fetchRequest(urlString: urlString, decodeType: [Category].self) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    completion(.success(success))
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }
    
    func fetchPlaces(categoryID: String, completion: @escaping @Sendable (Result<[Place], NetworkError>) -> Void) {
        let urlString: String = baseURL + categoryID + ".json"
        Service.shared.fetchRequest(urlString: urlString, decodeType: [Place].self) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    completion(.success(success))
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    completion(.failure(failure))
                }
            }
        }
    }
}
