//
//  Tweet.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/15/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import Foundation

class Tweet {

    var id: String
    var createdAt: NSDate?
    var text: String?
    var user: User?
    var favorited: Bool
    var favoriteCount: Int
    var retweeted: Bool
    var retweetCount: Int

    init(dictionary: NSDictionary) {
        id = dictionary["id_str"] as! String

        text = dictionary["text"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)

        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(dictionary["created_at"] as! String)

        favorited = dictionary["favorited"] as! Int != 0
        retweeted = dictionary["retweeted"] as! Int != 0

        favoriteCount = dictionary["favorite_count"] as! Int
        retweetCount = dictionary["retweet_count"] as! Int
    }

    class func tweets(dictionaries: [NSDictionary]) -> [Tweet] {
        return dictionaries.map({ dictionary in Tweet(dictionary: dictionary) })
    }

    func favorite(completion: (tweet: Tweet?, error: NSError?) -> ()) {
        TwitterClient.sharedInstance.POST(
            "1.1/favorites/create.json?id=\(id)",
            parameters: nil,
            progress: nil,
            success: { (_: NSURLSessionDataTask, _: AnyObject?) -> Void in
                self.favorited = true
                self.favoriteCount++
                completion(tweet: self, error: nil)
            },
            failure: { (_: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
            }
        )
    }

    func retweet(completion: (tweet: Tweet?, error: NSError?) -> ()) {
        TwitterClient.sharedInstance.POST(
            "1.1/statuses/retweet/\(id).json",
            parameters: nil,
            progress: nil,
            success: { (_: NSURLSessionDataTask, _: AnyObject?) -> Void in
                self.retweeted = true
                self.retweetCount++
                completion(tweet: self, error: nil)
            },
            failure: { (_: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
            }
        )
    }

}
