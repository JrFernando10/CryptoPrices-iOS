//
//  CoinDetailView.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import UIKit

final class CoinDetailView: UIView {
    
    let imageView: UIImageView = {
        let image = UIImageView();
        image.translatesAutoresizingMaskIntoConstraints = false;
        image.contentMode = .scaleAspectFit;
        image.layer.cornerRadius = 40;
        image.clipsToBounds = true
        
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 22, weight: .bold);
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 20, weight: .semibold);
        label.textAlignment = .center
        
        return label
    }()
    
    let changeLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 16);
        label.textAlignment = .center
        
        return label
    }()
    
    let lastUpdatedLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .systemFont(ofSize: 12);
        label.textAlignment = .center;
        label.textColor = .secondaryLabel
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not used") }

    private func setup() {
        backgroundColor = .systemBackground
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(changeLabel)
        addSubview(lastUpdatedLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            changeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            changeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            lastUpdatedLabel.topAnchor.constraint(equalTo: changeLabel.bottomAnchor, constant: 8),
            lastUpdatedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lastUpdatedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
