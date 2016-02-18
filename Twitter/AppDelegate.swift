//
//  AppDelegate.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/14/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)

    func application(
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?
    ) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "userDidLogout",
            name: userDidLogoutNotification,
            object: nil
        )

        if User.currentUser != nil {
            window?.rootViewController =
                storyboard.instantiateViewControllerWithIdentifier("HomeNavigationViewController")
                as UIViewController
        }

        return true
    }

    func application(
        application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject
    ) -> Bool {
        TwitterClient.sharedInstance.openURL(url)
        return true
    }

    func userDidLogout() {
        window?.rootViewController =
            storyboard.instantiateInitialViewController()! as UIViewController
    }

}
