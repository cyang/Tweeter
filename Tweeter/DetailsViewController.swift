//
//  DetailsViewController.swift
//  Tweeter
//
//  Created by Christopher Yang on 3/9/16.
//  Copyright © 2016 Christopher Yang. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var tweet: Tweet!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var tweetPostLabel: UILabel!
    
    @IBOutlet weak var retweetedImageView: UIImageView!
    
    @IBOutlet weak var userRetweeted: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setImageWithURL(tweet.profileImageUrl!)
        usernameLabel.text = tweet.username as String
        twitterHandleLabel.text = ("@\(tweet.twitterHandle as String)")
        tweetPostLabel.text = tweet.text as? String
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
