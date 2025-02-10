//
//  WelcomeView.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/12/24.
//

import UIKit

class WelcomeView: UIView {
    
    var didTapButton: (() -> Void)?

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logoIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Boas vindas ao Nearby!"
        label.font = Typography.titleXL
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tenha cupons de vantagem para usar em seus estabelecimentos favoritos."
        label.font = Typography.textMD
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subTextForTips: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Veja como funciona:"
        label.font = Typography.textMD
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tipsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 24
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Começar", for: .normal)
        button.titleLabel?.font = Typography.action
        button.backgroundColor = Colors.greenBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTap() {
        didTapButton?()
    }
    
    private func setVisualElements() {
        self.setTips()
        self.addSubview(logoImageView)
        self.addSubview(welcomeLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(subTextForTips)
        self.addSubview(tipsStackView)
        self.addSubview(startButton)
        self.setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 28),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            subTextForTips.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            subTextForTips.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            
            tipsStackView.topAnchor.constraint(equalTo: subTextForTips.bottomAnchor, constant: 24),
            tipsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            tipsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            
            startButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            startButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            startButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setTips() {
        let tip1 = TipsView(icon: UIImage(named: "mapIcon") ?? UIImage(), title: "Encontre estabelecimentos", description: "Veja locais perto de você que são parceiros Nearby")
        
        let tip2 = TipsView(icon: UIImage(named: "qrcode") ?? UIImage(), title: "Ative o cupom com QR Code", description: "Escaneie o código no estabelecimento para usar o benefício")
        
        let tip3 = TipsView(icon: UIImage(named: "ticket") ?? UIImage(), title: "Garanta vantagens perto de você", description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento")
        
        tipsStackView.addArrangedSubview(tip1)
        tipsStackView.addArrangedSubview(tip2)
        tipsStackView.addArrangedSubview(tip3)
    }
}
