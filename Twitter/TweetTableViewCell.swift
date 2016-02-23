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
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!

    var tweet: Tweet! {
        didSet {
            let user = tweet.user
            profileImageView.setImageWithURL((user?.profileImageUrl)!)
            nameLabel.text = user?.name
            screenNameLabel.text = "@" + (user?.screenName)!
            tweetTextLabel.text = tweet.text
            tweetTextLabel.sizeToFit()
            timeLabel.text = tweet.createdAt?.timeAgo()

            favoriteCountLabel.text = tweet.favoriteCount != 0 ? String(tweet.favoriteCount) : ""
            retweetCountLabel.text = tweet.retweetCount != 0 ? String(tweet.retweetCount) : ""

            if tweet.favorited {
                favoriteButton.setImage(UIImage(named: "Like-Active"), forState: .Normal)
                favoriteCountLabel.textColor = UIColor(red:0.91, green:0.11, blue:0.31, alpha:1.0)
            } else {
                favoriteButton.setImage(UIImage(named: "Like-Default"), forState: .Normal)
                favoriteCountLabel.textColor = UIColor(red:0.67, green:0.72, blue:0.76, alpha:1.0)
            }

            if tweet.retweeted {
                retweetButton.setImage(UIImage(named: "Retweet-Active"), forState: .Normal)
                retweetCountLabel.textColor = UIColor(red:0.1, green:0.81, blue:0.53, alpha:1.0)
            } else {
                retweetButton.setImage(UIImage(named: "Retweet-Default"), forState: .Normal)
                retweetCountLabel.textColor = UIColor(red:0.67, green:0.72, blue:0.76, alpha:1.0)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        profileImageView.layer.cornerRadius = 6
        profileImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onFavoriteButtonTouchUp(sender: AnyObject) {
        tweet.favorite({ (tweet: Tweet?, error: NSError?) in
            if let tweet = tweet {
                self.tweet = tweet
            }
        })
    }

    @IBAction func onRetweetButtonTouchUp(sender: AnyObject) {
        tweet.retweet({ (tweet: Tweet?, error: NSError?) in
            if let tweet = tweet {
                self.tweet = tweet
            }
        })
    }

}
