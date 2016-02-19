//
//  HomeViewController.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/17/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var refreshControl: UIRefreshControl!

    var tweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = UIImageView(image: UIImage(named: "Twitter-Blue"))

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        TwitterClient.sharedInstance.homeTimelineWithParams(
            nil,
            completion: { (tweets: [Tweet]?, error: NSError?) in
                if let tweets = tweets {
                    self.tweets = tweets
                    self.tableView.reloadData()
                }
            }
        )

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: .ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onLogoutButtonTouchUp(sender: AnyObject) {
        User.currentUser?.logout()
    }

    func onRefresh() {
        TwitterClient.sharedInstance.homeTimelineWithParams(
            nil,
            completion: { (tweets: [Tweet]?, error: NSError?) in
                if let tweets = tweets {
                    self.tweets = tweets
                    self.tableView.reloadData()
                }
            }
        )

        refreshControl.endRefreshing()
    }

}

extension HomeViewController: UITableViewDataSource {

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

extension HomeViewController: UITableViewDelegate {

}
