# CryptoPrices

CryptoPrices is an iOS application built with Swift 5.7 (Xcode 13.2.1) to monitor cryptocurrency prices in real time. The app fetches data from the CoinGecko API and displays a list of cryptocurrencies with relevant details.

## Features

- List of cryptocurrencies with:
  - Name
  - Coin image
  - Current price
  - Price change percentage
- Detail view for each cryptocurrency
- Pull-to-refresh on the main list
- Light and dark theme support

## API

Data is fetched from the CoinGecko API:

```
https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false
```

## Testing & Coverage

- Unit test coverage: **86.6%**
- Minimum coverage to pass the future CI pipeline: **85%**

## Requirements

- Swift 5.7 / Xcode 13.2.1
- iOS 14+
- UIKit
- MVVM Architecture

## Installation

1. Clone the repository:

```bash
git clone https://github.com/JrFernando10/CryptoPrices.git
```

2. Open `CryptoPrices.xcodeproj` in Xcode.
3. Build and run the project on a simulator or device.

## License

This project was developed as a technical test and is for demonstration purposes only.
