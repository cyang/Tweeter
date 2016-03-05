//
//  Tweet.swift
//  Tweeter
//
//  Created by Christopher Yang on 2/29/16.
//  Copyright © 2016 Christopher Yang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileImageUrl: NSURL?
    var twitterHandle: NSString!
    var username: NSString!
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        

        profileImageUrl = NSURL(string: (dictionary["user"]!["profile_image_url_https"] as! String))!
        twitterHandle = dictionary["user"]!["screen_name"] as! String
        username = dictionary["user"]!["name"] as! String
        
        
        let timeStampString = dictionary["created_at"] as? String
        
        
        if let timeStampString = timeStampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.dateFromString(timeStampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        
        return tweets
    }
}


