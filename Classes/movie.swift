//
//  movie.swift
//  Movies
//
//  Created by Sayed Abdo on 4/2/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import Foundation

class movie: NSObject {
    var poster_path:String?
    var title:String?
    var overview:String?
    var release_date:String?
    var user_rate:Float?
    var id :Int?
    
    init(poster:String,title:String,overview:String,release_date:String,id:Int,user_rate:Float) {
        self.poster_path = poster
        self.title=title
        self.overview=overview
        self.user_rate=user_rate
        self.release_date=release_date
        self.id=id
            }
    override init() {
        self.poster_path = ""
        self.title=""
        self.overview=""
        self.release_date=""
            }
}
