//
//  HomeViewController.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit
import MapKit

protocol HomeViewControllerDelegate: AnyObject {
    func didSelectPlace(place: Place)
}

class HomeViewController: UIViewController {
    private weak var delegate: HomeViewControllerDelegate?

    func delegate(delegate: HomeViewControllerDelegate) {
        self.delegate = delegate
    }
    
    private var screen: HomeScreen?
    private let viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        screen = HomeScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
        defineInitialLocation()
        viewModel.fetchCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configProtocols() {
        screen?.configDelegate(delegate: self)
        screen?.configMapViewProtocol(delegate: self)
        screen?.configTableViewProtocols(delegate: self, dataSource: self)
        viewModel.delegate(delegate: self)
    }
    
    private func defineInitialLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude: -23.561187293883442, longitude: -46.656451388116494)
        screen?.mapView.setRegion(MKCoordinateRegion(center: initialLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
    }

    private func updateMapAnnotations() {
        guard let mapView = screen?.mapView else { return }

        let previousAnnotations = mapView.annotations.compactMap {
            $0 as? PlaceAnnotation
        }
        mapView.removeAnnotations(previousAnnotations)

        let annotations = viewModel.places.map { PlaceAnnotation(place: $0) }
        mapView.addAnnotations(annotations)

        if let firstAnnotation = annotations.first {
            let region = MKCoordinateRegion(
                center: firstAnnotation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            mapView.setRegion(region, animated: true)
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil}
        
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let pinImage = UIImage(named: "pin") {
                annotationView?.image = pinImage
                annotationView?.frame.size = CGSize(width: 50, height: 68)
            }
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let place = viewModel.loadCurrentPlace(index: indexPath.row)
        delegate?.didSelectPlace(place: place)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else { return UITableViewCell() }
        cell.setupCell(place: viewModel.loadCurrentPlace(index: indexPath.row))
        return cell
    }
}

extension HomeViewController: HomeScreenDelegate {
    func didSelectCategory(index: Int) {
        viewModel.selectCategory(index: index)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didUpdateCategories() {
        screen?.updateFilterButtons(categories: viewModel.categories)
        didUpdateSelectedCategory()
    }

    func didUpdateSelectedCategory() {
        screen?.updateCategorySelection(selectedIndex: viewModel.selectedCategoryIndex)
    }
    
    func didUpdatePlaces() {
        screen?.reloadTableView()
        updateMapAnnotations()
    }
}
