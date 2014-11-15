//
//  RecipesCollection.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-1.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit
import CoreData

class RecipesCollection: UIViewController,UIScrollViewDelegate {

    //搜索参数设置部分
    var recipesSearch:RecipesSearch! = nil
    
    //当前的选中分类
    var catagorySearch:Int! = 0
    
    @IBOutlet var icollectionView:UICollectionView!
    
    //没有找到数据
    @IBOutlet var nodataFind:UILabel!
    
    //没有数据时的提示文字
    var nodataTip:String = ""
    
    //该导航需要设置的
    weak var NavigationController:UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(nodataTip != "" && nodataFind != nil){
            nodataFind.text = nodataTip
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if (motion == UIEventSubtype.MotionShake) {
            let sectionInfo = self.fetchedItemsController.sections as [NSFetchedResultsSectionInfo]
            let item = sectionInfo[0]
            var totle:UInt32 = UInt32(item.numberOfObjects)
            let num = arc4random_uniform(totle)
            var indexPath = NSIndexPath(forRow: Int(num), inSection: 0)
            if(exdeviceName == ""){
                var recipeDetail = UIStoryboard(name: "Recipes", bundle: nil).instantiateViewControllerWithIdentifier("recipeDetail") as RecipeDetailPhone
                recipeDetail.CurrentData = self.fetchedItemsController.objectAtIndexPath(indexPath) as Recipe
                self.NavigationController.pushViewController(recipeDetail, animated: true)
            }else{
                var recipeDetail = UIStoryboard(name: "Recipes"+exdeviceName, bundle: nil).instantiateViewControllerWithIdentifier("recipeDetail") as RecipeDetailPad
                recipeDetail.CurrentData = self.fetchedItemsController.objectAtIndexPath(indexPath) as Recipe
                self.NavigationController.pushViewController(recipeDetail, animated: true)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.resignFirstResponder()
        super.viewWillAppear(animated)
        
    }
    
    func ScrollToHide(sender:UISwipeGestureRecognizer){
        if(sender.direction == UISwipeGestureRecognizerDirection.Up){
            rootController.showOrhideToolbar(false)
        }else if(sender.direction == UISwipeGestureRecognizerDirection.Up){
            rootController.showOrhideToolbar(true)
        }
    }
    
    func ReloadData(){
        _fetchedItemsController = nil
        icollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //处理向下向上滚动影藏控制栏
    var lastPos:CGFloat = 0
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        lastPos = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var off = scrollView.contentOffset.y
        if((off-lastPos)>50 && off>50){//向下了
            lastPos = off
            rootController.showOrhideToolbar(false)
        }else if((lastPos-off)>50){
            lastPos = off
            rootController.showOrhideToolbar(true)
        }
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedItemsController.sections as [NSFetchedResultsSectionInfo]
        let item = sectionInfo[section]
        if(item.numberOfObjects==0){
            nodataFind.hidden=false
        }else{
            nodataFind.hidden=true
        }
        return item.numberOfObjects
    }

    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var viewCell = collectionView.dequeueReusableCellWithReuseIdentifier("recipe-thumbnail", forIndexPath: indexPath) as RecipeThumbail
        let item = self.fetchedItemsController.objectAtIndexPath(indexPath) as Recipe
        viewCell.SetDataContent(item)
        if(recipesSearch == nil){
            viewCell.collection = icollectionView
        }
        return viewCell
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        rootSideMenu.needSwipeShowMenu = false
        if(exdeviceName == ""){
            var recipeDetail = UIStoryboard(name: "Recipes", bundle: nil).instantiateViewControllerWithIdentifier("recipeDetail") as RecipeDetailPhone
            recipeDetail.CurrentData = self.fetchedItemsController.objectAtIndexPath(indexPath) as Recipe
            self.NavigationController.pushViewController(recipeDetail, animated: true)
        }else{
            var recipeDetail = UIStoryboard(name: "Recipes"+exdeviceName, bundle: nil).instantiateViewControllerWithIdentifier("recipeDetail") as RecipeDetailPad
            recipeDetail.CurrentData = self.fetchedItemsController.objectAtIndexPath(indexPath) as Recipe
            self.NavigationController.pushViewController(recipeDetail, animated: true)
        }
    }
    
    
    //详情的分类
    var fetchedItemsController: NSFetchedResultsController {
        if (_fetchedItemsController != nil) {
            return _fetchedItemsController!
            }
            
            let fetchRequest = NSFetchRequest()
            // Edit the entity name as appropriate.
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: managedObjectContext)
            fetchRequest.entity = entity
            
            // Set the batch size to a suitable number.
            //fetchRequest.fetchBatchSize = 30
            
            // Edit the sort key as appropriate.
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            let sortDescriptors = [sortDescriptor]
            
            fetchRequest.sortDescriptors = sortDescriptors
            
            var conditionStr = ""
            if(recipesSearch != nil){//这里是主界面的调用
                if(recipesSearch.keyWord != ""){
                    conditionStr = "(name CONTAINS '\(recipesSearch.keyWord)' OR nameEng CONTAINS '\(recipesSearch.keyWord)') AND "
                }
                //口感部分
                var conditionSeg:String = ""
                for var tag:Int = 0; tag<recipesSearch.keyTaste.count ;tag+=1 {
                    if(recipesSearch.keyTaste[tag] == true){
                        conditionSeg += " taste==\(tag) or"
                    }
                }
                if(conditionSeg != ""){
                    conditionSeg = conditionSeg.substringToIndex(advance(conditionSeg.startIndex, countElements(conditionSeg)-3))
                    conditionStr += "(\(conditionSeg)) AND "
                }
                //技巧部分
                conditionSeg = ""
                for var tag:Int = 0; tag<recipesSearch.keySkill.count ;tag+=1 {
                    if(recipesSearch.keySkill[tag] == true){
                        conditionSeg += " skill==\(tag) or"
                    }
                }
                if(conditionSeg != ""){
                    conditionSeg = conditionSeg.substringToIndex(advance(conditionSeg.startIndex, countElements(conditionSeg)-3))
                    conditionStr += "(\(conditionSeg)) AND "
                }
                
                //引用时间部分
                conditionSeg = ""
                for var tag:Int = 0; tag<recipesSearch.keyDrinkTime.count ;tag+=1 {
                    if(recipesSearch.keyDrinkTime[tag] == true){
                        conditionSeg += " drinktime==\(tag) or"
                    }
                }
                if(conditionSeg != ""){
                    conditionSeg = conditionSeg.substringToIndex(advance(conditionSeg.startIndex, countElements(conditionSeg)-3))
                    conditionStr += "(\(conditionSeg)) AND "
                }
                
                //
                if(catagorySearch != 0){
                    conditionStr += "type ==\(catagorySearch) AND "
                }
                
                conditionStr += "alcohol<=\(recipesSearch.keyAlcohol) AND "
                
                conditionStr += "difficulty<=\(recipesSearch.keyDifficulty)"
                
                
            } else {//这里是用户部分的调用
                if(catagorySearch == 0){ //我的收藏
                    conditionStr += "isFav == true "
                }else{//调制历史
                    conditionStr += "cooktimes > 0 "
                }
            }
            
            var condition = NSPredicate(format: conditionStr)
            fetchRequest.predicate = condition
            
            
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            //aFetchedResultsController.delegate = self
            _fetchedItemsController = aFetchedResultsController
            
            var error: NSError? = nil
            if !_fetchedItemsController!.performFetch(&error) {
                abort()
            }
            
            return _fetchedItemsController!
    }
    
    var _fetchedItemsController: NSFetchedResultsController? = nil

}
