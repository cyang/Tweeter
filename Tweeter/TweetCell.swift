

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
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var retweetedImageView: UIImageView!
    
    @IBOutlet weak var userRetweeted: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    var tweet: Tweet! {
        didSet {
            profileImageView.setImageWithURL(tweet.profileImageUrl!)
            usernameLabel.text = tweet.username as String
            twitterHandleLabel.text = ("@\(tweet.twitterHandle as String)")
            tweetPostLabel.text = tweet.text as? String
            timestampLabel.text = "\(tweet.timeDisplay as String)h"


            likeButton.setImage(UIImage(named: "like_action"), forState: UIControlState.Normal)
            retweetButton.setImage(UIImage(named: "retweet_action"), forState: UIControlState.Normal)
            replyButton.setImage(UIImage(named: "reply_action"), forState: UIControlState.Normal)
            
            retweetCount.text = String(tweet.retweetCount)
            likeCount.text = String(tweet.favoritesCount)
            
            if (tweet.retweeted_bool) {
                retweetButton.setImage(UIImage(named: "retweet_action_on"), forState: UIControlState.Normal)
            }
            
            if (tweet.liked_bool) {
                likeButton.setImage(UIImage(named: "like_action_on"), forState: UIControlState.Normal)
            }
            
            handleRetweets()
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

    func handleRetweets(){
        if (tweet.retweet_status == true) {
            userRetweeted.hidden = false
            retweetedImageView.hidden = false
            
            retweetedImageView.setImageWithURL(NSURL(string: "https://g.twimg.com/dev/documentation/image/retweet-action.png")!)
            userRetweeted.text = "\(tweet.username) retweeted"
            profileImageView.setImageWithURL(tweet.retweet_imageURL!)
            
            usernameLabel.text = tweet.retweet_username as
            String
            
            twitterHandleLabel.text = "@\(tweet.retweet_handle)"
            
            tweetPostLabel.text = tweet.retweet_text as String
            
        } else {
            userRetweeted.hidden = true
            retweetedImageView.hidden = true
        }
    }

    @IBAction func onRetweetButton(sender: AnyObject) {
        retweetButton.setImage(UIImage(named: "retweet_action_on"), forState: UIControlState.Normal)
        TwitterClient.sharedInstance.retweet(tweet.id as String,
            success: { (tweet: Tweet) -> () in
                self.tweet = tweet
                self.retweetCount.text = String(tweet.retweetCount)
                
                print("RETWEETED")

            }) { (error: NSError) -> () in
                print("NO RETWEET")
        }
        
        
        
    }
    
    @IBAction func onLikeButton(sender: AnyObject) {
        likeButton.setImage(UIImage(named: "like_action_on"), forState: UIControlState.Normal)
        TwitterClient.sharedInstance.like(tweet.id as String,
            success: { (tweet: Tweet) -> () in
                self.tweet = tweet
                self.likeCount.text = String(tweet.favoritesCount)
                print("LIKED")
            }) { (error: NSError) -> () in
                print("NO LIKE")
        }
        

    }
}
