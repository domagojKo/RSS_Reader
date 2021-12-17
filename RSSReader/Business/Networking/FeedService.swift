//
//  FeedsService.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 14.12.2021..
//

import Foundation
import FeedKit

enum FeedsServiceResponse: Error {
    case success(RSSFeed?)
    case failure(Error)
}

protocol FeedsServiceProtocol {
    func getFeeds(path: URL, completion: @escaping (FeedsServiceResponse) -> ())
}

class FeedsService: FeedsServiceProtocol {

    func getFeeds(path: URL, completion: @escaping (FeedsServiceResponse) -> ()) {
        let parser = FeedParser(URL: path)

        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { result in
            switch result {
            case .success(let feed):
                completion(FeedsServiceResponse.success(feed.rssFeed))
            case .failure(let error):
                completion(FeedsServiceResponse.failure(error))
            }
        }
    }
}
