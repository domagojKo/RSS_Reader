//
//  FeedsService.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 14.12.2021..
//

import Foundation
import FeedKit
import RxSwift

enum FeedServiceResponse: Error {
    case success(FeedModel)
    case failure(Error)
}

protocol FeedServiceProtocol {
    func getFeeds(path: String) -> Observable<FeedServiceResponse>
}

class FeedService: FeedServiceProtocol {

    func getFeeds(path: String) -> Observable<FeedServiceResponse> {
        return Observable<FeedServiceResponse>.create({ observable -> Disposable in
            guard let url = URL(string: path) else {
                observable.onError(NSError(domain: "", code: 0, userInfo: [:]))
                observable.onCompleted()
                return Disposables.create()
            }
            let parser = FeedParser(URL: url)

            parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { result in
                switch result {
                case .success(let feed):
                    guard let fd = feed.rssFeed, let items = fd.items else {
                        return
                    }

                    let feedItems = items.compactMap { FeedItem.init(itemTitle:$0.title, itemImage:$0.enclosure?.attributes?.url, url: $0.link, description: $0.description)}
                    let feed = FeedModel(title: fd.title, image: fd.image?.url, link: fd.link, items: feedItems)

                    observable.onNext(FeedServiceResponse.success(feed))
                    observable.onCompleted()
                case .failure(let error):
                    observable.onNext(FeedServiceResponse.failure(error))
                    observable.onCompleted()
                }
            }

            return Disposables.create()
        })
    }
}
