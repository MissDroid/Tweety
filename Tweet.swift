//
//  Tweet.swift
//  Tweety
//
//  Created by Maliha Fairooz on 2/24/16.
//  Copyright © 2016 Maliha Fairooz. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: String?
    var timestamp: NSDate?
    var timeString: String?
    var num: String
    var retweetCount: Int = 0
    var favCount: Int = 0
    
    init (dictionary: NSDictionary)
    {
        text = dictionary["text"] as? String
        retweetCount = (dictionary ["retweet_count"] as? Int) ?? 0
        favCount = (dictionary ["favorite_count"] as? Int) ?? 0
        num = String(dictionary["id"]!)
        user = User(dictionary: dictionary ["user"] as! NSDictionary)
        
        timeString = dictionary["created_at"] as? String
//        let timestampString = dictionary["created _at"] as? String
        if let timestampString = timeString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)

        }
    }
    
    class func tweetswithArray(dictionaries: [NSDictionary] ) -> [Tweet]
    {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        return tweets
    }
    

}
