//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by Christopher Yang on 2/29/16.
//  Copyright © 2016 Christopher Yang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    var user: User!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.currentAccount({ (user: User) -> () in
            self.user = user
            
            self.profileImageView.setImageWithURL(self.user.profileUrl!)
            self.usernameLabel.text = self.user.name as? String
            self.twitterHandleLabel.text = self.user.screenName as? String
            self.backgroundImageView.setImageWithURL(self.user.backgroundImageUrl!)
            
            self.followersCountLabel.text = String(self.user.followersCount)
            self.followingCountLabel.text = String(self.user.followingCount)
            self.tweetsCountLabel.text = String(self.user.tweetsCount)
            
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.estimatedRowHeight = 120
            
            self.tableView.reloadData()
            
        }) { (error: NSError) -> () in
            print("Error: \(error.localizedDescription)")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender is UITableViewCell){
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]

        
            let detailsViewController = segue.destinationViewController as! DetailsViewController
            detailsViewController.tweet = tweet
        } else {
            let nav = segue.destinationViewController as! UINavigationController
            let composeViewController = nav.topViewController as! ComposeViewController
            composeViewController.user = self.user
        }
    }


}
