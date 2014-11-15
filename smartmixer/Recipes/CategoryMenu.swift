//
//  SideMenuControllerTableViewController.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/21.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit
import CoreData

class CategoryMenu: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var delegate:NumberDelegate!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = (self.fetchedResultsController.sections as [NSFetchedResultsSectionInfo]) [section]
        return sectionInfo.numberOfObjects+1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var categoryCell :CategoryCell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as CategoryCell
        categoryCell.backgroundColor = UIColor.clearColor()
        var newview = RadiusView(frame: categoryCell.frame)
        newview.backgroundColor = UIColor.clearColor()
        categoryCell.selectedBackgroundView = newview
        categoryCell.cellname.highlightedTextColor = UIColor(red: 241/255, green: 77/255, blue: 66/255, alpha: 1)
        if(indexPath.row==0 && indexPath.section==0){
            categoryCell.cellname.text = "全部 All"
            categoryCell.tag = 0
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Top)
        }else{
            var index = NSIndexPath(forRow: indexPath.row-1, inSection: indexPath.section)
            let item = self.fetchedResultsController.objectAtIndexPath(index) as Category
            categoryCell.cellname.text = "\(item.name) \(item.nameEng)"
            categoryCell.tag = Int(item.id)
        }

        return categoryCell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        if(self.delegate != nil){
            self.delegate.NumberAction(self, num: cell.tag)
        }
        if (rootSideMenu != nil){
            rootSideMenu.hideSideViewController()
        }
    }
    
    
    //下载分类的
    var fetchedResultsController: NSFetchedResultsController {
        if (_fetchedResultsController != nil) {
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
            
            var condition = NSPredicate(format: "type = 0")
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
    /**/
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
