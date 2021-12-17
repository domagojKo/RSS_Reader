//
//  FeedImageService.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 16.12.2021..
//

import Foundation

final class FeedImageService {

    static let instance = FeedImageService()

    private init() { }

    func fetchImage(url: String, completion: @escaping (Data?) -> ()) {
        guard let imageUrl = URL(string: url) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let imageData = data, error == nil else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }.resume()
    }
}

