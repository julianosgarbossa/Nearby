//
//  DetailViewModel.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func didUpdateCoverImage()
}

final class DetailViewModel {
    private weak var delegate: DetailViewModelDelegate?
    private let service = DetailService()
    private let place: Place
    private var coverImageTask: URLSessionDataTask?
    private(set) var coverImageData: Data?
    
    init(place: Place) {
        self.place = place
    }
    
    deinit {
        coverImageTask?.cancel()
    }
    
    var name: String {
        place.name
    }
    
    var description: String {
        place.description
    }
    
    var couponsText: String {
        "\(place.coupons) cupons disponíveis"
    }
    
    var address: String {
        place.address
    }
    
    var phone: String {
        place.phone
    }
    
    var couponCode: String {
        place.id
    }
    
    func delegate(delegate: DetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchCoverImage() {
        coverImageTask?.cancel()
        coverImageTask = service.fetchCoverImage(urlString: place.cover) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.coverImageData = data
                self.delegate?.didUpdateCoverImage()
            case .failure(let error):
                print(error)
            }
        }
    }
}
