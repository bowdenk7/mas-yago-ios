//
//  BarFeedViewController.swift
//  Yago
//
//  Created by Christopher O'Brien on 3/25/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

import UIKit

class BarFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var BarFeedCollection: UICollectionView!
    
    let agos = ["1hr", "2hr", "3hr", "4hr", "5hr"]
    let likes = [ "12", "7", "6", "13", "15" ]
    let pictureIDs = ["1", "2", "3", "4", "5"]
    
    var currentBar: String!
    
    var barName : AnyObject? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("barName")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentBar = barName as String
        self.title = currentBar
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
        return likes.count
        //return districtFeedArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        var cell:BarFeedViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("bar", forIndexPath: indexPath) as BarFeedViewCell
        
        //Configuring collection cell
        var imageID:String = currentBar  + pictureIDs[indexPath.row]
        cell.timestamp.text = agos[indexPath.row]
        cell.withinBarImage.image = UIImage(named: imageID)
        cell.likeCount.text = likes[indexPath.row]
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor .grayColor().CGColor
        
        
        /*Grab what's in the array and set image
        let thisItem = districtFeedArray[indexPath.row]
        cell.barImage.image = UIImage(data: thisItem.image)
        cell.barNameLabel.text = thisItem.caption
        return cell
        */
        
        return cell
    }


}
