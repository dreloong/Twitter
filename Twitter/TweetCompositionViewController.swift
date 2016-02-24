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
    var countLabel: UILabel!
    var tweetButton: UIButton!

    let twitterBlueColor = UIColor(red:0.33, green:0.67, blue:0.93, alpha:1.0)
    let twitterRedColor = UIColor(red:0.91, green:0.11, blue:0.31, alpha:1.0)
    let twitterGrayColor = UIColor(red:0.67, green:0.72, blue:0.76, alpha:1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.setImageWithURL(User.currentUser!.profileImageUrl!)
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true

        initToolbar()

        tweetTextView.delegate = self
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

    func onTweetButtonTouchUp(sender: AnyObject) {
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

    // MARK: - Helpers

    func initToolbar() {
        let spaceBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .FlexibleSpace,
            target: nil,
            action: nil
        )

        countLabel = UILabel()
        countLabel.frame = CGRectMake(0, 0, 40, 30)
        countLabel.text = "140"
        countLabel.textColor = twitterGrayColor
        countLabel.textAlignment = .Right
        countLabel.font = UIFont.systemFontOfSize(13)

        tweetButton = UIButton(type: .Custom)
        tweetButton.frame = CGRectMake(0, 0, 70, 30)
        tweetButton.layer.cornerRadius = 6
        tweetButton.layer.borderColor = twitterGrayColor.CGColor
        tweetButton.setTitle("Tweet", forState: .Normal)
        tweetButton.titleLabel?.font = UIFont.boldSystemFontOfSize(13)
        tweetButton.titleLabel?.textAlignment = .Center
        tweetButton.addTarget(
            self,
            action: "onTweetButtonTouchUp:",
            forControlEvents: .TouchUpInside
        )

        tweetButton.layer.borderWidth = 0.5
        tweetButton.backgroundColor = UIColor.whiteColor()
        tweetButton.setTitleColor(twitterGrayColor, forState: .Normal)
        tweetButton.enabled = false

        toolbar = UIToolbar()
        toolbar.barTintColor = UIColor.whiteColor()
        toolbar.layer.borderColor = twitterGrayColor.CGColor
        toolbar.layer.borderWidth = 1
        toolbar.items = [
            spaceBarButtonItem,
            UIBarButtonItem(customView: countLabel),
            UIBarButtonItem(customView: tweetButton),
        ]
        toolbar.sizeToFit()
    }

}

extension TweetCompositionViewController: UITextViewDelegate {

    func textViewDidChange(textView: UITextView) {
        let count = 140 - textView.text.characters.count
        countLabel.text = "\(count)"

        if count < 0 || count == 140 {
            tweetButton.layer.borderWidth = 0.5
            tweetButton.backgroundColor = UIColor.whiteColor()
            tweetButton.setTitleColor(twitterGrayColor, forState: .Normal)
            tweetButton.enabled = false
        } else {
            tweetButton.layer.borderWidth = 0
            tweetButton.backgroundColor = twitterBlueColor
            tweetButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            tweetButton.enabled = true
        }

        countLabel.textColor = count < 20 ? twitterRedColor : twitterGrayColor
    }

}
