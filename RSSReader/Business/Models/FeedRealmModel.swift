//
//  FeedRealmModel.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 17.12.2021..
//

import Foundation
import RealmSwift

class FeedRealmModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String?
    @objc dynamic var imageUrl: String?

    let feedItems = LinkingObjects(fromType: FeedItemRealmModel.self, property: "feed")

    override class func primaryKey() -> String {
        return "id"
    }

    func updateModel(with feed: FeedModel, realm: Realm) {
        self.id = feed.feedLink ?? ""
        self.title = feed.feedTitle
        self.imageUrl = feed.feedImage

        _ = feed.feedItems.map { item in
            FeedItemRealmModel.updateOrCreateFeedItem(realm: realm, feedItem: item, feed: self)
        }
    }
}

extension FeedRealmModel {
    static func updateOrCreateFeedModel(realm: Realm, feedModel: FeedModel) -> FeedRealmModel {
        if let feedRealmModel = realm.object(ofType: FeedRealmModel.self, forPrimaryKey: feedModel.feedTitle) {
            let writeBlock = {
                feedRealmModel.updateModel(with: feedModel, realm: realm)
            }

            realm.isInWriteTransaction ? writeBlock() : try? realm.write(writeBlock)

            return feedRealmModel
        } else {
            let feedRealm = FeedRealmModel()
            let writeBlock = {
                feedRealm.id = feedModel.feedLink ?? ""
                feedRealm.updateModel(with: feedModel, realm: realm)
                realm.add(feedRealm, update: .modified)
            }

            realm.isInWriteTransaction ? writeBlock() : try? realm.write(writeBlock)

            return feedRealm
        }
    }
}
