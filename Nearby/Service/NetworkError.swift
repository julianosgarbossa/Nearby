//
//  NetworkError.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(url: String)
    case noData
    case invalidResponse
    case decodingError(Error)
    case networkFailure(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL(url: let url):
            return "URL inválida: \(url)"
        case .networkFailure(let error):
            return "Falha na rede: \(error.localizedDescription)"
        case .noData:
            return "Dados não recebidos da API"
        case .invalidResponse:
            return "Resposta inválida da API"
        case .decodingError(let error):
            return "Decodificação falhou: \(error.localizedDescription)"
        }
    }
}
