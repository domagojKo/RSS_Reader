//
//  FeedManager.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 17.12.2021..
//

import Foundation
import RxSwift

protocol FeedManagerProtocol {
    func fetchAndSaveFeed() -> Observable<[FeedRealmModel]>
    func getFeeds() -> [FeedRealmModel]
}

final class FeedManager {

    //MARK: - Private properties

    private let feedService: FeedServiceProtocol
    private let feedDatabase: FeedDatabaseProtocol
    private let disposeBag: DisposeBag
    private let feedsPath = ["https://www.24sata.hr/feeds/tech.xml", "https://www.24sata.hr/feeds/lifestyle.xml", "https://www.24sata.hr/feeds/sport.xml", "https://www.24sata.hr/feeds/show.xml", "https://www.24sata.hr/feeds/fun.xml"]

    init(feedService: FeedServiceProtocol, feedDatabase: FeedDatabaseProtocol) {
        self.feedService = feedService
        self.feedDatabase = feedDatabase
        self.disposeBag = DisposeBag()
    }

    func getFeeds() -> [FeedRealmModel] {
        return feedDatabase.getFeeds()
    }

    func fetchAndSaveFeed() -> Observable<[FeedRealmModel]> {
        return Observable.zip(feedsPath.map {feedService.getFeeds(path: $0)}).map { feedsResult in
            var feedModels = [FeedRealmModel]()

            try? feedsResult.forEach { result in
                switch result {
                case .success(let feed):
                    let feedItem = self.feedDatabase.updateOrCreate(feedModel: feed)
                    feedModels.append(feedItem)
                case .failure(let error):
                    throw error
                }
            }

            return feedModels
        }
    }
}
