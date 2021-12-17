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
    let description: String?

    init(itemTitle: String?, itemImage: String?, url: String?, description: String?) {
        self.title = itemTitle
        self.image = itemImage
        self.url = url
        self.description = description
    }
}
