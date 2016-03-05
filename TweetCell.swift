//
//  TweetCell.swift
//  Tweety
//
//  Created by Maliha Fairooz on 2/27/16.
//  Copyright © 2016 Maliha Fairooz. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilephotoView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!

    
    override func awakeFromNib() {
        //  weak var usernameLabel: UILabel!
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
