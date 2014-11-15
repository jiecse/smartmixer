//
//  Materials.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-20.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit
import CoreData

class Ingridients: UIViewController , NSFetchedResultsControllerDelegate {
    
    @IBOutlet var itableView:UITableView?
    
    @IBOutlet var materialContainer:UIView?
    
    var ingridientCollection:IngridientCollection? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: managedObjectContext) as Category
        
        entity.name="兰姆酒"
        entity.id=200
        entity.type = 1
        entity.nameEng = "Rums"
        entity.thubmnailPhoto = "i-tequila.jpg"
        
        var error: NSError? = nil
        if !managedObjectContext.save(&error) {
        abort()
        }
        **/
        if(exdeviceName != ""){
            ingridientCollection = self.childViewControllers[0] as? IngridientCollection
            ingridientCollection?.NavigationController = self.navigationController
        }
        if(self.fetchedResultsController.fetchedObjects?.count>0){
            var index = NSIndexPath(forRow: 0, inSection: 0)
            let item = self.fetchedResultsController.objectAtIndexPath(index) as Category
            itableView!.selectRowAtIndexPath(index, animated: false, scrollPosition: UITableViewScrollPosition.Top)
            ingridientCollection?.CatagoryId = Int(item.id)
        }
        
        itableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //告知窗口现在有多少个item需要添加
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        let sectionInfo = (self.fetchedResultsController.sections as [NSFetchedResultsSectionInfo])[section]
        return sectionInfo.numberOfObjects
    }
    
    //处理单个View的添加
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as Category
        
        var tableCell :IngridientClassCell = tableView.dequeueReusableCellWithIdentifier("ingridientClassCell") as IngridientClassCell
        tableCell.title.text = item.name
        tableCell.title_eng.text = item.nameEng
        tableCell.tag = Int(item.id)
        tableCell.thumb.image = UIImage(named: item.thubmnailPhoto)
        tableCell.selectedBackgroundView = UIView(frame: tableCell.frame)
        tableCell.selectedBackgroundView.backgroundColor = UIColor.whiteColor()
        tableCell.title.highlightedTextColor = UIColor.redColor()
        tableCell.title_eng.highlightedTextColor = UIColor.redColor()
        return tableCell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as IngridientClassCell
        if(exdeviceName == ""){
            ingridientCollection = UIStoryboard(name: "Ingridients", bundle: nil).instantiateViewControllerWithIdentifier("ingridientCollection") as? IngridientCollection
            ingridientCollection?.NavigationController = self.navigationController
            ingridientCollection!.CatagoryId = cell.tag
            ingridientCollection!.catagoryName = cell.title.text!
            self.navigationController?.pushViewController(ingridientCollection!, animated: true)
            rootController.showOrhideToolbar(false)
        }else{
            ingridientCollection!.CatagoryId = cell.tag
            ingridientCollection!.catagoryName = cell.title.text!
            ingridientCollection!.reloadData()
        }
    }
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
            }
            
            let fetchRequest = NSFetchRequest()
            // Edit the entity name as appropriate.
            let entity = NSEntityDescription.entityForName("Category", inManagedObjectContext: managedObjectContext)
            fetchRequest.entity = entity
            
            // Set the batch size to a suitable number.
            fetchRequest.fetchBatchSize = 30
            
            // Edit the sort key as appropriate.
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            let sortDescriptors = [sortDescriptor]
            
            fetchRequest.sortDescriptors = sortDescriptors
            
            var condition = NSPredicate(format: "type == 1")
            fetchRequest.predicate = condition
            
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            aFetchedResultsController.delegate = self
            _fetchedResultsController = aFetchedResultsController
            
            var error: NSError? = nil
            if !_fetchedResultsController!.performFetch(&error) {
                abort()
            }
            
            return _fetchedResultsController!
    }
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
}
