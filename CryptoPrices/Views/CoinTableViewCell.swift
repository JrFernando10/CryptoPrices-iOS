//
//  CoinTableViewCell.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import UIKit

final class CoinTableViewCell: UITableViewCell {
    static let reuseId = "CoinTableViewCell"

    private(set) var iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 22
        image.clipsToBounds = true
        return image
    }()

    private(set) var titleLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) var subtitleLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 12);
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private(set) var priceLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 14, weight: .medium);
        label.textAlignment = .right
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) var changeLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 12);
        label.textAlignment = .right
        
        return label
    }()

    private(set) var imageTaskUrl: URL?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not supported") }

    private func setupViews() {
        contentView.addSubview(iconImageView)
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 2
        labelsStack.translatesAutoresizingMaskIntoConstraints = false

        let rightStack = UIStackView(arrangedSubviews: [priceLabel, changeLabel])
        rightStack.axis = .vertical
        rightStack.spacing = 2
        rightStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(labelsStack)
        contentView.addSubview(rightStack)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 44),
            iconImageView.heightAnchor.constraint(equalToConstant: 44),

            labelsStack.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            labelsStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            rightStack.leadingAnchor.constraint(greaterThanOrEqualTo: labelsStack.trailingAnchor, constant: 8),
            rightStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    func configure(with viewModel: CoinCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        priceLabel.text = viewModel.priceText
        changeLabel.text = viewModel.changePercentageText
        changeLabel.textColor = viewModel.changeIsPositive ? .systemGreen : .systemRed
        imageTaskUrl = viewModel.imageURL
        iconImageView.image = nil
        ImageLoader.shared.load(from: viewModel.imageURL) { [weak self] image in
            guard let self = self else { return }
            if self.imageTaskUrl == viewModel.imageURL { self.iconImageView.image = image }
        }
    }
}
