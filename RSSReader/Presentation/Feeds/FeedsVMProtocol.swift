//
//  FeedsVMProtocol.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 13.12.2021..
//

import Foundation
import RxSwift
import RxRelay

protocol FeedsVMProtocol {
    var reloadSignal: Observable<Void> { get }
   
    func numberOfItems() -> Int
    func item(for index: IndexPath) -> FeedRealmModel
    func didTapFeed(at index: IndexPath)
    func fetchFeed(completion: @escaping (String) ->())
}
