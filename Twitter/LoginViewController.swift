//
//  LoginViewController.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/14/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onLoginButtonTouchUp(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() { (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // Handle error
            }
        }
    }

}
