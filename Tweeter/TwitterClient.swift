//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Christopher Yang on 2/29/16.
//  Copyright © 2016 Christopher Yang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "5BXfPVEondBgiYdMlHoIRJ5zR", consumerSecret: "OvpdOdiEAZZi4GYUJFn9zjTcD1XzVrmnzno8ZuS2s6VqjlqT8y")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries)
                
                success(tweets)
                
                
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
            })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let userDictionary = response as! NSDictionary
                
                let user = User(dictionary: userDictionary)
                
                success(user)
                
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })
    }
    
    func login(success: () -> (), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweeter://oauth"), scope: nil,
            success: { (requestToken: BDBOAuth1Credential!) -> Void in
                
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(url!)
                
            }) { (error: NSError!) -> Void in
                failure(error)
            }
    }
    
    func handleOpenUrl(url: NSURL){
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken,
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                
                self.currentAccount({ (user: User) -> () in
                    User.currentUser = user
                    
                    self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                        self.loginFailure?(error)

                })
                
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }

    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func like(id: String, success: (Tweet) -> (), failure: (NSError) -> ()){
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, constructingBodyWithBlock: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let tweetDictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: tweetDictionary)
            
            success(tweet)
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        }
        
    }
    
    func retweet(id: String, success: (Tweet) -> (), failure: (NSError) -> ()){
        POST("/1.1/statuses/retweet/\(id).json", parameters: nil, constructingBodyWithBlock: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let tweetDictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: tweetDictionary)
            
            print(tweetDictionary)
            success(tweet)
            
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
            }
        
    }
    
    func post(text: String) {
    POST("1.1/statuses/update.json?status=\(text)", parameters: nil, constructingBodyWithBlock: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("COMPOSED")
        }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            print(error.localizedDescription)

        }
    }

}
