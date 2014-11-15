//
//  ContainerRoot.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-16.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit
import CoreData

class ContainerRoot: UIViewController , NSFetchedResultsControllerDelegate{
    
    
    //定义的接口变量
    @IBOutlet var tableView : UITableView!
    
    //容器详细
    var containerDetail:ContainerDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(exdeviceName != ""){
            containerDetail = self.childViewControllers[0] as? ContainerDetail
            let objects = self.fetchedResultsController.fetchedObjects as [Container]
            if(objects.count>0){
                tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Top)
            }
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //告知窗口现在有多少个item需要添加
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        let sectionInfo = self.fetchedResultsController.sections as [NSFetchedResultsSectionInfo]
        let item = sectionInfo[section]
        return item.numberOfObjects
    }
    
    //处理单个View的添加
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        
        var tableCell :ContainerItem = tableView.dequeueReusableCellWithIdentifier("containerItem") as ContainerItem
        
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as Container
        tableCell.name.text = "\(item.name)"
        tableCell.nameEng.text = "\(item.nameEng)"
        tableCell.tag = Int(item.id)
        tableCell.thumb.image = UIImage(named: item.largePhoto)
        var newview = RadiusView(frame: tableCell.frame)
        newview.backgroundColor = UIColor.whiteColor()
        tableCell.selectedBackgroundView = newview
        tableCell.name.highlightedTextColor = UIColor.redColor()
        tableCell.nameEng.highlightedTextColor = UIColor.redColor()
        
        if(indexPath.row == 0 && indexPath.section == 0 && exdeviceName != ""){
            containerDetail.SetDetailInfo(item)
        }
        return tableCell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as Container
        if(exdeviceName == ""){
            containerDetail = UIStoryboard(name: "Containers", bundle: nil).instantiateViewControllerWithIdentifier("containerDetail") as ContainerDetail
            containerDetail.CurrentContainer=item
            self.navigationController?.pushViewController(containerDetail, animated: true)
            rootController.showOrhideToolbar(false)
        }else{
            containerDetail.SetDetailInfo(item)
        }
    }
    
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
            }
            
            let fetchRequest = NSFetchRequest()
            // Edit the entity name as appropriate.
            let entity = NSEntityDescription.entityForName("Container", inManagedObjectContext: managedObjectContext)
            fetchRequest.entity = entity
            
            // Set the batch size to a suitable number.
            fetchRequest.fetchBatchSize = 20
            
            // Edit the sort key as appropriate.
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            let sortDescriptors = [sortDescriptor]
            
            fetchRequest.sortDescriptors = sortDescriptors
            
            // Edit the section name key path and cache name if appropriate.
            // nil for section name key path means "no sections".
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            aFetchedResultsController.delegate = self
            _fetchedResultsController = aFetchedResultsController
            
            var error: NSError? = nil
            if !_fetchedResultsController!.performFetch(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
            
            return _fetchedResultsController!
    }
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    
}

