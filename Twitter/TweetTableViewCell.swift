//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/18/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import UIKit
import NSDateMinimalTimeAgo

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    var tweet: Tweet! {
        didSet {
            let user = tweet.user
            profileImageView.setImageWithURL((user?.profileImageUrl)!)
            nameLabel.text = user?.name
            screenNameLabel.text = "@" + (user?.screenName)!
            tweetTextLabel.text = tweet.text
            tweetTextLabel.sizeToFit()
            timeLabel.text = tweet.createdAt?.timeAgo()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
