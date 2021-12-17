//
//  FeedsItemsViewController.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 16.12.2021..
//

import UIKit
import RxCocoa
import RxSwift

class FeedsItemsViewController: UIViewController {

    //MARK: - Public properties

    var viewModel: FeedsItemsVMProtocol!

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.cellIdentifier)
        tableView.rowHeight = 100
        return tableView
    }()

    //MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNav()
    }

    deinit {
        print("\(#function) from \(#file) called")
    }
}

//MARK: - TableView DataSource methods

extension FeedsItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellIdentifier, for: indexPath) as! FeedTableViewCell

        let feedItem = viewModel.item(for: indexPath)
        cell.feedItem = feedItem

        return cell
    }
}

//MARK: - TableView Delegate methods

extension FeedsItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didTapFeedItem(at: indexPath)
    }
}

//MARK: - UI Setup

extension FeedsItemsViewController {
    func setupUI() {
        view.backgroundColor = .white

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupNav() {
        navigationItem.title = viewModel.title
    }
}
