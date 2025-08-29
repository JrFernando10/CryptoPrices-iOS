//
//  CoinListViewModel.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation

final class CoinListViewModel {
    
    private let service: CoinServiceType
    
    private(set) var coins: [Coin] = [] {
        didSet { self.onUpdate?() }
    }

    var onUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(service: CoinServiceType = CoinService()) {
        self.service = service
    }

    func fetch() {
        service.fetchMarkets { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }

    func viewModelForCell(at index: Int) -> CoinCellViewModel {
        CoinCellViewModel(coin: coins[index])
    }

    func numberOfItems() -> Int { coins.count }
}
