//
//  ViewController.swift
//  Reddit4Watch
//
//  Created by Gregory Hogue on 2015-01-15.
//  Copyright (c) 2015 NetFunctional. All rights reserved.
//

import Foundation
import UIKit

class BrowseViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var redditWebView: UIWebView!
    
    @IBAction func redditButton(sender: UIButton) {
        loadRedditUrl("http://www.reddit.com/")
    }
    
    @IBAction func backBarButton(sender: UIBarButtonItem) {
        if redditWebView.canGoBack {
            redditWebView.goBack()
        }
    }
    
    @IBAction func forwardBarButton(sender: UIBarButtonItem) {
        if redditWebView.canGoForward {
            redditWebView.goForward()
        }
    }
    
    @IBAction func bookButton(sender: AnyObject) {
    }
    
    @IBAction func urlTextFieldEdited(sender: UITextField) {
        let text = sender.text
        
        if (text.lowercaseString.rangeOfString("reddit.com") != nil) {
            loadRedditUrl(text)
        } else if (text.lowercaseString.rangeOfString("/") != nil) {
            loadRedditUrl("http://www.reddit.com/" + text)
        } else {
            sender.text = "r/" + text
            loadRedditUrl("http://www.reddit.com/r/" + text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleWatchKitNotification:"), name: "WatchExtensionCom", object: nil)
        
        loadRedditUrl("http://www.reddit.com/")
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleWatchKitNotification(notification: NSNotification) {
        if let userInfo = notification.object as? [String : String] {
            if let redditURL = userInfo["redditURL"] {
                loadRedditUrl("http://www.reddit.com" + redditURL)
            }
        }
    }
    
    func loadRedditUrl(stringUrl: String) {
        let url = NSURL(string: (stringUrl + ".compact"))!
        let request = NSURLRequest(URL: url)
        redditWebView.loadRequest(request)
    }
    
    func loadUrl(stringUrl: String) {
        let url = NSURL(string: stringUrl)!
        let request = NSURLRequest(URL: url)
        redditWebView.loadRequest(request)
    }
}

