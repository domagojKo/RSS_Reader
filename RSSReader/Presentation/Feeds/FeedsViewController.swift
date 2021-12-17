//
//  FeedsViewControlerViewController.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 13.12.2021..
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class FeedsViewController: UIViewController {

    //MARK: - Public properties

    var viewModel: FeedsVMProtocol!

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.cellIdentifier)
        tableView.rowHeight = 100
        return tableView
    }()

    //MARK: - Private properties

    private let disposeBag = DisposeBag()

    //MARK: - ViewController Lifecycle

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

extension FeedsViewController {
    func bindTableView() {
        viewModel.feeds
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: FeedTableViewCell.cellIdentifier, cellType: FeedTableViewCell.self)) { index, feed, cell in
                cell.feed = feed
            }.disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { (indexPath) in
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(FeedModel.self)
            .bind(to: viewModel.selectedFeed)
            .disposed(by: disposeBag)
    }
}

//MARK: - UI Setup

extension FeedsViewController {
    func setupUI() {
        view.backgroundColor = .white

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupNav() {
        navigationItem.title = "Favourite Feeds"
    }
}
