//
//  FlowCoordinator.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit

final class FlowCoordinator {
    private var navigationController: UINavigationController?
    
    init() {
        
    }
    
    func start() -> UINavigationController? {
        let splashViewController = SplashViewController()
        splashViewController.delegate(delegate: self)
        navigationController = UINavigationController(rootViewController: splashViewController)
        return navigationController
    }
}

extension FlowCoordinator: SplashViewControllerDelegate {
    func decideNavigationFlow() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.delegate(delegate: self)
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}

extension FlowCoordinator: WelcomeViewControllerDelegate {
    func goToHome() {
        let homeViewController = HomeViewController()
        homeViewController.delegate(delegate: self)
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}

extension FlowCoordinator: HomeViewControllerDelegate {
    func didSelectPlace(place: Place) {
        let detailViewController = DetailViewController(place: place)
        detailViewController.delegate(delegate: self)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension FlowCoordinator: DetailViewControllerDelegate {
    func goBackToHome() {
        navigationController?.popViewController(animated: true)
    }
}
