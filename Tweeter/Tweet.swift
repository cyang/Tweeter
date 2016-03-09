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
    var timeDisplay: NSString!
    var retweet_status = false
    var retweet_text: NSString!
    var retweet_handle: NSString!
    var retweet_username: NSString!
    var retweet_imageURL: NSURL?
    var id: NSString!
    
    init(dictionary: NSDictionary) {
        id = dictionary["id_str"] as! String
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        

        profileImageUrl = NSURL(string: (dictionary["user"]!["profile_image_url_https"] as! String))!
        twitterHandle = dictionary["user"]!["screen_name"] as! String
        username = dictionary["user"]!["name"] as! String
        
        let retweeted_status = dictionary["retweeted_status"]
        
        if (retweeted_status != nil){
            retweet_status = true
            retweet_username = retweeted_status!["user"]!!["name"] as! String
            retweet_text = retweeted_status!["text"] as! String
            retweet_imageURL = NSURL(string: retweeted_status!["user"]!!["profile_image_url_https"] as! String)
            retweet_handle = retweeted_status!["user"]!!["screen_name"] as! String
            
            
        }
        
        
        let timeStampString = dictionary["created_at"] as? String
        
        
        if let timeStampString = timeStampString {
            
            let calendar = NSCalendar.currentCalendar()
            let date = NSDate()
            let currentHour = calendar.component(.Hour, fromDate: date)
            let currentDay = calendar.component(.Day, fromDate: date)
            
            let formatter = NSDateFormatter()
            formatter.timeZone = NSTimeZone(abbreviation: "EST")
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.dateFromString(timeStampString)
            
            let hour = calendar.component(.Hour, fromDate: timeStamp!)
            let day = calendar.component(.Day, fromDate: timeStamp!)

            if (currentDay == day){
                if (currentHour - hour >= 0) {
                    timeDisplay = String(currentHour - hour)
                }
            } else {
                timeDisplay = "24+"
            }
            
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


