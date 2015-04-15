//
//  LoginViewController.swift
//  Yago
//
//  Created by Chad Collins on 2/24/15.
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
    
    func facebookAuthWithAccessToken(token: String) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        var params : Dictionary = ["access_token": token]
        println("Posting auth request")
        manager.POST( API_BASE_URL + "account/authenticate_with_token/",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("Authenticated!")
                println(responseObject)
                self.performSegueWithIdentifier("UserAuthenticated", sender: nil)
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }

    
    //Facebook Delegate messages
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("Facebook Access Token Received")
        var accessToken = FBSession.activeSession().accessTokenData.accessToken
        facebookAuthWithAccessToken(accessToken)
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        
        
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
