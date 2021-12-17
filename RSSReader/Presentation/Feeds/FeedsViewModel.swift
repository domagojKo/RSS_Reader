//
//  FeedsViewModel.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 13.12.2021..
//

import Foundation
import RxSwift
import RxCocoa
import FeedKit

final class FeedsViewModel: FeedsVMProtocol {

    //MARK: - Public properties

    var feeds = BehaviorSubject<[FeedModel]>(value: [])
    var selectedFeed = PublishSubject<FeedModel>()

    //MARK: - Private properties

    private var feedsService: FeedsServiceProtocol
    private var feedsPaths = ["https://www.24sata.hr/feeds/tech.xml", "https://www.24sata.hr/feeds/lifestyle.xml", "https://www.24sata.hr/feeds/sport.xml", "https://www.24sata.hr/feeds/show.xml", "https://www.24sata.hr/feeds/fun.xml"]
    private var feedsArr = [FeedModel]()
    private let disposeBag = DisposeBag()

    init(feedsService: FeedsServiceProtocol) {
        self.feedsService = feedsService
        fetchFeed()
    }

    func fetchFeed() {
        feedsPaths.forEach { path in
            guard let url = URL(string: path) else { return }

            feedsService.getFeeds(path: url) { [weak self] rssFeed in
                guard let strongSelf = self else { return }
                switch rssFeed {
                case .success(let feed):
                    if let fd = feed, let items = fd.items {
                        let feedItems = items.compactMap { FeedItem.init(itemTitle:$0.title, itemImage:$0.enclosure?.attributes?.url, url: $0.link)}
                        let feed = FeedModel(title: fd.title, image: fd.image?.url, items: feedItems)
                        strongSelf.feedsArr.append(feed)
                        strongSelf.feeds.onNext(strongSelf.feedsArr)
                    }
                case .failure(let error):
                    //add alert ?? 
                    print(error.localizedDescription)
                }
            }
        }
    }

    deinit {
        print("\(#function) from \(#file) called")
    }
}
