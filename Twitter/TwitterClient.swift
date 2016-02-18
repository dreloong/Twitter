//
//  TwitterClient.swift
//  Twitter
//
//  Created by Xiaofei Long on 2/14/16.
//  Copyright © 2016 Xiaofei Long. All rights reserved.
//

import BDBOAuth1Manager

let twitterBaseUrl = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "7E9yNJYQPtDwICUEXDW9fcV0a"
let twitterConsumerSecret = "3IuSMo7n4ntXzDRFFqiIlkTzpNB5hGpU8jTfVqP7SDM4FcBi2b"

class TwitterClient: BDBOAuth1SessionManager {

    var loginCompletion: ((user: User?, error: NSError?) -> ())?

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseUrl,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret
            )
        }
        return Static.instance
    }

    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath(
            "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "twitterdemo://oauth"),
            scope: nil,
            success: { (requestToken: BDBOAuth1Credential!) -> Void in
                let authUrlString =
                    "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)"
                UIApplication.sharedApplication().openURL(NSURL(string: authUrlString)!)
            },
            failure: { (error: NSError!) -> Void in
                self.loginCompletion?(user: nil, error: error)
            }
        )
    }

    func openURL(url: NSURL) {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath(
            "oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query)!,
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                TwitterClient.sharedInstance.GET(
                    "1.1/account/verify_credentials.json",
                    parameters: nil,
                    progress: nil,
                    success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                        let user = User(dictionary: response as! NSDictionary)
                        User.currentUser = user
                        self.loginCompletion?(user: user, error: nil)
                    },
                    failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                        self.loginCompletion?(user: nil, error: error)
                    }
                )
            },
            failure: { (error: NSError!) -> Void in
                self.loginCompletion?(user: nil, error: error)
            }
        )
    }

}
