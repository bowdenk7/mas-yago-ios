//
//  BarFeedViewController.swift
//  Yago
//
//  Created by Christopher O'Brien on 3/25/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit

class BarFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var API_BASE_URL = "http://yago-stage.herokuapp.com/"
    
    var barFeedArray: [PostModel] = []
    
    var currentBar: String!
    
    var barId : Int? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("barId") as? Int
        }
    }
    
    func getPosts(barId: Int) {
        var barFeedResults:[PostModel] = []
        let manager = AFHTTPRequestOperationManager()
        manager.GET( API_BASE_URL + "feed/bar_feed/\(barId)",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if let items = responseObject as? NSArray {
                    for item in items {
                        var feedItem:PostModel = PostModel(imageUrl: item["image_url"] as String,
                            likes: item["like__count"] as Int,
                            id: item["id"] as Int)
                        
                        println(item["image_url"])
                        barFeedResults += [feedItem]
                    }
                }
                self.barFeedArray = barFeedResults
                self.collectionView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getPosts(barId!)
        self.title = "Some Bar" //TODO fix this, request bar info or pass from last view
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
    
    
    //UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return barFeedArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        var cell:BarFeedViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("bar", forIndexPath: indexPath) as BarFeedViewCell
        
        //Configuring collection cell
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor .grayColor().CGColor
        
        //Grab what's in the array and set image
        let thisItem = barFeedArray[indexPath.row] as PostModel
        let url = NSURL(string: thisItem.imageUrl.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)!)
        let data = NSData(contentsOfURL: url!)
        cell.withinBarImage.image = UIImage(data: data!)
        cell.likeCount.text = String(thisItem.likes)
        
        return cell
    }


}
