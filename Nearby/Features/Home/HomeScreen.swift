//
//  HomeScreen.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit
import MapKit

protocol HomeScreenDelegate: AnyObject {
    func didSelectCategory(index: Int)
}

class HomeScreen: UIView {
    private weak var delegate: HomeScreenDelegate?
    private var containerTopConstraint: NSLayoutConstraint?
    private let collapsedPanelOffset: CGFloat = -24
    
    private var expandedPanelOffset: CGFloat {
        min(collapsedPanelOffset, -bounds.height * 0.25)
    }
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var filterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 9
        stackView.distribution = .fill
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.gray100
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var dragIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.backgroundColor = Color.gray300
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Explore locais perto de você"
        label.font = Typography.textMD
        label.textColor = Color.gray600
        return label
    }()
    
    private lazy var placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
        return tableView
    }()
    
    @objc
    private func filterButtonTapped(_ sender: UIButton) {
        delegate?.didSelectCategory(index: sender.tag)
    }
    
    @objc
    private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        guard let containerTopConstraint else { return }
        
        let expandedOffset = expandedPanelOffset
        
        switch sender.state {
        case .changed:
            let translation = sender.translation(in: self)
            let newConstant = containerTopConstraint.constant + translation.y
            containerTopConstraint.constant = min(collapsedPanelOffset, max(expandedOffset, newConstant))
            sender.setTranslation(.zero, in: self)
            layoutIfNeeded()
            
        case .ended, .cancelled, .failed:
            let velocity = sender.velocity(in: self).y
            let midpoint = (expandedOffset + collapsedPanelOffset) / 2
            let finalPosition: CGFloat
            
            if sender.state == .ended && abs(velocity) > 300 {
                finalPosition = velocity > 0 ? collapsedPanelOffset : expandedOffset
            } else {
                finalPosition = containerTopConstraint.constant > midpoint ? collapsedPanelOffset : expandedOffset
            }
            
            layoutIfNeeded()
            containerTopConstraint.constant = finalPosition
            UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.layoutIfNeeded()
            }
        default:
            break
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
        setupPanGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        addSubview(mapView)
        addSubview(filterScrollView)
        filterScrollView.addSubview(filterStackView)
        addSubview(containerView)
        containerView.addSubview(dragIndicatorView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(placesTableView)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65),
            
            filterScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            filterScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            filterScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterScrollView.heightAnchor.constraint(equalToConstant: 44),
            
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.contentLayoutGuide.topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.contentLayoutGuide.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.contentLayoutGuide.trailingAnchor, constant: -24),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.contentLayoutGuide.bottomAnchor),
            filterStackView.heightAnchor.constraint(equalTo: filterScrollView.frameLayoutGuide.heightAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dragIndicatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            dragIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dragIndicatorView.widthAnchor.constraint(equalToConstant: 80),
            dragIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            
            descriptionLabel.topAnchor.constraint(equalTo: dragIndicatorView.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            placesTableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            placesTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            placesTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            placesTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
        ])
        
        containerTopConstraint = containerView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: collapsedPanelOffset)
        containerTopConstraint?.isActive = true
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        containerView.addGestureRecognizer(panGesture)
    }
    
    func configDelegate(delegate: HomeScreenDelegate) {
        self.delegate = delegate
    }
    
    func updateFilterButtons(categories: [Category]) {
        for view in filterStackView.arrangedSubviews {
            filterStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        let categoryIcons: [String: String] = [
            "Alimentação": "fork.knife",
            "Compras": "cart",
            "Hospedagem": "bed.double",
            "Padaria": "cup.and.saucer",
            "Cinema": "movieclapper"
        ]
        
        for (index, category) in categories.enumerated() {
            let iconName = categoryIcons[category.name] ?? "questionmark.circle"
            let button = createFilterButton(title: category.name, iconName: iconName)
            button.tag = index
            button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
            filterStackView.addArrangedSubview(button)
        }
    }
    
    private func createFilterButton(title: String, iconName: String) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        var attributedTitle = AttributedString(title)
        attributedTitle.font = Typography.textSM
        configuration.attributedTitle = attributedTitle
        configuration.image = UIImage(systemName: iconName)
        configuration.imagePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        configuration.background.cornerRadius = 8
        configuration.baseBackgroundColor = Color.gray100
        configuration.baseForegroundColor = Color.gray600
        
        return UIButton(configuration: configuration)
    }
    
    func updateCategorySelection(selectedIndex: Int?) {
        for case let button as UIButton in filterStackView.arrangedSubviews {
            guard var configuration = button.configuration else { continue }
            
            let isSelected = button.tag == selectedIndex
            button.isSelected = isSelected
            configuration.baseBackgroundColor = isSelected ? Color.greenBase : Color.gray100
            configuration.baseForegroundColor = isSelected ? Color.gray100 : Color.gray600
            button.configuration = configuration
            button.accessibilityTraits = isSelected ? [.button, .selected] : [.button]
        }
    }
    
    func configMapViewProtocol(delegate: MKMapViewDelegate) {
        mapView.delegate = delegate
    }
    
    func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        placesTableView.delegate = delegate
        placesTableView.dataSource = dataSource
    }
    
    func reloadTableView() {
        placesTableView.reloadData()
    }
}
