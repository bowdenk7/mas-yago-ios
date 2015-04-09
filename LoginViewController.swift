//
//  LoginViewController.swift
//  Yago
//
//  Created by Saim Jafar on 2/24/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, FBLoginViewDelegate {
    
    @IBOutlet var fbLoginView : FBLoginView!
    @IBOutlet weak var ageConfirmView: UIView!
    @IBOutlet weak var ageDisclaimerView: UIView!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    
    //Show Login with Facebook button
    @IBAction func yesButtonPress(sender: AnyObject) {
        ageConfirmView.hidden = true
        fbLoginView.hidden = false
    }
    
    //Show text explaining you must be 21 to use this app.
    @IBAction func noButtonPress(sender: AnyObject) {
        ageConfirmView.hidden = true
        ageDisclaimerView.hidden = false
    }

    
    //Disclaimer acknowledged, show 21 confirmation again.
    @IBAction func okButtonPress(sender: AnyObject) {
        ageDisclaimerView.hidden = true
        ageConfirmView.hidden = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLoginView.delegate = self;
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        // Do any additional setup after loading the view.
    }
    
    //Facebook Delegate messages
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        self.performSegueWithIdentifier("UserAuthenticated", sender: nil)
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
        
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("User logged out")
    }
    
    func loginView(loginView: FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
