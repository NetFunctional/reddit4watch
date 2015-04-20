//
//  RedditJsonFetcher.swift
//  Reddit4Watch
//
//  Created by Gregory Hogue on 2015-01-15.
//  Copyright (c) 2015 NetFunctional. All rights reserved.
//

import Foundation

class RedditJsonFetcher {
    
    var json: AnyObject?
    
    init(stringUrl: String) {
        json = getJson(NSURL(string: stringUrl))
    }
    
    func httpGet(url: NSURL!, callback: (NSString, NSString?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) {(data, response, error) -> Void in
            if error == nil {
                callback(NSString(data: data, encoding: NSUTF8StringEncoding)!, nil)
            } else {
                callback("", error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getJson(url: NSURL!) -> AnyObject? {
        var json: AnyObject?
        
        httpGet(url) {(data, error) -> Void in
            if error == nil {
                var parseError: NSError?
                let jsonData: NSData = data.dataUsingEncoding(NSUTF8StringEncoding)!
                json = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.allZeros, error: &parseError)
            } else {
                println(error)
            }
        }
        
        while json == nil {}
        
        return json
    }
}