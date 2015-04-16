//
//  RedeemPromotionController.swift
//  Yago
//
//  Created by William Kelly on 4/15/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

class RedeemPromotionController: CameraMenuItemController {
    
    @IBOutlet weak var promotionName: UILabel!
    @IBOutlet weak var venueName: UILabel!
    var promotion: PromotionModel!
    
    @IBAction func redeemPressed(sender: UIButton) {
        redeemPromotion()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promotionName.text = promotion.promotionName
        promotionName.adjustsFontSizeToFitWidth = true
        venueName.text = promotion.venueName
        venueName.adjustsFontSizeToFitWidth = true
    }
    
    func redeemPromotion() {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        var params : Dictionary = ["type": promotion.id]
        manager.POST( API_BASE_URL + "promotion/purchase_and_redeem/",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                NSUserDefaults.standardUserDefaults().setObject(responseObject["new_points_total"], forKey: "userCurrentPoints")
                self.navigationController?.popToRootViewControllerAnimated(true)
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
}