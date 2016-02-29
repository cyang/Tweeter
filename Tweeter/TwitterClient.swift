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
}
