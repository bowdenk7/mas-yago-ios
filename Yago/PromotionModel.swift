//
//  PromotionModel.swift
//  Yago
//
//  Created by Christopher O'Brien on 4/14/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import Foundation

class PromotionModel {
    var promotionName: String = ""
    var venueName: String = ""
    var pointCost: Int = 0
    var address: String = ""
    var openTimes: String = ""
    var id: Int = 0
    
    init(promotionName: String, venueName: String, pointCost: Int, id: Int) {
        self.promotionName = promotionName
        self.venueName = venueName
        self.pointCost = pointCost
        self.id = id
    }
    
}