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
        tableView.dataSource = self
        tableView.delegate = self
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

        viewModel.fetchFeed { [weak self] errorMsg in
            self?.presentAlert(withTitle: "Error", message: errorMsg)
        }

        viewModel.reloadSignal
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}

//MARK: - TableView DataSource methods

extension FeedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellIdentifier, for: indexPath) as! FeedTableViewCell

        let feed = viewModel.item(for: indexPath)
        cell.feed = feed
        
        return cell
    }
}

//MARK: - TableView Delegate methods

extension FeedsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didTapFeed(at: indexPath)
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
