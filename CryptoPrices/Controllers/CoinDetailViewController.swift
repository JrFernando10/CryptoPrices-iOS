//
//  CoinDetailViewController.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import UIKit

final class CoinDetailViewController: UIViewController {
    
    private let detailView = CoinDetailView()
    private let viewModel: CoinDetailViewModel

    init(viewModel: CoinDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }

    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        setup()
    }

    private func setup() {
        detailView.nameLabel.text = viewModel.title
        detailView.priceLabel.text = viewModel.priceText
        detailView.changeLabel.text = viewModel.changeText
        detailView.lastUpdatedLabel.text = "Updated: " + viewModel.lastUpdatedText
        ImageLoader.shared.load(from: viewModel.imageURL) { [weak self] img in
            self?.detailView.imageView.image = img
        }
    }
}
