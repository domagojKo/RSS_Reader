//
//  FeedsVMProtocol.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 13.12.2021..
//

import Foundation
import RxSwift

protocol FeedsVMProtocol {
    var selectedFeed: PublishSubject<FeedModel> { get }
    var feeds: BehaviorSubject<[FeedModel]> { get }
}
