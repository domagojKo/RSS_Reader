//
//  UIImageView + Extension.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 17.12.2021..
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(key: String) {
        if let savedImage = PhotoModelCacheManager.instance.get(key: key) {
            self.image = savedImage
        } else {
            FeedImageService.instance.fetchImage(url: key) { [weak self] imageData in
                guard let strongSelf = self else { return }
                if let data = imageData {
                    guard let image = UIImage(data: data) else {
                        strongSelf.backgroundColor = .lightGray
                        return
                    }

                    strongSelf.image = image
                    PhotoModelCacheManager.instance.add(key: key, value: image)
                } else {
                    DispatchQueue.main.async {
                        strongSelf.backgroundColor = .lightGray
                    }
                }
            }
        }
    }
}
