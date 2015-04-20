//
//  InterfaceController.swift
//  Reddit4Watch WatchKit Extension
//
//  Created by Gregory Hogue on 2015-01-15.
//  Copyright (c) 2015 NetFunctional. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    let neutralColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
    let downVoteColor = UIColor(red: 148/255, green: 148/255, blue: 255/255, alpha: 1)
    var posts: NSArray!
    
    @IBOutlet weak var postTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        posts = loadPage("http://www.reddit.com/")
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        let post = posts[rowIndex] as! NSDictionary
        return post
    }
    
    func loadPage(redditUrl: NSString) -> NSArray {
        let postData = JsonPostParser(json: RedditJsonFetcher(stringUrl: "\(redditUrl).json").json).postData
        
        var rowTypes: [AnyObject] = []
        
        for post in postData {
            let thumbnail = post["thumbnail"] as! String
            
            // Check whether or not a post has a thumbnail
            if (thumbnail.lowercaseString.rangeOfString("http://") != nil) {
                rowTypes.append("ThumbnailPostRowController")
            } else {
                rowTypes.append("TextPostRowController")
            }
        }
        
        postTable.setRowTypes(rowTypes)
        
        for (index, post) in enumerate(postData) {
            let thumbnail = post["thumbnail"] as! NSString
            
            if thumbnail.containsString("http://") {
                let row = postTable.rowControllerAtIndex(index) as! ThumbnailPostRowController
                
                row.postTitleLabel.setText(post["title"] as? String)
                row.postThumbnailImage.setImage(UIImage(data: NSData(contentsOfURL: NSURL(string: thumbnail as String)!)!))
                row.postSubredditLabel.setText(post["subreddit"] as? String)
                
                let score = post["score"] as! Int
                row.postScoreLabel.setText(toString(score))
                
                if score == 0 {
                    row.postScoreLabel.setTextColor(neutralColor)
                } else if score < 0 {
                    row.postScoreLabel.setTextColor(downVoteColor)
                }
            } else {
                let row = postTable.rowControllerAtIndex(index) as! TextPostRowController
                
                row.postTitleLabel.setText(post["title"] as? String)
                row.postScoreLabel.setText(toString(post["score"] as! Int))
                row.postSubredditLabel.setText(post["subreddit"] as? String)
                
                let score = post["score"] as! Int
                row.postScoreLabel.setText(toString(score))
                
                if score == 0 {
                    row.postScoreLabel.setTextColor(neutralColor)
                } else if score < 0 {
                    row.postScoreLabel.setTextColor(downVoteColor)
                }
            }
        }
        
        return postData
    }
}
