//
//  FeedsViewModel.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 13.12.2021..
//

import Foundation
import RxSwift
import RxCocoa
import FeedKit

final class FeedsViewModel: FeedsVMProtocol {

    //MARK: - Public properties

    lazy var reloadSignal: Observable<Void> = self.reloadMutable
                                                    .asObservable()
                                                    .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
    var didSelectFeed: ((FeedRealmModel) -> ())?

    //MARK: - Private properties

    private var feedManager: FeedManager
    private var realmFeeds = [FeedRealmModel]()
    private let reloadMutable = BehaviorRelay(value: ())
    private let disposeBag = DisposeBag()

    init(feedManager: FeedManager) {
        self.feedManager = feedManager
        realmFeeds = feedManager.getFeeds()
    }

    func fetchFeed(completion: @escaping (String) ->()) {
        feedManager.fetchAndSaveFeed()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.realmFeeds = self.feedManager.getFeeds()
                    self.reloadMutable.accept(())

                    if self.realmFeeds.count == 0 {
                        let msg = "Please check your internet connection."
                        completion(msg)
                    }
                }, onError: { errorMsg in
                    completion(errorMsg.localizedDescription)
                })
            .disposed(by: disposeBag)
    }

    func numberOfItems() -> Int {
        return realmFeeds.count
    }

    func item(for index: IndexPath) -> FeedRealmModel {
        return realmFeeds[index.row]
    }

    func didTapFeed(at index: IndexPath) {
        didSelectFeed?(realmFeeds[index.row])
    }

    deinit {
        print("\(#function) from \(#file) called")
    }
}
