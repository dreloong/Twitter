//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/22/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        let user = tweet.user
        nameLabel.text = user?.name
        screenNameLabel.text = "@" + (user?.screenName)!
        tweetTextLabel.text = tweet.text
        tweetTextLabel.sizeToFit()

        let formatter = NSDateFormatter()
        formatter.dateFormat = "M/d/yy HH:mm"
        timeLabel.text = formatter.stringFromDate(tweet.createdAt!)

        profileImageView.setImageWithURL((user?.profileImageUrl)!)
        profileImageView.layer.cornerRadius = 6
        profileImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
