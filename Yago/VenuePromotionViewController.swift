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
    
    func loadItem(#used: Bool, description: String, name:String, cost: Int) {
        promotionDescription.text = description
        venue.text = name
        value.text = "\(cost)"
        
        if(!used) {
            ribbonImage.image = UIImage(named: "Promotion Ribbon")
        } else {
            promotionDescription.textColor = UIColor.whiteColor()
            venue.textColor = UIColor.whiteColor()
            value.textColor = UIColor.whiteColor()
        }
    }
}

class VenuePromotionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var promotionTableView: UITableView!
    @IBOutlet weak var userYagoPointsAvailable: UILabel!
    
    var examplePromotions: [(Bool , String, String, Int)] = [(false, "Free Cover", "Tongue & Groove", 20), (true, "VIP Upgrade", "Gold Room", 40),
    (false, "Free Bud Light", "Park Bench Buckhead", 5)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "CustomPromotionTableViewCell", bundle:nil)
        promotionTableView.registerNib(nib, forCellReuseIdentifier: "promcustom")
        promotionTableView.separatorStyle = UITableViewCellSeparatorStyle.None

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableview: UITableView, numberOfRowsInSection section:Int)-> Int {
            return examplePromotions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomPromotionTableViewCell = tableView.dequeueReusableCellWithIdentifier("promcustom") as CustomPromotionTableViewCell
        var (used, description, venue, cost) = examplePromotions[indexPath.row]
        cell.loadItem(used:used, description:description, name:venue, cost:cost)
        return cell
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
