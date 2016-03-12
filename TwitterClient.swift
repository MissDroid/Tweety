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
    
    var loginsuccess: (() -> ())?
    var loginfailure: ((NSError) -> ())?
    
    
    func login(success: () -> (), failure: (NSError) -> ())
    {
        loginsuccess = success
        loginfailure = failure
     
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath( "oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweety://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print ("I got a token")

            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            })
            {(error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginfailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogout", object: nil)
    }
    
    
    
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginsuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginfailure?(error)
            })
            
            
            }) { (error:NSError!) -> Void in
                print ("error:  \(error.localizedDescription)")
                self.loginfailure?(error)
        }
    }
    
    func homeTimeline(success: ([Tweet])-> (), failure: (NSError) -> ())
        {
            GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetswithArray(dictionaries)
                
                success(tweets)
                           //print ("user: \(response)")
                
                    
                } 
                , failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                    failure(error)
                    
            })
        
        }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)
            print("username: \(user.name)")
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    
    func RT(num: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/retweet/\(num).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            completion(error: nil)
            print ("RT")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
        )
    }
    
    func Fav(num: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/create.json?id=\(num)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            completion(error: nil)
            print ("Fav")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
        )}

}

