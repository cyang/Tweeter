//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Christopher Yang on 3/10/16.
//  Copyright © 2016 Christopher Yang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var screenName: String?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!

    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance.getUser(screenName! as String, success: { (user: User) -> () in
                self.user = user
                self.profileImageView.setImageWithURL(user.profileUrl!)
                self.usernameLabel.text = user.name as? String
                self.twitterHandleLabel.text = ("@\(user.screenName as! String)")
            
                self.tweetsCountLabel.text = String(user.tweetsCount)
                self.followersCountLabel.text = String(user.followersCount)
                self.followingCountLabel.text = String(user.followingCount)
            
            
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
