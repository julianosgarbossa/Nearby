//
//  WelcomeViewController.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit

protocol WelcomeViewControllerDelegate: AnyObject {
    func goToHome()
}

class WelcomeViewController: UIViewController {
    private weak var delegate: WelcomeViewControllerDelegate?
    
    func delegate(delegate: WelcomeViewControllerDelegate) {
        self.delegate = delegate
    }
    
    private var screen: WelcomeScreen?
    
    override func loadView() {
        screen = WelcomeScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    private func configProtocols() {
        screen?.delegate(delegate: self)
    }
}

extension WelcomeViewController: WelcomeScreenDelegate {
    func tappedStartButton() {
        delegate?.goToHome()
    }
}
