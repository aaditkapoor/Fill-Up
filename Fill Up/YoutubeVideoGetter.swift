//
//  YoutubeVideoGetter.swift
//  Fill Up
//
//  Created by Aadit Kapoor on 6/4/17.
//  Copyright © 2017 Aadit Kapoor. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

class VideoGetter {
    var baseUrl = "http://video.google.com/timedtext?lang=en&v="
    var urlToGet:String!
    var responseToParse:String!
    
    
    var data:Array<String> = []
    
    init(id:String) {
        self.urlToGet = "http://video.google.com/timedtext?lang=en&v=\(id)"
        print(self.urlToGet)
    }
    
    
    func getCaptions() {
        
        print (self.data
        )
        
    }
    
}
