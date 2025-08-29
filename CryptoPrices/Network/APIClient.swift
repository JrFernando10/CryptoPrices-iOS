//
//  APIClient.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation

protocol APIClientType {
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

final class APIClient: APIClientType {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(
                        domain: "APIClient",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "No data"]
                    )))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                decoder.dateDecodingStrategy = .custom { decoder -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateStr = try container.decode(String.self)
                    guard let date = formatter.date(from: dateStr) else {
                        throw DecodingError.dataCorruptedError(
                            in: container,
                            debugDescription: "Cannot decode date string \(dateStr)"
                        )
                    }
                    return date
                }
                
                let decoded = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print("API error:", error)
            }
        }
        task.resume()
    }
}
