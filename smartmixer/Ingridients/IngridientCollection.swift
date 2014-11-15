//
//  MaterialCollection.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-2.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit
import CoreData

class IngridientCollection: UICollectionViewController {
    
    //该导航需要设置的
    var NavigationController:UINavigationController!
    
    var CatagoryId:Int = 0
    
    var icollectionView:UICollectionView!
    
    @IBOutlet var navtitle:UINavigationItem!
    
    var catagoryName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(navtitle != nil){
            navtitle.title = catagoryName
        }
        
        if(exdeviceName == ""){
            //添加向右滑动返回
            var slideback = UISwipeGestureRecognizer(target: self, action: "SwipeToBack:")
            slideback.direction = UISwipeGestureRecognizerDirection.Right
            self.view.addGestureRecognizer(slideback)
            self.view.userInteractionEnabled = true
        }
    }
    
    func SwipeToBack(sender:UISwipeGestureRecognizer){
        self.NavigationController?.popViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.NavigationController?.popViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
    }
    
    func reloadData(){
        _fetchedResultsController = nil
        icollectionView.reloadData()
    }
    
    //处理向下向上滚动影藏控制栏
    var lastPos:CGFloat = 0
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        lastPos = scrollView.contentOffset.y
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if(exdeviceName != "" || CatagoryId==0){
            var off = scrollView.contentOffset.y
            if((off-lastPos)>50 && off>50){//向下了
                lastPos = off
                rootController.showOrhideToolbar(false)
            }else if((lastPos-off)>50){
                lastPos = off
                rootController.showOrhideToolbar(true)
            }
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var materials = UIStoryboard(name:"Ingridients"+exdeviceName,bundle:nil).instantiateViewControllerWithIdentifier("ingridientDetail") as IngridientDetail
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as Ingridient
        materials.ingridient=item
        self.NavigationController.pushViewController(materials, animated: true)
        if(exdeviceName != ""){//ipad
            rootController.showOrhideToolbar(false)
        }
    }
    
    
   override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        icollectionView = collectionView
        let sectionInfo = self.fetchedResultsController.sections as [NSFetchedResultsSectionInfo]
        let item = sectionInfo[section]
        return item.numberOfObjects
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("ingridientThumb", forIndexPath: indexPath) as IngridientThumb
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as Ingridient
        cell.SetContentData(item)
        
        if(CatagoryId==0){
            cell.collection = self;
        }
        
        return cell
    }
    
    var fetchedResultsController: NSFetchedResultsController {
        
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
            }
            
            let fetchRequest = NSFetchRequest()
            // Edit the entity name as appropriate.
            let entity = NSEntityDescription.entityForName("Ingridient", inManagedObjectContext: managedObjectContext)
            fetchRequest.entity = entity
            
            // Set the batch size to a suitable number.
            fetchRequest.fetchBatchSize = 30
            
            // Edit the sort key as appropriate.
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            let sortDescriptors = [sortDescriptor]
            
            fetchRequest.sortDescriptors = sortDescriptors
            
            var conditionStr:String
            if(CatagoryId==0){
                conditionStr = "iHave == true "
            }else{
                conditionStr = "categoryId == \(CatagoryId) "
            }
            var condition = NSPredicate(format: conditionStr)
            fetchRequest.predicate = condition
            
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            //aFetchedResultsController.delegate = self
            _fetchedResultsController = aFetchedResultsController
            
            var error: NSError? = nil
            if !_fetchedResultsController!.performFetch(&error) {
                abort()
            }
            
            return _fetchedResultsController!
    }
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    
}
