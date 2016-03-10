//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/22/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import UIKit
import ActiveLabel

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: ActiveLabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        let user = tweet.user
        nameLabel.text = user?.name
        screenNameLabel.text = "@" + (user?.screenName)!

        tweetTextLabel.text = tweet.text
        tweetTextLabel.hashtagColor = tweetTextLabel.textColor
        tweetTextLabel.mentionColor = tweetTextLabel.textColor
        tweetTextLabel.URLColor = twitterBlueColor
        tweetTextLabel.handleURLTap({ (url: NSURL) -> () in
            UIApplication.sharedApplication().openURL(url)
        })
        tweetTextLabel.sizeToFit()

        let formatter = NSDateFormatter()
        formatter.dateFormat = "M/d/yy HH:mm"
        timeLabel.text = formatter.stringFromDate(tweet.createdAt!)

        profileImageView.setImageWithURL((user?.profileImageUrl)!)
        profileImageView.layer.cornerRadius = 6
        profileImageView.clipsToBounds = true

        updateFavoriteLabelAndButton()
        updateRetweetLabelAndButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onFavoriteButtonTouchUp(sender: AnyObject) {
        tweet.favorite({ (tweet: Tweet?, error: NSError?) in
            if let tweet = tweet {
                self.tweet = tweet
                self.updateFavoriteLabelAndButton()
            }
        })
    }

    @IBAction func onRetweetButtonTouchUp(sender: AnyObject) {
        tweet.retweet({ (tweet: Tweet?, error: NSError?) in
            if let tweet = tweet {
                self.tweet = tweet
                self.updateRetweetLabelAndButton()
            }
        })
    }

    // MARK: - Helpers

    func updateFavoriteLabelAndButton() {
        favoriteCountLabel.text = tweet.favoriteCount != 0 ? String(tweet.favoriteCount) : ""

        if tweet.favorited {
            favoriteButton.setImage(UIImage(named: "Like-Active"), forState: .Normal)
            favoriteCountLabel.textColor = UIColor(red:0.91, green:0.11, blue:0.31, alpha:1.0)
        } else {
            favoriteButton.setImage(UIImage(named: "Like-Default"), forState: .Normal)
            favoriteCountLabel.textColor = UIColor(red:0.67, green:0.72, blue:0.76, alpha:1.0)
        }
    }

    func updateRetweetLabelAndButton() {
        retweetCountLabel.text = tweet.retweetCount != 0 ? String(tweet.retweetCount) : ""

        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "Retweet-Active"), forState: .Normal)
            retweetCountLabel.textColor = UIColor(red:0.1, green:0.81, blue:0.53, alpha:1.0)
        } else {
            retweetButton.setImage(UIImage(named: "Retweet-Default"), forState: .Normal)
            retweetCountLabel.textColor = UIColor(red:0.67, green:0.72, blue:0.76, alpha:1.0)
        }
    }
}
