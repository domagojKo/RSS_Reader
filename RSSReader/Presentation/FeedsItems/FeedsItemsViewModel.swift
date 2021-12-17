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
    var feed: BehaviorSubject<[FeedItem]> = BehaviorSubject(value: [])
    var title: BehaviorRelay<String?> = BehaviorRelay(value: "")
    var selectedFeedItem = PublishSubject<FeedItem>()

    //MARK: - Private properties
    private let imageService: FeedImageService

    init(feedModel: FeedModel) {
        imageService = FeedImageService.instance
        feed.onNext(feedModel.feedItems)
        title = BehaviorRelay<String?>(value: feedModel.feedTitle ?? "")
    }

    deinit {
        print("\(#function) from \(#file) called")
    }
}
