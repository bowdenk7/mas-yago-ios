//
//  PromotionDetailController.swift
//  Yago
//
//  Created by William Kelly on 4/15/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

class PromotionDetailController: CameraMenuItemController {
    
    @IBOutlet weak var balanceAfterPurchase: UILabel!
    @IBOutlet weak var promotionName: UILabel!
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var promotionCost: UILabel!
    
    var promotion: PromotionModel!
    var currentBalance: Int!
    
    @IBAction func TapToRedeemPressed(sender: UIButton) {
        self.performSegueWithIdentifier("TapToRedeem", sender: nil)
    }
    
    override func viewDidLoad() {
        let points: Int! = NSUserDefaults.standardUserDefaults().objectForKey("userCurrentPoints") as! Int
        self.balanceAfterPurchase.text = "\(points - self.promotion.pointCost)"
        self.venueName.text = self.promotion.venueName
        self.venueName.adjustsFontSizeToFitWidth = true
        self.promotionCost.text = String(self.promotion.pointCost)
        self.promotionName.text = self.promotion.promotionName
        self.promotionName.adjustsFontSizeToFitWidth = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TapToRedeem" {
            let nextScene = segue.destinationViewController as! RedeemPromotionController
            nextScene.promotion = self.promotion
        }
    }
    
}