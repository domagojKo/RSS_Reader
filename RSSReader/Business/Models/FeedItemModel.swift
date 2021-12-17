//
//  FeedItemModel.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 16.12.2021..
//

import Foundation

struct FeedItem {
    let title: String?
    let image: String?
    let url: String?

    init(itemTitle: String?, itemImage: String?, url: String?) {
        self.title = itemTitle
        self.image = itemImage
        self.url = url
    }
}
