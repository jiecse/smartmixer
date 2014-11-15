//
//  RecipeDetailController.swift
//  smartmixer
//
//  Created by Koulin Yuan on 8/23/14.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

import UIKit
import CoreData

class RecipeDetailPad : UIViewController {
    
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
    @IBOutlet var taste:UISegmentedControl?
    
    //技巧
    @IBOutlet var skill:UISegmentedControl?
    
    //时间段
    @IBOutlet var drinkTime:UISegmentedControl?
    
    //酒精度
    @IBOutlet var alchol:UIProgressView?
    @IBOutlet var alcohol:UILabel?
    
    //描述的高度
    @IBOutlet var hDesc: NSLayoutConstraint?
    //主框架的高度
    @IBOutlet var hMainboard: NSLayoutConstraint?
    //主框架
    @IBOutlet var parentView:UIView?
    
    //难度
    @IBOutlet var stars:Stars?
    
    @IBOutlet var navTitle:UINavigationItem!
    
    @IBOutlet var showBt:UIButton!
    
    //显示详细的窗口
    var popview:PopupView! = nil
    
    var moresize:CGFloat = 0
    
    override func viewDidLoad() {
        rootController.showOrhideToolbar(false)
        super.viewDidLoad()
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
            var size = CurrentData.des.textSizeWithFont(self.desc!.font!, constrainedToSize: CGSize(width:314, height:1000))
            if(size.height<146){
                showBt.hidden = true
            }
            self.desc?.text = CurrentData.des
            self.taste?.selectedSegmentIndex = Int(CurrentData.taste)
            self.skill?.selectedSegmentIndex = Int(CurrentData.skill)
            self.drinkTime?.selectedSegmentIndex = Int(CurrentData.drinktime)
            self.alchol?.progress = Float(CurrentData.alcohol)/100
            self.alcohol?.text = "\(CurrentData.alcohol)°"
            self.stars?.value = Int(CurrentData.difficulty)
        }
        if(popview == nil){
            popview = PopupView(frame:CGRect(x: 200, y: 10, width: 600, height: 500))
            popview?.parentView = self.view
            popview?.hidden = true
            popview.arrorDirection = ArrorDirection.right
            self.view.addSubview(popview!)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    var recipeIngridients:RecipeIngridients!=nil
    
    //显示材料信息
    @IBAction func showIngridient(sender:UIButton){
        if(popview.hidden == true){
            if(recipeIngridients == nil){
                recipeIngridients = UIStoryboard(name: "Recipes_ipad", bundle: nil).instantiateViewControllerWithIdentifier("recipeIngridients") as RecipeIngridients
                recipeIngridients.recipeId = Int(CurrentData.id)
            }
            if(popview?.currentView != recipeIngridients.view){
                recipeIngridients.view.frame = CGRect(origin: CGPoint(), size: recipeIngridients.ViewSize)
            }
            popview?.showNewView(recipeIngridients.view, pointToItem: sender)
        }else {
            popview.closeView(sender)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ShowAllTextPad(sender:UIButton){
        if(hMainboard?.constant == 300){
            var str:String = desc!.text!
            var size = str.textSizeWithFont(desc!.font!, constrainedToSize: CGSize(width:314, height:1000))
            if(size.height > (hDesc!.constant-28)){
                UIView.animateWithDuration(0.4, animations: {
                    self.hMainboard!.constant = 104 + size.height;
                    self.hDesc!.constant = size.height + 28;
                    self.parentView!.layoutIfNeeded();
                    }, completion: { _ in
                        sender.titleLabel!.text = "《收起";
                })
            }
        }else{
            UIView.animateWithDuration(0.4, animations: {
                self.hMainboard!.constant = 300
                self.hDesc!.constant = 166
                self.parentView!.layoutIfNeeded()
                }, completion: { _ in
                    sender.titleLabel!.text = "全部》"
            })
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
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
    }
    
    //点击去制作
    @IBAction func toCook(sender:UIButton){
    }
}

