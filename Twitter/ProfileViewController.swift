//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/28/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!

    var user: User!
    var tweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = user.name

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        backgroundImageView.setImageWithURL(user.backgroundImageUrl!)
        backgroundImageView.contentMode = .ScaleAspectFill
        backgroundImageView.clipsToBounds = true

        profileImageView.setImageWithURL(user.profileImageUrl!)
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.cornerRadius = 8
        profileImageView.clipsToBounds = true

        nameLabel.text = user.name
        screenNameLabel.text = "@" + user.screenName!

        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        tweetsCountLabel.text = formatter.stringFromNumber(user.tweetsCount!)
        followersCountLabel.text = formatter.stringFromNumber(user.followersCount!)
        followingCountLabel.text = formatter.stringFromNumber(user.followingCount!)

        TwitterClient.sharedInstance.userTimelineWith(
            user.screenName!,
            params: nil,
            completion: { (tweets: [Tweet]?, error: NSError?) in
                if let tweets = tweets {
                    self.tweets = tweets
                    self.tableView.reloadData()
                }
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = tableView.indexPathForCell(sender as! TweetTableViewCell)
        let tweetDetailViewController =
            segue.destinationViewController as! TweetDetailViewController
        tweetDetailViewController.tweet = tweets[indexPath!.row]
    }

}

extension ProfileViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Tweet Cell",
            forIndexPath: indexPath
        ) as! TweetTableViewCell

        cell.tweet = tweets[indexPath.row]
        return cell
    }

}

extension ProfileViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
