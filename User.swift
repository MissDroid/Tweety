//
//  User.swift
//  Tweety
//
//  Created by Maliha Fairooz on 2/24/16.
//  Copyright © 2016 Maliha Fairooz. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var username: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    init (dictionary: NSDictionary)
    {
        name = dictionary["name"] as? String
        username = dictionary["screen_name"] as? String
        
        tagline = dictionary["description"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString ) 
        }
        
    }

}
