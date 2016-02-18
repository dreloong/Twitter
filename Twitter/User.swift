//
//  User.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/15/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import Foundation

var _currentUser: User?

let currentUserKey = "currentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User {

    var dictionary: NSDictionary?
    var name: String?
    var screenName: String?
    var profileImageUrl: NSURL?

    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = NSURL(string: (dictionary["profile_image_url"] as! String))
    }

    class var currentUser: User? {
        get {
            if _currentUser == nil {
                if let data = NSUserDefaults.standardUserDefaults().dataForKey(currentUserKey) {
                    let dictionary = try? NSJSONSerialization.JSONObjectWithData(
                        data,
                        options: []
                    ) as! NSDictionary
                    _currentUser = User(dictionary: dictionary!)
                }
            }
            return _currentUser
        }

        set(user) {
            _currentUser = user
            var data: NSData? = nil
            if let currentUser = _currentUser {
                data = try? NSJSONSerialization.dataWithJSONObject(
                    currentUser.dictionary!,
                    options: []
                ) as NSData
            }
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(
            userDidLogoutNotification,
            object: nil
        )
    }

}
