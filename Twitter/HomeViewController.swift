//
//  HomeViewController.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/17/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func onLogoutButtonTouchUp(sender: AnyObject) {
        User.currentUser?.logout()
    }

}
