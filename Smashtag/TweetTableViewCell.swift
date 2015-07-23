//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Malcolm Macleod on 23/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    func updateUI() {
        tweetText?.attributedText = nil
        tweetScreenName?.text = nil
        tweetProfileImageView?.image = nil
        
        if let tweet = self.tweet {
            tweetText.text = tweet.text
            
            if tweetText?.text != nil {
                for _ in tweet.media {
                    tweetText.text! += "."
                }
            }
        }
        
        tweetScreenName?.text = "\(tweet?.user)"
        
        if let profileImageURL = tweet!.user.profileImageURL {
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos, 0), { () -> Void in

                if let imageData = NSData(contentsOfURL: profileImageURL) {
                	// main thread
                    dispatch_async(dispatch_get_main_queue(), {
                        tweetProfileImageView?.image = UIImage(data: imageData)
                        })
                }
            })
        }
    }
}
