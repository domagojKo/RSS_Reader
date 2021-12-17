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
    var title: String? { get }

    func numberOfItems() -> Int
    func item(for index: IndexPath) -> FeedItemRealmModel
    func didTapFeedItem(at index: IndexPath)
}
