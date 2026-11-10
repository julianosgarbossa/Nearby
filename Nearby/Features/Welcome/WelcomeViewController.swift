//
//  WelcomeViewController.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit

class WelcomeViewController: UIViewController {

    private var screen: WelcomeScreen?
    
    override func loadView() {
        screen = WelcomeScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
