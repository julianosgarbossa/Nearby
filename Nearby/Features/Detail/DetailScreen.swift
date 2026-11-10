//
//  DetailScreen.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit

protocol DetailScreenDelegate: AnyObject {
    func tappedBackButton()
}

class DetailScreen: UIView {
    private weak var delegate: DetailScreenDelegate?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Color.gray200
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.gray100
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.titleLG
        label.textColor = Color.gray600
        label.numberOfLines = 0
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.textMD
        label.textColor = Color.gray500
        label.numberOfLines = 0
        return label
    }()

    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.subtitle
        label.textColor = Color.gray500
        label.text = "Informações"
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var regulationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.subtitle
        label.textColor = Color.gray500
        label.text = "Regulamento"
        return label
    }()

    private lazy var regulationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.textSM
        label.textColor = Color.gray500
        label.numberOfLines = 0
        label.text = "• Válido apenas para consumo no local"
        return label
    }()

    private lazy var couponTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.subtitle
        label.textColor = Color.gray500
        label.text = "Utilize esse cupom"
        return label
    }()

    private lazy var couponCodeLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.textColor = Color.gray600
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var couponStackView: UIStackView = {
        let iconImageView = UIImageView(image: UIImage(systemName: "ticket"))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Color.greenBase
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])

        let stackView = UIStackView(arrangedSubviews: [iconImageView, couponCodeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.backgroundColor = Color.greenLight.withAlphaComponent(0.15)
        stackView.layer.cornerRadius = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return stackView
    }()

    private lazy var qrCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ler QR Code", for: .normal)
        button.backgroundColor = Color.greenBase
        button.titleLabel?.font = Typography.action
        button.setTitleColor(Color.gray100, for: .normal)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()

    private lazy var divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.gray200
        return view
    }()

    private lazy var secondDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.gray200
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.greenBase
        button.tintColor = Color.gray100
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.layer.cornerRadius = 8
        button.accessibilityLabel = "Voltar"
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func tappedBackButton(_ sender: UIButton) {
        delegate?.tappedBackButton()
    }

    private func addVisualElements() {
        backgroundColor = Color.gray100
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(coverImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(infoTitleLabel)
        containerView.addSubview(infoStackView)
        containerView.addSubview(divider)
        containerView.addSubview(regulationTitleLabel)
        containerView.addSubview(regulationLabel)
        containerView.addSubview(secondDivider)
        containerView.addSubview(couponTitleLabel)
        containerView.addSubview(couponStackView)
        containerView.addSubview(qrCodeButton)
        addSubview(backButton)

        configConstraints()
    }

    private func configConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),

            containerView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -20),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            infoTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            infoTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            infoTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            infoStackView.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant: 12),
            infoStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            infoStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            divider.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            divider.heightAnchor.constraint(equalToConstant: 1),

            regulationTitleLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            regulationTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            regulationTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            regulationLabel.topAnchor.constraint(equalTo: regulationTitleLabel.bottomAnchor, constant: 12),
            regulationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            regulationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            secondDivider.topAnchor.constraint(equalTo: regulationLabel.bottomAnchor, constant: 16),
            secondDivider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            secondDivider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            secondDivider.heightAnchor.constraint(equalToConstant: 1),

            couponTitleLabel.topAnchor.constraint(equalTo: secondDivider.bottomAnchor, constant: 16),
            couponTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            couponTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            couponStackView.topAnchor.constraint(equalTo: couponTitleLabel.bottomAnchor, constant: 12),
            couponStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            couponStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            qrCodeButton.topAnchor.constraint(equalTo: couponStackView.bottomAnchor, constant: 24),
            qrCodeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            qrCodeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            qrCodeButton.heightAnchor.constraint(equalToConstant: 48),
            qrCodeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32),

            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func createInfoRow(iconName: String, text: String) -> UIStackView {
        let iconImageView = UIImageView(image: UIImage(systemName: iconName))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Color.gray500
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])

        let label = UILabel()
        label.font = Typography.textSM
        label.textColor = Color.gray500
        label.numberOfLines = 0
        label.text = text

        let stackView = UIStackView(arrangedSubviews: [iconImageView, label])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 8
        return stackView
    }

    func configDelegate(delegate: DetailScreenDelegate) {
        self.delegate = delegate
    }

    func configureDetails(name: String, description: String, couponsText: String, address: String, phone: String, couponCode: String) {
        titleLabel.text = name
        descriptionLabel.text = description
        couponCodeLabel.text = couponCode

        for subview in infoStackView.arrangedSubviews {
            infoStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        infoStackView.addArrangedSubview(createInfoRow(iconName: "ticket", text: couponsText))
        infoStackView.addArrangedSubview(createInfoRow(iconName: "mappin.and.ellipse", text: address))
        infoStackView.addArrangedSubview(createInfoRow(iconName: "phone", text: phone))
    }

    func updateCoverImage(_ image: UIImage) {
        coverImageView.image = image
    }
}
