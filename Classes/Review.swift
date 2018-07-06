//
//  Review.swift
//  Movies
//
//  Created by Sayed Abdo on 4/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import Foundation

class Review :NSObject{
    var content:String?
    var author:String?
    var revUrl:String?
    
    init(content:String,author:String,revUrl:String) {
        self.content = content
        self.author = author
        self.revUrl = revUrl

    }
}
