//
//  ComposeViewController.swift
//  Tweeter
//
//  Created by Christopher Yang on 3/10/16.
//  Copyright © 2016 Christopher Yang. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var characterCountButton: UIBarButtonItem!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.currentAccount({ (user: User) -> () in
                self.user = user
                self.profileImageView.setImageWithURL(self.user.profileUrl!)
                self.usernameLabel.text = self.user.name as? String
                self.twitterHandleLabel.text = "@\(self.user.screenName as! String)"
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweetButton(sender: AnyObject) {
        TwitterClient.sharedInstance.post(messageField.text!)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        characterCountButton.title = String(140 - messageField.text!.characters.count)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
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
