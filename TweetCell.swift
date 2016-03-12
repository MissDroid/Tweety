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
    
    var id: String = ""

    var tweet: Tweet!
        {
        didSet{
            nameLabel.text = tweet.user?.name
            usernameLabel.text = tweet.user?.username
            tweetLabel.text = tweet.text
            likesLabel.text = String(tweet.favCount)
            retweetsLabel.text = String(tweet.retweetCount)
            profilephotoView.setImageWithURL((tweet.user?.profileUrl!)!)
            
            
            id = tweet.num
            
            dateLabel.text = tweetTime(tweet.timestamp!.timeIntervalSinceNow)
        }
    }
    
    

    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.RT(Int(id)!, params: nil, completion: {(error) -> () in
        self.retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
        self.retweetsLabel.text = String(self.tweet.retweetCount + 1)
    })
    }
    
    
    @IBAction func onLike(sender: AnyObject) {
        TwitterClient.sharedInstance.Fav(Int(id)!, params: nil, completion: {(error) -> () in
            self.likeButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            self.likesLabel.text = String(self.tweet.favCount + 1)
        })
    }
    
    
    func tweetTime(time: NSTimeInterval) -> String
    {
        var timegiven = -Int(time)
        var timecalc: Int = 0
        
        print("timegiven: \(timegiven)")
        
        if timegiven == 0
        {
            return "Now"
        }
        else if timegiven <= 60
        {
            return "\(timegiven)s"
        }
        else if (timegiven/60 <= 60)
        {
            timecalc = timegiven/60
            return "\(timecalc)m"
        }
        else if (timegiven/3600 <= 24)
        {
            timecalc = timegiven/3600
            return "\(timecalc)h"
        }
        else if (timegiven/(3600*24) <= 365)
        {
            timecalc = timegiven/(3600*24)
            return "\(timecalc)d"
        }
        else
        {
            timecalc = timegiven/(3600*24*365)
            return "\(timecalc)y"
        }
        
        return "\(timecalc)"
        //print("timecalc: \(timecalc)")
    }
    
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
