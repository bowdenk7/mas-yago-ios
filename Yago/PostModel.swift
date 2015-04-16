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
    var timeText: String = ""
    var isLiked: Bool = false
    
    init() {
        self.imageUrl = ""
        self.likes = 0
        self.id = 0
        self.timeText = ""
        self.isLiked = false
    }
    
    init(imageUrl: String, likes: Int, timeText: String, id: Int, isLiked: Bool) {
        self.imageUrl = imageUrl
        self.likes = likes
        self.timeText = timeText
        self.id = id
        self.isLiked = isLiked
    }
    
}