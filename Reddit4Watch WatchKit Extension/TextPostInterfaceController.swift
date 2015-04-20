//
//  TextPostInterfaceController.swift
//  Reddit4Watch
//
//  Created by Gregory Hogue on 2015-01-30.
//  Copyright (c) 2015 NetFunctional. All rights reserved.
//

import WatchKit
import Foundation

class TextPostInterfaceController: WKInterfaceController {
    
    var redditURL: NSString = ""
    
    @IBOutlet weak var postTitleLabel: WKInterfaceLabel!
    @IBOutlet weak var postTextLabel: WKInterfaceLabel!
    @IBOutlet weak var postScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var postSubredditLabel: WKInterfaceLabel!
    @IBOutlet weak var postAuthorLabel: WKInterfaceLabel!
    @IBOutlet weak var postDateLabel: WKInterfaceLabel!
    
    @IBAction func iPhoneButtonAction() {
        println(redditURL)
        WKInterfaceController.openParentApplication(["redditURL": redditURL],
            reply: {(reply, error) -> Void in
                println("Reply to openParentApplication received from iPhone app")
        })
    }
    
    init(context: AnyObject?) {
        super.init()
        if let post = context as? NSDictionary {
            redditURL = post["permalink"] as! String
            
            postTitleLabel.setText(post["title"] as? String)
            postTextLabel.setText(post["selftext"] as? String)
            postScoreLabel.setText(toString(post["score"] as! Int))
            postSubredditLabel.setText(post["subreddit"] as? String)
            postAuthorLabel.setText(post["author"] as? String)
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
            postDateLabel.setText(dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: NSTimeInterval(post["created"] as! Int))))
        }
    }
}