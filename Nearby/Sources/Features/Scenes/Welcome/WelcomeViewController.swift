//
//  WelcomeViewController.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/12/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    let contentView: WelcomeView?
    weak var flowDelegate: WelcomeFlowDelegate?
    
    init(contentView: WelcomeView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        
        contentView.didTapButton = { [weak self] in
            self?.flowDelegate?.goToHome()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setVisualElements()
    }
    
    private func setVisualElements() {
        guard let contentView else { return }
        self.view.addSubview(contentView)
        view.backgroundColor = Colors.gray100
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        guard let contentView else { return }
        self.setContentViewToViewController(contentView: contentView)
    }
}
