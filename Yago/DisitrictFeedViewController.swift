//
//  MapViewController.swift
//  Yago
//
//  Created by Bowden Kelly on 3/7/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

class DistrictFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var currentDistrict: String!
    
    //Static bar names within a district
    //var districtFeedArray: [AnyObject] = []
    let venues = [
        ("Pool Hall"),
        ("Red Door Tavern"),
        ("Dive Bar"),
        ("Buckhead Saloon"),
        ("The Ivy"),
        ("Fado Irish Pub"),
        ("The Southern Gentleman"),
        ("Bucket Shop Cafe"),
    ]
    
    //Hack to pass current bar selected
    var barName : AnyObject? {
        get{
            return NSUserDefaults.standardUserDefaults().objectForKey("barName")
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "barName")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    @IBOutlet weak var districtViewCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(currentDistrict) Venues"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UICollectionViewDataSource Protocol
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
        //return districtFeedArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        var cell:DistrictFeedViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("district", forIndexPath: indexPath) as DistrictFeedViewCell
        
        //Setting contents of custom cell
        let barName = venues[indexPath.row]
        cell.barNameLabel.text = barName
        var myImage = UIImage(named: barName)
        cell.barImage.image = UIImage(named: barName)
        
        //Just borders to make cell look neat
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor .grayColor().CGColor
        
        /*Grab what's in the array and set image and bar name
        let thisItem = districtFeedArray[indexPath.row]
        cell.barImage.image = UIImage(data: thisItem.image)
        cell.barNameLabel.text = thisItem.caption
        return cell
        */
        
        //Placeholder
        return cell
    }
    
    //This method is called everytime a cell is selected -> Use this to pass the current bar to the next screen
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        barName = venues[indexPath.row]
    }
    
    
    
    //Make Get Request
    func makeGETRequest (searchString: String) {
        //let url NSURL(string: <#String#>)
    }
    
    //If you need to pass something to the next screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextScene = segue.destinationViewController as BarFeedViewController
    }

    
}
