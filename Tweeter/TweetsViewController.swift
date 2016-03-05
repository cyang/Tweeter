//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by Christopher Yang on 2/29/16.
//  Copyright © 2016 Christopher Yang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
            print(tweets!.count)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
