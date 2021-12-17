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
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.cellIdentifier)
        tableView.rowHeight = 100
        return tableView
    }()

    //MARK: - Private properties

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNav()
        bindTableView()
    }

    deinit {
        print("\(#function) from \(#file) called")
    }
}

//MARK: - Binding

extension FeedsItemsViewController {
    func bindTableView() {
        viewModel.feed
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: FeedTableViewCell.cellIdentifier, cellType: FeedTableViewCell.self)) { index, item, cell in
                cell.feedItem = item
            }.disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { (indexPath) in
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(FeedItem.self)
            .bind(to: viewModel.selectedFeedItem)
            .disposed(by: disposeBag)
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
        navigationItem.title = viewModel.title.value
    }
}
