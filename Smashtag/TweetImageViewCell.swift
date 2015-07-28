//
//  TweetImageViewCell.swift
//  Smashtag
//
//  Created by Malcolm Macleod on 27/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import UIKit

class TweetImageViewCell: UITableViewCell {

   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var imageURL : NSURL? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        imageView?.image = nil
        
        if let imageImageURL = imageURL {
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos, 0), { () -> Void in
                
                if let imageData = NSData(contentsOfURL: imageImageURL) {
                    // main thread
                    dispatch_async(dispatch_get_main_queue(), {
                        imageView?.image = UIImage(data: imageData)
                    })
                }
            })
        }

    }

}
