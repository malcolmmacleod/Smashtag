//
//  TweetInfoTableViewController.swift
//  Smashtag
//
//  Created by Malcolm Macleod on 26/07/2015.
//  Copyright (c) 2015 Malcolm Macleod. All rights reserved.
//

import UIKit

class TweetInfoTableViewController: UITableViewController {
    
    var selectedTweet: Tweet? {
        didSet {
            tableView.reloadData()
            
            for tag in selectedTweet!.hashtags {
                hashtags.append(tag.keyword)
            }
            
            for tag in selectedTweet!.urls {
                urls.append(tag.keyword)
            }
            
            for tag in selectedTweet!.userMentions {
                mentions.append(tag.keyword)
            }
            
            for tag in selectedTweet!.media {
                images.append(tag.url)
            }
        }
    }
    
 
    
    private var hashtags : [String] = []
    private var urls : [String] = []
    private var images : [NSURL] = []
    private var mentions : [String] = []
    
    var sections : [Int: String] {
        get {
            var sectionDictionary = [Int: String]()
            
            if !hashtags.isEmpty {
                sectionDictionary[sectionDictionary.count] = "hashtags"
            }
            if !urls.isEmpty {
                sectionDictionary[sectionDictionary.count] = "urls"
            }
            if !images.isEmpty {
                sectionDictionary[sectionDictionary.count] = "images"
            }
            if !mentions.isEmpty {
                sectionDictionary[sectionDictionary.count] = "mentions"
            }
            
            return sectionDictionary
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        let sectionName = sections[section]!
        
        switch sectionName {
            case "hashtags": return hashtags.count
            case "urls" : return urls.count
            case "images" : return images.count
            case "mentions" : return mentions.count
            default : return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return sections[section]
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetInfoCell", forIndexPath: indexPath) as! UITableViewCell
        
        let sectionName = sections[indexPath.section]!
        
        switch sectionName {
            case "images":
            let imageCell = tableView.dequeueReusableCellWithIdentifier("TweetImageCell", forIndexPath: indexPath) as! TweetImageViewCell
            
            imageCell.imageURL = images[indexPath.row]
            return imageCell
            
        case "hashtags": cell.textLabel?.text = hashtags[indexPath.row]
        case "urls" : cell.textLabel?.text = urls[indexPath.row]
        case "mentions" : cell.textLabel?.text = mentions[indexPath.row]
        default : cell.textLabel?.text = ""
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let sectionName = sections[indexPath.section]!
        
        switch sectionName {
        case "images":
            return CGFloat(200)
        default:
            return UITableViewAutomaticDimension
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let selectedCell = sender as? UITableViewCell {
            if let indexPath = tableView.indexPathForCell(selectedCell) {
                let sectionName = sections[indexPath.section]!
                if sectionName == "urls" {
                    let url = urls[indexPath.row]
                    
                    UIApplication.sharedApplication().openURL(NSURL(fileURLWithPath: url)!)
                    
                    return false
                }
            }
        }
        
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        if let selectedCell = sender as? UITableViewCell {
            if let indexPath = tableView.indexPathForCell(selectedCell) {
                let sectionName = sections[indexPath.section]!

                switch sectionName {
                    case "mentions": fallthrough
                    case "hashtags":
                    
                        if segue.identifier == "ShowSearchResults" {
                            if let tvc = segue.destinationViewController as? TweetTableViewController {
                                tvc.searchText = selectedCell.textLabel?.text
                            }
                    }
                case "images" :
                    if segue.identifier == "ShowImageDetail" {
                        if let ivc = segue.destinationViewController as? ImageViewController {
                            ivc.imageURL = images[indexPath.row]
                        }
                    }
                default: break
                }
            }
        }
    }
}
