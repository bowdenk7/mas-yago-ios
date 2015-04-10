//
//  BarFeedViewCell.swift
//  Yago
//
//  Created by Christopher O'Brien on 3/25/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit

class BarFeedViewCell: UICollectionViewCell {

    required init(coder aDecoder: NSCoder) {
        self.post = PostModel()
        super.init(coder: aDecoder)
    }

    
    @IBOutlet weak var withinBarImage: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var post : PostModel
    
    @IBAction func likePressed(sender: UIButton) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        var params : Dictionary = ["post": post.id]
        manager.POST( API_BASE_URL + "post/like_post/",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if let totalLikes = responseObject["total_likes"] as? NSInteger {
                    self.likeCount.text = String(totalLikes)
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
}
