//
//  Feed.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 14.12.2021..
//

import Foundation

struct FeedModel {
    let feedTitle: String?
    let feedImage: String?
    let feedLink: String?
    let feedItems: [FeedItem]

    init(title: String?, image: String?, link: String?, items: [FeedItem]) {
        self.feedTitle = title
        self.feedImage = image
        self.feedLink = link
        self.feedItems = items
    }
}
