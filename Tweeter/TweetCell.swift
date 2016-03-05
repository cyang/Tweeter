

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
    
    var tweet: Tweet! {
        didSet {
            print(tweet.text)
            tweetPostLabel.text = tweet.text as? String
            
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
