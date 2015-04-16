//
//  ProfileViewController.swift
//  Yago
//
//  Created by Christopher O'Brien on 4/15/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit
import QuartzCore

class ProfileViewController: UIViewController {
    var userName: String! = "Alex"
    var avaialblePoints: Int = 36
    var lifeTimePoints: Int! = 140
    
    @IBOutlet weak var navTitle: UINavigationItem!

    @IBOutlet weak var LifeTimePoints: UILabel!
    @IBOutlet weak var currentAvailablePoints: UILabel!
    
    
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

        // Do any additional setup after loading the view.
        navTitle.title = userName
        LifeTimePoints.text = "\(lifeTimePoints)"
        currentAvailablePoints.text = "\(avaialblePoints)"
        
        //add5.layer.borderWidth = 1
        //add5.layer.borderColor = UIColor.whiteColor().CGColor
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
