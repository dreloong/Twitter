//
//  TweetCompositionViewController.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/22/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import UIKit

class TweetCompositionViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!

    var toolbar: UIToolbar!
    var tweetBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.setImageWithURL(User.currentUser!.profileImageUrl!)
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true

        let spaceBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .FlexibleSpace,
            target: nil,
            action: nil
        )
        tweetBarButtonItem = UIBarButtonItem(
            title: "Tweet",
            style:  .Plain,
            target: self,
            action: "onTweet:"
        )
        toolbar = UIToolbar()
        toolbar.items = [spaceBarButtonItem, tweetBarButtonItem, spaceBarButtonItem]
        toolbar.sizeToFit()

        tweetTextView.inputAccessoryView = toolbar
        tweetTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onCancelButtonTouchUp(sender: AnyObject) {
        tweetTextView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }

    func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.createTweetWithParams(
            ["status": tweetTextView.text],
            completion: { (tweet: Tweet?, error: NSError?) in
                if tweet != nil {
                    self.tweetTextView.resignFirstResponder()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        )
    }

}
