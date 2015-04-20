//
//  JsonPostParser.swift
//  Reddit4Watch
//
//  Created by Gregory Hogue on 2015-01-15.
//  Copyright (c) 2015 NetFunctional. All rights reserved.
//

import Foundation

class JsonPostParser {
    
    var postData: [NSDictionary] = []
    
    init(json: AnyObject?) {
        postData = parse(json)
    }
    
    func parse(json: AnyObject?) -> [NSDictionary] {
        var postData: [NSDictionary] = []
        
        let jsonDict = json as! NSDictionary
        let data = jsonDict["data"] as! NSDictionary
        let children = data["children"] as! NSArray  // List of posts
        
        for child in children {
            let childData = child["data"] as! NSDictionary
            postData.append(childData)
        }
        
        return postData
    }
}