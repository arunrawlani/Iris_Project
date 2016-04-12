//
//  InspirationsViewController.swift
//  RWDevCon
//

import UIKit
import Alamofire
import SwiftyJSON

class InspirationsViewController: UICollectionViewController {
  
  let inspirations = Inspiration.allInspirations() //Create an inspiraton object using the data model 'Inspiration'
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent //changes styles of the status bar
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBarHidden = true //hides the navigation bar
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    collectionView!.backgroundColor = UIColor.clearColor()
    collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
  }

}

extension InspirationsViewController {
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
//forms the right amoutn of cells according to the Inspirations.plist file
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return inspirations.count
  }
  
//fills every cell according to the respective element information in the Inspirations.plist file
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InspirationCell", forIndexPath: indexPath) as! InspirationCell
    cell.inspiration = inspirations[indexPath.item]
    return cell
  }
  
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let layout = collectionViewLayout as! UltravisualLayout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
        else{
            let urlstored = NSURL(string: inspirations[indexPath.item].website);
            print(urlstored);
            if UIApplication.sharedApplication().canOpenURL(urlstored!) {
                UIApplication.sharedApplication().openURL(urlstored!)
            }
            
        }
    }

}