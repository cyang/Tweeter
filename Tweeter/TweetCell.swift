

//
//  TweetCell.swift
//  Tweeter
//
//  Created by Christopher Yang on 3/5/16.
//  Copyright © 2016 Christopher Yang. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetPostLabel: UILabel!
    
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    @IBOutlet weak var retweetedImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            profileImageView.setImageWithURL(tweet.profileImageUrl!)
            usernameLabel.text = tweet.username as String
            twitterHandleLabel.text = ("@\(tweet.twitterHandle as String)")
            tweetPostLabel.text = tweet.text as? String
            timestampLabel.text = "\(tweet.timeDisplay as String)h"
            
            
            replyImageView.setImageWithURL(NSURL(string: "https://g.twimg.com/dev/documentation/image/reply-action_0.png")!)

            retweetImageView.setImageWithURL(NSURL(string: "https://g.twimg.com/dev/documentation/image/retweet-action.png")!)
        
            likeImageView.setImageWithURL(NSURL(string: "https://g.twimg.com/dev/documentation/image/like-action.png")!)
            
            retweetedImageView.setImageWithURL(NSURL(string: "https://g.twimg.com/dev/documentation/image/retweet-action.png")!)
         
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
