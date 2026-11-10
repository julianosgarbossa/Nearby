//
//  DetailViewController.swift
//  Nearby
//
//  Created by Juliano Sgarbossa on 10/11/26.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func goBackToHome()
}

class DetailViewController: UIViewController {
    private weak var delegate: DetailViewControllerDelegate?

    func delegate(delegate: DetailViewControllerDelegate) {
        self.delegate = delegate
    }

    private var screen: DetailScreen?
    private let viewModel: DetailViewModel

    init(place: Place) {
        viewModel = DetailViewModel(place: place)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        screen = DetailScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
        configureDetails()
        viewModel.fetchCoverImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func configProtocols() {
        screen?.configDelegate(delegate: self)
        viewModel.delegate(delegate: self)
    }

    private func configureDetails() {
        screen?.configureDetails(
            name: viewModel.name,
            description: viewModel.description,
            couponsText: viewModel.couponsText,
            address: viewModel.address,
            phone: viewModel.phone,
            couponCode: viewModel.couponCode
        )
    }
}

extension DetailViewController: DetailScreenDelegate {
    func tappedBackButton() {
        delegate?.goBackToHome()
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func didUpdateCoverImage() {
        guard let data = viewModel.coverImageData,
              let image = UIImage(data: data) else { return }
        screen?.updateCoverImage(image)
    }
}
