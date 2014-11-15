//
//  RecipeDetailPhone.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/15.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit
import CoreData

class RecipeDetailPhone: UIViewController {
    
    var CurrentData:Recipe!
    
    //大图
    @IBOutlet var image:UIImageView?
    
    //名字
    @IBOutlet var name:UILabel?
    
    //英文名字
    @IBOutlet var nameEng:UILabel?
    
    //是否收藏
    @IBOutlet var faver:UIImageView?
    
    //描述
    @IBOutlet var desc:UITextView?
    
    //口感
    @IBOutlet var property:UISegmentedControl!
    
    //酒精度
    @IBOutlet var alchol:UILabel?
    
    //描述的高度
    @IBOutlet var hDesc: NSLayoutConstraint?
    
    //主框架的高度
    @IBOutlet var hMainboard: NSLayoutConstraint?
    
    //难度
    @IBOutlet var stars:Stars?
    
    @IBOutlet var scrollview:UIScrollView?
    
    @IBOutlet var navTitle:UINavigationItem!
    
    @IBOutlet var ingridientView:UIView!
    
    //显示详细的窗口
    var popview:PopupView! = nil
    
    var moresize:CGFloat = 0
    
    override func viewDidLoad() {
        rootController.showOrhideToolbar(false)
        super.viewDidLoad()
        //添加向右滑动返回
        var slideback = UISwipeGestureRecognizer(target: self, action: "SwipeToBack:")
        slideback.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(slideback)
        self.view.userInteractionEnabled = true
        var left = UIBarButtonItem(title: "开始制作>", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("toCook:"))
        self.navigationItem.rightBarButtonItem = left
        if(CurrentData != nil){
            self.image?.image = UIImage(named: CurrentData.largePhoto)
            self.name?.text = "\(CurrentData.name)"
            if(navTitle != nil){
                navTitle.title = "\(CurrentData.name)"
            }
            self.nameEng?.text = "\(CurrentData.nameEng)"
            if(CurrentData.isFav == true){
                self.faver?.image = UIImage(named: "Heartyes.png")
            }else{
                self.faver?.image = UIImage(named: "Heartno.png")
            }
            
            self.desc?.text = CurrentData.des
            
            property.removeAllSegments()
            if(CurrentData.taste == 0){
                property.insertSegmentWithTitle("甜味", atIndex: 0, animated: false)
            }else if(CurrentData.taste == 1){
                property.insertSegmentWithTitle("中味", atIndex: 0, animated: false)
            }else if(CurrentData.taste == 2){
                property.insertSegmentWithTitle("辣味", atIndex: 0, animated: false)
            }
            if(CurrentData.skill == 0){
                property.insertSegmentWithTitle("兑和", atIndex: 1, animated: false)
            }else if(CurrentData.skill == 1){
                property.insertSegmentWithTitle("摇和", atIndex: 1, animated: false)
            }else if(CurrentData.skill == 2){
                property.insertSegmentWithTitle("调和", atIndex: 1, animated: false)
            }else if(CurrentData.skill == 3){
                property.insertSegmentWithTitle("搅和", atIndex: 1, animated: false)
            }else{
                property.insertSegmentWithTitle("漂浮", atIndex: 1, animated: false)
            }
            if(CurrentData.drinktime == 0){
                property.insertSegmentWithTitle("餐前", atIndex: 2, animated: false)
            }else if(CurrentData.drinktime == 1){
                property.insertSegmentWithTitle("餐后", atIndex: 2, animated: false)
            }else if(CurrentData.drinktime == 2){
                property.insertSegmentWithTitle("全天", atIndex: 2, animated: false)
            }
            
            self.alchol?.text = "\(CurrentData.alcohol)°"
            self.stars?.value = Int(CurrentData.difficulty)
        }
        
        if(ingridientView != nil){
            recipeIngridients = UIStoryboard(name: "Recipes", bundle: nil).instantiateViewControllerWithIdentifier("recipeIngridients") as RecipeIngridients
            recipeIngridients.recipeId = Int(CurrentData.id)
            recipeIngridients.view.frame = CGRect(origin: CGPoint(x: 0, y: 34), size: recipeIngridients.size)
            ingridientView.addSubview(recipeIngridients.view)
            
        }
        
    }
    
    var recipeIngridients:RecipeIngridients!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var str:String = CurrentData.des
        var size = str.textSizeWithFont(self.desc!.font!, constrainedToSize: CGSize(width:304, height:1000))
        if(size.height>82){
            size.height = 82
        }
        self.hMainboard!.constant = 178 + size.height
        self.hDesc!.constant = size.height + 28
        self.view.layoutIfNeeded()
    }
    
    var stepnum:Int = 0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stepHeight.constant = CGFloat(stepnum * 44 + 40)
        scrollHeight.constant = CGFloat(stepnum * 44)
        scrollview!.contentSize = CGSize(width: scrollview!.contentSize.width, height: CGFloat(1320+stepnum*44))
        self.view.layoutIfNeeded()
    }
    
    @IBOutlet var scrollHeight:NSLayoutConstraint!
    
    @IBOutlet var stepHeight:NSLayoutConstraint!
    
    @IBOutlet var stepScrollView:UIScrollView!
    
    //告知窗口现在有多少个item需要添加
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        let sectionInfo = self.fetchedStepsController.sections as [NSFetchedResultsSectionInfo]
        let item = sectionInfo[section]
        stepnum = item.numberOfObjects
        return stepnum
    }
    
    //处理单个View的添加
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var tableCell :CookingStepCell = tableView.dequeueReusableCellWithIdentifier("stepCell") as CookingStepCell
        let item = self.fetchedStepsController.objectAtIndexPath(indexPath) as RecipeStep
        tableCell.stepInfo.text = "\((indexPath.row+1)). "+item.stepInfo
        return tableCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //显示所有的文字
    @IBAction func showAllText(sender:UIButton){
        if(hMainboard?.constant == 260){
            var str:String = desc!.text!
            var size = str.textSizeWithFont(desc!.font!, constrainedToSize: CGSize(width:304, height:1000))
            if(size.height > (hDesc!.constant-28)){
                /**/
                UIView.animateWithDuration(0.4, animations: {
                    self.hMainboard!.constant = 178 + size.height;
                    self.hDesc!.constant = size.height + 28;
                    self.view.layoutIfNeeded();
                    }, completion: { _ in
                        sender.titleLabel!.text = "《收起";
                })
                /**/
            }
        }else{
            /**/
            UIView.animateWithDuration(0.4, animations: {
                self.hMainboard!.constant = 260
                self.hDesc!.constant = 110
                self.view.layoutIfNeeded()
                }, completion: { _ in
                    sender.titleLabel!.text = "全部》"
            })
            /**/
        }
    }
    
    @IBAction func clickFaver(sender:UIButton){
        CurrentData.isFav = CurrentData!.isFav
        var error: NSError? = nil
        if !managedObjectContext.save(&error) {
            abort()
        }
        if(CurrentData.isFav == true){
            self.faver?.image = UIImage(named: "Heartyes.png")
        }else{
            self.faver?.image = UIImage(named: "Heartno.png")
        }
    }
    
    func SwipeToBack(sender:UISwipeGestureRecognizer){
        self.navigationController?.popViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
        rootSideMenu.needSwipeShowMenu = true
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
        rootSideMenu.needSwipeShowMenu = true
    }
    
    
    //点击去制作
    @IBAction func toCook(sender:UIButton){
    }
    
    //详情的分类
    var fetchedStepsController: NSFetchedResultsController {
        if (_fetchedStepsController != nil) {
            return _fetchedStepsController!
            }
            let fetchRequest = NSFetchRequest()
            let entity = NSEntityDescription.entityForName("RecipeStep", inManagedObjectContext: managedObjectContext)
            fetchRequest.entity = entity
            let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            var condition = NSPredicate(format: "recipeId == \(CurrentData.id)")
            fetchRequest.predicate = condition
            let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            _fetchedStepsController = aFetchedResultsController
            var error: NSError? = nil
            if !_fetchedStepsController!.performFetch(&error) {
                abort()
            }
            return _fetchedStepsController!
    }
    
    var _fetchedStepsController: NSFetchedResultsController? = nil
    
}
