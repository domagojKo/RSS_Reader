//
//  FeedItemRealmModel.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 17.12.2021..
//

import Foundation
import RealmSwift

class FeedItemRealmModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String?
    @objc dynamic var imageUrl: String?
    @objc dynamic var url: String?
    @objc dynamic var feed: FeedRealmModel? = nil

    override class func primaryKey() -> String {
        return "id"
    }

    func updateModel(feedItem: FeedItem, feed: FeedRealmModel) {
        self.title = feedItem.title
        self.imageUrl = feedItem.image
        self.url = feedItem.url
        self.feed = feed
    }
}

extension FeedItemRealmModel {
    static func updateOrCreateFeedItem(realm: Realm, feedItem: FeedItem, feed: FeedRealmModel) -> FeedItemRealmModel {
        let foundItem = realm.objects(FeedItemRealmModel.self).filter("id = %@ AND feed = %@", feedItem.description ?? "", feed).first

        if let feedItemExists = foundItem {
            if realm.isInWriteTransaction {
                feedItemExists.updateModel(feedItem: feedItem, feed: feed)
            } else {
                try? realm.write {
                    feedItemExists.updateModel(feedItem: feedItem, feed: feed)
                }
            }

            return feedItemExists
        } else {
            let newFeedItem = FeedItemRealmModel()
            if realm.isInWriteTransaction {
                newFeedItem.id = feedItem.description ?? ""
                newFeedItem.updateModel(feedItem: feedItem, feed: feed)
                realm.add(newFeedItem, update: .modified)
            } else {
                try? realm.write{
                    newFeedItem.id = feedItem.description ?? ""
                    newFeedItem.updateModel(feedItem: feedItem, feed: feed)
                    realm.add(newFeedItem, update: .modified)
                }
            }

            return newFeedItem
        }
    }
}
