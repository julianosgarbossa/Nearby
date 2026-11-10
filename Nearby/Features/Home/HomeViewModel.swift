//
//  HomeViewModel.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didUpdateCategories()
    func didUpdateSelectedCategory()
    func didUpdatePlaces()
}

final class HomeViewModel {
    private weak var delegate: HomeViewModelDelegate?
    
    func delegate(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    private var service = HomeService()
    private(set) var categories: [Category] = []
    private(set) var selectedCategoryID: String?
    private(set) var places: [Place] = []
    private var placesRequestID = UUID()

    var selectedCategoryIndex: Int? {
        categories.firstIndex { $0.id == selectedCategoryID }
    }
    
    var numberOfRowsInSection: Int {
        return places.count
    }
    
    func loadCurrentPlace(index: Int) -> Place {
        return places[index]
    }
    
    
    func fetchCategories() {
        service.fetchCategories { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let success):
                self.categories = success
                self.selectedCategoryID = success.first?.id
                self.delegate?.didUpdateCategories()
                self.fetchPlaces()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func selectCategory(index: Int) {
        guard categories.indices.contains(index) else { return }

        selectedCategoryID = categories[index].id
        delegate?.didUpdateSelectedCategory()
        fetchPlaces()
    }

    func fetchPlaces() {
        let requestID = UUID()
        placesRequestID = requestID

        places = []
        delegate?.didUpdatePlaces()

        guard let categoryID = selectedCategoryID else { return }

        service.fetchPlaces(categoryID: categoryID) { [weak self] result in
            guard let self, self.placesRequestID == requestID else { return }

            switch result {
            case .success(let success):
                self.places = success
                self.delegate?.didUpdatePlaces()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
