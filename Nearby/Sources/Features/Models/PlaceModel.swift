//
//  PlaceModel.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 11/12/24.
//

import Foundation

struct Place: Codable {
    let id: String
    let name: String
    let description: String
    let coupons: Int
    let latitude: Double
    let longitude: Double
    let address: String
    let phone: String
    let cover: String
    let categoryId: String
}
