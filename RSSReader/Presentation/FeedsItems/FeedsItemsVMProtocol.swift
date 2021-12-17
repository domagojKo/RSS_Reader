//
//  FeedsItemsVMProtocol.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 16.12.2021..
//

import Foundation
import RxSwift
import RxRelay

protocol FeedsItemsVMProtocol {
    var selectedFeedItem: PublishSubject<FeedItem> { get }
    var feed: BehaviorSubject<[FeedItem]> { get }
    var title: BehaviorRelay<String?> { get }
}
