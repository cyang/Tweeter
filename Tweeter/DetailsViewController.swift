//
//  DetailsViewController.swift
//  Tweeter
//
//  Created by Christopher Yang on 3/9/16.
//  Copyright © 2016 Christopher Yang. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIGestureRecognizerDelegate{

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
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create an instance of UITapGestureRecognizer and tell it to run
        // an action we'll call "handleTap:"
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        // we use our delegate
        tap.delegate = self
        // allow for user interaction
        profileImageView.userInteractionEnabled = true
        // add tap as a gestureRecognizer to tapView
        profileImageView.addGestureRecognizer(tap)
            
            
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
        
        timeStampLabel.text = String(tweet.timeStamp!)
        
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

    func handleTap(sender: UITapGestureRecognizer? = nil) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("ProfileView") as! ProfileViewController
        
        nextViewController.tweet = self.tweet
        
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }

}
