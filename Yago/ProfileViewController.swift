//
//  ProfileViewController.swift
//  Yago
//
//  Created by Christopher O'Brien on 4/15/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit
import QuartzCore

class ProfileViewController: CameraMenuItemController {
    var TAB_ITEM_TITLE: String = "Profile"
 
    @IBOutlet weak var LifeTimePoints: UILabel!
    @IBOutlet weak var currentAvailablePoints: UILabel!
    
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var instagramLabel: UILabel!
    @IBOutlet weak var inviteFriendsButton: UIButton!
    
    @IBAction func twitter(sender: UIButton) {
    }
    
    @IBAction func faceBook(sender: UIButton) {
    }
    
    
    @IBAction func instagram(sender: UIButton) {
    }
    
    @IBAction func add5(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        twitterButton.enabled = false
        instagramButton.enabled = false
        twitterLabel.enabled = false
        instagramLabel.enabled = false
        inviteFriendsButton.enabled = false

        // Do any additional setup after loading the view.
        self.title = "Profile"  //temporary until we figure out name situation
        
    }
    
    override func viewDidAppear(animated: Bool) {
        getProfileInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getProfileInfo() {
        let manager = AFHTTPRequestOperationManager()
        manager.GET( API_BASE_URL + "account/profile_info/",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                let lifetime: String! = String(responseObject["lifetime_score"] as Int)
                let currentPoints: Int! = responseObject["current_points"] as Int
                NSUserDefaults.standardUserDefaults().setObject(currentPoints, forKey: "userCurrentPoints")
                let firstName: String! = responseObject["first_name"] as String
                self.LifeTimePoints.text = lifetime
                self.currentAvailablePoints.text = String(currentPoints)
                //self.title = firstName
                //self.tabBarItem.title = self.TAB_ITEM_TITLE
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        
    }

}
