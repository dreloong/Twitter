//
//  Tweet.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/15/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import Foundation

class Tweet {

    var createdAt: NSDate?
    var text: String?
    var user: User?

    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)

        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(dictionary["created_at"] as! String)
    }

}
