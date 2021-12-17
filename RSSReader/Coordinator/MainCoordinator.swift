//
//  MainCoordinator.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 13.12.2021..
//

import Foundation
import UIKit
import RxSwift

final class MainCoordinator: Coordinator {

    private let disposeBag = DisposeBag()

    override func start() {
        startFlow(in: rootNavigationController)
    }

    private func startFlow(in navigationController: UINavigationController) {
        let feedDatabase = FeedDatabase()
        let feedService = FeedService()
        let feedManager = FeedManager(feedService: feedService, feedDatabase: feedDatabase)
        let feedsVM = FeedsViewModel(feedManager: feedManager)
        let feedsVC = FeedsViewController()
        feedsVC.viewModel = feedsVM

        feedsVM.didSelectFeed = { [weak self, unowned navigationController] feed in
            guard let strongSelf = self else { return }
            strongSelf.showFeedItemList(in: navigationController, feed: feed)
        }
        
        navigationController.setViewControllers([feedsVC], animated: true)
    }

    private func showFeedItemList(in navigationController: UINavigationController, feed: FeedRealmModel) {
        let feedItemsVM = FeedsItemsViewModel(feedModel: feed)
        let feedItemsVC = FeedsItemsViewController()
        feedItemsVC.viewModel = feedItemsVM

        feedItemsVM.didSelectFeedItem = { [weak self] itemUrl in
            guard let strongSelf = self else { return }
            strongSelf.openUrl(path: itemUrl ?? "", vc: feedItemsVC)
        }

        navigationController.pushViewController(feedItemsVC, animated: true)
    }

    private func openUrl(path: String, vc: UIViewController) {
        if !path.isEmpty {
            if let url = URL(string: path) {
                UIApplication.shared.open(url)
            }
        } else {
            vc.presentAlert(withTitle: "Error", message: "Check internet connection.")
        }
    }
}
