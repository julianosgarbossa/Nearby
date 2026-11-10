//
//  SplashViewController.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func decideNavigationFlow()
}

class SplashViewController: UIViewController {
    private weak var delegate: SplashViewControllerDelegate?
    
    func delegate(delegate: SplashViewControllerDelegate) {
        self.delegate = delegate
    }

    private var screen: SplashScreen?
    
    override func loadView() {
        screen = SplashScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decideFlow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func decideFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.delegate?.decideNavigationFlow()
        }
    }
}
