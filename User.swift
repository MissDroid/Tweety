//
//  User.swift
//  Tweety
//
//  Created by Maliha Fairooz on 2/24/16.
//  Copyright © 2016 Maliha Fairooz. All rights reserved.
//

import UIKit
import AFNetworking

let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    
    var name: String?
    var username: String?
    var profileUrl: NSURL?
    var tagline: String?
    static var _currentUser: User?
    
    var dictionary: NSDictionary?
    
    init (dictionary: NSDictionary)
    {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        username = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString ) 
        }
        
        
    }
    /*
    func logout() {
        User.currentUser == nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    */
    
    class var currentUser: User?
        {
        get {
            if _currentUser == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            let userData = defaults.objectForKey("currentUserData") as? NSData
        
        if let userData = userData {
            let dictionary = try!
            NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
            _currentUser = User(dictionary: dictionary)
        }
        }
        
            return _currentUser
        }
        set(user){
            
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user{
            let data = try!
                NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            }
            else {
                 defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        
        }

}

}