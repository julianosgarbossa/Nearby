//
//  PlaceTableViewCell.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: PlaceTableViewCell.self)
    
    private lazy var screen: PlaceTableViewCellScreen = {
        let screen = PlaceTableViewCellScreen()
        screen.translatesAutoresizingMaskIntoConstraints = false
        return screen
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        selectionStyle = .none
        
        contentView.addSubview(screen)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(place: Place) {
        if let url = URL(string: place.cover) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data, let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.screen.itemImageView.image = image
                    }
                }
            }
            .resume()
        }
        
        screen.titleLabel.text = place.name
        screen.descriptionLabel.text = place.description
        screen.ticketLabel.text = "\(place.coupons) cupons disponíveis"
    }
}
