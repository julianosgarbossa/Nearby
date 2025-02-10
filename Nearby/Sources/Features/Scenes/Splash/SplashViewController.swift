//
//  SplashViewController.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/12/24.
//

import UIKit

class SplashViewController: UIViewController {

    let contentView: SplashView?
    weak var delegate: SplashFlowDelegate?
    
    init(contentView: SplashView, delegate: SplashFlowDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setVisualElements()
        
        decideFlow()
    }
    
    private func setVisualElements() {
        guard let contentView else { return }
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.greenLight
        self.setConstraints()
    }
    
    private func setConstraints() {
        guard let contentView else { return }
        self.setContentViewToViewController(contentView: contentView)
    }
    
    private func decideFlow() {
        // decidir se o usuario vai para a tela home ou para tela de dicas
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.delegate?.decideNavigationFlow()
        }
    }
}
