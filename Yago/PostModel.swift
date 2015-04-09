//
//  PostModel.swift
//  Yago
//
//  Created by William Kelly on 4/7/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import Foundation

class PostModel {
    
    var imageUrl: String = ""
    var likes: Int = 0
    var id: Int = 0
    
    init(imageUrl: String, likes: Int, id: Int) {
        self.imageUrl = imageUrl
        self.likes = likes
        self.id = id
    }
    
}