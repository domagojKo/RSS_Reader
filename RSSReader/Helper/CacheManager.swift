//
//  CacheManager.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 16.12.2021..
//

import Foundation
import UIKit

final class PhotoModelCacheManager {

    static let instance = PhotoModelCacheManager()

    private init() {}

    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 300
        cache.totalCostLimit = 1024 * 1024 * 300
        return cache
    }()

    func add(key: String, value: UIImage) {
        photoCache.setObject(value, forKey: key as NSString)
    }

    func get(key: String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
}
