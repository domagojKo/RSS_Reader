//
//  FeedDatabase.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 17.12.2021..
//

import Foundation
import Realm
import RealmSwift

protocol FeedDatabaseProtocol {
    func updateOrCreate(feedModel: FeedModel) -> FeedRealmModel
    func getFeeds() -> [FeedRealmModel]
}

class FeedDatabase: FeedDatabaseProtocol {
    
    func getFeeds() -> [FeedRealmModel] {
        let realm = try! Realm()
        return realm.objects(FeedRealmModel.self).map { $0 }
    }

    func updateOrCreate(feedModel: FeedModel) -> FeedRealmModel {
        let realm = try! Realm()
        let feed = FeedRealmModel.updateOrCreateFeedModel(realm: realm, feedModel: feedModel)
        return feed
    }
}
