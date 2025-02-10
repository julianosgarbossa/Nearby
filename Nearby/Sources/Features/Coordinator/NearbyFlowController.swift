//
//  NearbyFlowController.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/12/24.
//

import UIKit

class NearbyFlowController {
    private var navigationController: UINavigationController?
    
    public init() {
    
    }
    
    public func start() -> UINavigationController? {
        let contentView = SplashView()
        let startViewController = SplashViewController(contentView: contentView, delegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

extension NearbyFlowController: SplashFlowDelegate {
    func decideNavigationFlow() {
        let contentView = WelcomeView()
        let welcomeViewController = WelcomeViewController(contentView: contentView)
        welcomeViewController.flowDelegate = self
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}

extension NearbyFlowController: WelcomeFlowDelegate {
    func goToHome() {
        let homeViewController = HomeViewController()
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}
