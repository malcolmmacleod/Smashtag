//
//  SavedTweets.swift
//  Smashtag
//
//  Created by Malcolm Macleod on 29/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import Foundation

class SavedTweets {
    
    private var tweets: [String]
    
    init() {
        tweets = [String]()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedDefaults = defaults.arrayForKey("Smashtag.SavedSearches") {
            for savedDefault in savedDefaults {
                let savedDefaultString = savedDefault as? String
                tweets.append(savedDefaultString!)
            }
        }
    }
    
    func addSearchItem(aSearch : String) -> () {
        tweets.append(aSearch)
        
        while tweets.count > 100 {
            tweets.removeLast()
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(tweets, forKey: "Smashtag.SavedSearches")
    }
    
    func getTweetSearchesCount() -> Int {
        return tweets.count
    }
    
    func getTwitterSearchItem(item: Int) -> String {
        return tweets[item]
    }
}