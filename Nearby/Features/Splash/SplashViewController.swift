//
//  SplashViewController.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit

class SplashViewController: UIViewController {

    private var screen: SplashScreen?
    
    override func loadView() {
        screen = SplashScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}
