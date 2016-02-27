//
//  TwitterClient.swift
//  Tweety
//
//  Created by Maliha Fairooz on 2/26/16.
//  Copyright © 2016 Maliha Fairooz. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "sqgGkRzOM0843TQ4vahqfXEY8", consumerSecret: "bjNgiyaRrxXiyIqWZncuBoVx5KXEX7VgMr27xzxRAItVOwnxt0")
    
    func currentAccount(){
    GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
    //print("account:\(response)")
    
    let userDictionary = response as! NSDictionary
    let user = User(dictionary: userDictionary)
    
    
    print ("user: \(user.name)")
    print ("username: \(user.username)")
    print ("tagline: \(user.tagline)")
    print ("profile photo: \(user.profileUrl)")
    
    
    }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
    
    })
    }
    
    func login(success: () -> (), failure: (NSError) -> ())
    {
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath( "oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweety://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            //print ("I got a token")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            })
            {(error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
        }
    }
    
    func homeTimeline(success: ([Tweet])-> (), failure: (NSError) -> ())
        {
            GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetswithArray(dictionaries)
                
                success(tweets)
                
                    
                } 
                , failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                    failure(error)
    
                    
            })
        
        }

}

