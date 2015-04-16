//
//  VenuePromotionViewController.swift
//  Yago
//
//  Created by Christopher O'Brien on 4/15/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit

class CustomPromotionTableViewCell: UITableViewCell {
    @IBOutlet var ribbonImage: UIImageView!
    @IBOutlet var promotionDescription: UILabel!
    @IBOutlet var venue: UILabel!
    @IBOutlet var value: UILabel!
    
    func loadItem(#canAfford: Bool, promoName: String, venueName:String, cost: Int) {
        promotionDescription.text = promoName
        venue.text = venueName
        value.text = "\(cost)"
        
        if(canAfford) {
            ribbonImage.image = UIImage(named: "Promotion Ribbon")
        } else {
            ribbonImage.image = nil
            promotionDescription.textColor = UIColor.whiteColor()
            venue.textColor = UIColor.whiteColor()
            value.textColor = UIColor.whiteColor()
        }
    }
}

class VenuePromotionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var promotionTableView: UITableView!
    @IBOutlet weak var userYagoPointsAvailable: UILabel!
    
    var promotions: [PromotionModel] = []
    var selectedPromotion: PromotionModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Promotions"
        var nib = UINib(nibName: "CustomPromotionTableViewCell", bundle:nil)
        promotionTableView.registerNib(nib, forCellReuseIdentifier: "promcustom")
        promotionTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let points: Int! = NSUserDefaults.standardUserDefaults().objectForKey("userCurrentPoints") as! Int
        self.userYagoPointsAvailable.text = "\(points)"
        getUserData()
        getPromotions()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        getUserData()
        getPromotions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableview: UITableView, numberOfRowsInSection section:Int)-> Int {
        return promotions.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPromotion = promotions[indexPath.row]
        self.performSegueWithIdentifier("PromotionSelected", sender: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomPromotionTableViewCell = tableView.dequeueReusableCellWithIdentifier("promcustom") as! CustomPromotionTableViewCell
        var promotion = promotions[indexPath.row]
        let currentPoints: Int! = NSUserDefaults.standardUserDefaults().objectForKey("userCurrentPoints")as! Int
        let canAfford: Bool = currentPoints >= promotion.pointCost
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if (canAfford) {
            cell.userInteractionEnabled = true
        } else {
            cell.userInteractionEnabled = false
        }
        cell.loadItem(canAfford:canAfford, promoName:promotion.promotionName, venueName:promotion.venueName, cost:promotion.pointCost)
        return cell
    }
    
    
    func getPromotions() {
        var promotions:[PromotionModel] = []
        let manager = AFHTTPRequestOperationManager()
        manager.GET( API_BASE_URL + "promotion/promotion_type_feed/",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if let items = responseObject as? NSArray {
                    for item in items {
                        var feedItem:PromotionModel = PromotionModel(
                            promotionName: item["name"] as! String,
                            venueName: item["venue_name"] as! String,
                            pointCost: item["point_cost"] as! Int,
                            id: item["pk"] as! Int
                        )
                        promotions += [feedItem]
                    }
                }
                self.promotions = promotions
                self.promotionTableView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
    
    func getUserData() {
        let manager = AFHTTPRequestOperationManager()
        var userId: Int! = NSUserDefaults.standardUserDefaults().objectForKey("userId") as! Int
        manager.GET( API_BASE_URL + "users/\(userId)/",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                let points: Int! = responseObject["current_points"] as! Int
                NSUserDefaults.standardUserDefaults().setObject(points, forKey: "userCurrentPoints")
                self.userYagoPointsAvailable.text = "\(points)"

            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PromotionSelected" {
            let nextScene = segue.destinationViewController as! PromotionDetailController
            nextScene.promotion = selectedPromotion
        }
    }
}
