//
//  ImageLoader.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    func load(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cached = cache.object(forKey: url as NSURL) {
            completion(cached)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            var image: UIImage? = nil
            if let data = data {
                image = UIImage(data: data)
                if let img = image {
                    self.cache.setObject(img, forKey: url as NSURL)
                }
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
            
        }.resume()
    }
}
