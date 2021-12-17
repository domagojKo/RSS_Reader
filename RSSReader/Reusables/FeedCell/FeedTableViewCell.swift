//
//  FeedTableViewCell.swift
//  RSSReader
//
//  Created by Domagoj Kolaric on 14.12.2021..
//

import UIKit
import SnapKit

enum FeedType {
    case feed, feedItem
}

class FeedTableViewCell: UITableViewCell {

    static let cellIdentifier = "FeedTableViewCell"

    //MARK: - Properties

    lazy var feedTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var feedImage: UIImageView = {
        let image = UIImageView()
        return image
    }()

    var feed: FeedRealmModel! {
        didSet {
            configure(type: .feed)
        }
    }

    var feedItem: FeedItemRealmModel! {
        didSet {
            configure(type: .feedItem)
        }
    }

    var image: UIImage?

    //MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupUI() {
        backgroundColor = .clear

        contentView.addSubview(feedImage)
        feedImage.clipsToBounds = true
        feedImage.layer.cornerRadius = 3
        feedImage.contentMode = .scaleAspectFill

        feedImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(70)
            $0.height.equalTo(70)
        }

        contentView.addSubview(feedTitleLabel)
        feedTitleLabel.textColor = .black
        feedTitleLabel.numberOfLines = 2
        feedTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        feedTitleLabel.textAlignment = .left

        feedTitleLabel.snp.makeConstraints {
            $0.top.equalTo(feedImage.snp.topMargin).offset(-10)
            $0.leading.equalTo(feedImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }

    private func configure(type: FeedType) {
        feedTitleLabel.text = type == .feed ? feed.title : feedItem.title

        switch type {
        case .feed:
            if let imageUrl = feed.imageUrl {
                feedImage.loadImage(key: imageUrl)
            } else {
                feedImage.backgroundColor = .lightGray
            }
        case .feedItem:
            if let imageUrl = feedItem.imageUrl {
                feedImage.loadImage(key: imageUrl)
            } else {
                feedImage.backgroundColor = .lightGray
            }
        }
    }
}
