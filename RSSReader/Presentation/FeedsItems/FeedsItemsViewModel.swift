//
//  FeedsItemsViewModel.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 16.12.2021..
//

import Foundation
import RxSwift
import RxCocoa

final class FeedsItemsViewModel: FeedsItemsVMProtocol {

    //MARK: - Public properties

    var title: String?
    var didSelectFeedItem: ((String?) -> ())?

    //MARK: - Private properties

    private var feedItems = [FeedItemRealmModel]()

    init(feedModel: FeedRealmModel) {
        feedItems = feedModel.feedItems.map { $0 }
        title = feedModel.title
    }

    func numberOfItems() -> Int {
        return feedItems.count
    }

    func item(for index: IndexPath) -> FeedItemRealmModel {
        return feedItems[index.row]
    }

    func didTapFeedItem(at index: IndexPath) {
        didSelectFeedItem?(feedItems[index.row].url)
    }

    deinit {
        print("\(#function) from \(#file) called")
    }
}
