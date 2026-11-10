//
//  WelcomeScreen.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit

protocol WelcomeScreenDelegate: AnyObject {
    func tappedStartButton()
}

class WelcomeScreen: UIView {
    private weak var delegate: WelcomeScreenDelegate?
    
    func delegate(delegate: WelcomeScreenDelegate) {
        self.delegate = delegate
    }
    
    private lazy var logoIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logoIcon")
        return imageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Boas vindas ao Nearby!"
        label.font = Typography.titleXL
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Tenha cupons de vantagem para usar em seus estabelecimentos favoritos."
        label.font = Typography.textMD
        return label
    }()
    
    private lazy var subTextForTipsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Veja como funciona:"
        label.font = Typography.textMD
        return label
    }()
    
    private lazy var tipsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Começar", for: .normal)
        button.backgroundColor = Color.greenBase
        button.setTitleColor(Color.gray100, for: .normal)
        button.titleLabel?.font = Typography.action
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func tappedStartButton(_ sender: UIButton) {
        delegate?.tappedStartButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        backgroundColor = Color.gray100
        
        addSubview(logoIconImageView)
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(subTextForTipsLabel)
        addSubview(tipsStackView)
        addSubview(startButton)
        
        setupTips()
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            logoIconImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            logoIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            logoIconImageView.widthAnchor.constraint(equalToConstant: 48),
            logoIconImageView.heightAnchor.constraint(equalToConstant: 48),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoIconImageView.bottomAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            
            subTextForTipsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            subTextForTipsLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            subTextForTipsLabel.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            
            tipsStackView.topAnchor.constraint(equalTo: subTextForTipsLabel.bottomAnchor, constant: 24),
            tipsStackView.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            tipsStackView.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            
            startButton.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupTips() {
        guard let mapPin = UIImage(named: "map_pin"),
              let qrCode = UIImage(named: "qrcode"),
              let ticket = UIImage(named: "ticket") else { return }
        
        
        let tip1 = TipView(icon: mapPin, title: "Encontre estabelecimentos", description: "Veja locais perto de você que são parceiros Nearby")
        let tip2 = TipView(icon: qrCode, title: "Ative o cupom com QR Code", description: "Escaneie o código no estabelecimento para usar o benefício")
        let tip3 = TipView(icon: ticket, title: "Garanta vantagens perto de você", description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento")
        
        tipsStackView.addArrangedSubview(tip1)
        tipsStackView.addArrangedSubview(tip2)
        tipsStackView.addArrangedSubview(tip3)
    }
}
