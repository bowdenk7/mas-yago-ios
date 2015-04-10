//
//  MapViewController.swift
//  Yago
//
//  Created by Bowden Kelly on 3/7/15.
//  Copyright (c) 2015 Team Socket Power. All rights reserved.
//

class DistrictFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentDistrict: DistrictModel!
    var currentBar: BarModel!
    var districtFeedArray: [BarModel] = []
    
    //Hack to pass current bar selected
    
    @IBOutlet weak var districtViewCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(currentDistrict.name) Venues"
        collectionView.registerClass(BarFeedViewCell.self, forCellWithReuseIdentifier: "PostCell")
        
        //TODO add request info here
        getBars(currentDistrict.id)
        
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
        //return venues.count
        return districtFeedArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        var cell:DistrictFeedViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("district", forIndexPath: indexPath) as DistrictFeedViewCell
        
        //Just borders to make cell look neat
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor .grayColor().CGColor
        
        //Grab what's in the array and set image and bar name
        let thisItem = districtFeedArray[indexPath.row] as BarModel
        let url = NSURL(string: thisItem.imageUrl)
        let data = NSData(contentsOfURL: url!)
        cell.barImage.image = UIImage(data: data!)
        cell.barNameLabel.text = thisItem.name
        return cell
    }
    
    //This method is called everytime a cell is selected -> Use this to pass the current bar to the next screen
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentBar = districtFeedArray[indexPath.row]
        self.performSegueWithIdentifier("BarFeedSelected", sender: nil)
    }
    
    func getBars(districtId: Int) {
        var districtFeedResults:[BarModel] = []
        let manager = AFHTTPRequestOperationManager()
        manager.GET( API_BASE_URL + "feed/top_district_feed/\(districtId)",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if let items = responseObject as? NSArray {
                    for item in items {
                        var feedItem:BarModel = BarModel(name: item["name"] as String,
                            imageUrl: item["logo_url"] as String,
                            id: item["pk"] as Int)
                        districtFeedResults += [feedItem]
                    }
                }
                self.districtFeedArray = districtFeedResults
                self.collectionView.reloadData()
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
    
    
    //If you need to pass something to the next screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BarFeedSelected" {
            let nextScene = segue.destinationViewController as BarFeedViewController
            nextScene.currentBar = currentBar
        }
    }

    
}
