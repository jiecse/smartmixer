//
//  ContainerDetail.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-19.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit
import CoreData

class ContainerDetail: UIViewController , UIGestureRecognizerDelegate , NSFetchedResultsControllerDelegate {
    
    //绑定缩略图
    @IBOutlet var image : UIImageView!
    
    //酒器的名字
    @IBOutlet var name : UILabel!
    
    //酒器的英文名字
    @IBOutlet var nameEng : UILabel!
    
    //酒器的描述
    @IBOutlet var desc : UITextView!
    
    //酒器是否已收藏
    @IBOutlet var collected : UIImageView!
    
    //宽度
    @IBOutlet weak var hCondition: NSLayoutConstraint?
    
    @IBOutlet var navTitle:UINavigationItem!
    
    @IBOutlet var contentScroll:UIScrollView!
    
    //当前的编辑对象
    var CurrentContainer:Container!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(exdeviceName == ""){
            //添加向右滑动返回
            var slideback = UISwipeGestureRecognizer(target: self, action: "SwipeToBack:")
            slideback.direction = UISwipeGestureRecognizerDirection.Right
            self.view.addGestureRecognizer(slideback)
            self.view.userInteractionEnabled = true
        }
        if(CurrentContainer != nil){
            if(navTitle != nil){
                navTitle.title = "\(CurrentContainer.name)"
            }
            name.text = "\(CurrentContainer.name)"
            nameEng.text = "\(CurrentContainer.nameEng)"
            desc.text = CurrentContainer.des
            if(CurrentContainer.possess == true){
                collected.image = UIImage(named: "Heartyes.png")
            }else{
                collected.image = UIImage(named: "Heartno.png")
            }
            if(self.hCondition != nil){
                var size = CurrentContainer.name.textSizeWithFont(name.font, constrainedToSize: CGSize(width:1000, height:36))
                self.hCondition?.constant = size.width
                
            }
            self.image.image = UIImage(named: self.CurrentContainer.largePhoto)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(self.contentScroll != nil){//iPhone的滚动
            var size = desc.text.textSizeWithFont(desc.font, constrainedToSize: CGSize(width:306, height:1000))
            contentScroll.contentSize = CGSize(width: 320, height: 500+size.height)
            self.view.layoutIfNeeded()
        }
    }
    
    func SwipeToBack(sender:UISwipeGestureRecognizer){
        self.navigationController?.popToRootViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
    }
    
    @IBAction func goback(sender : UIButton){
        self.navigationController?.popToRootViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
    }
    
    var ingridientStore:IngridientStore!
    
    @IBAction func tuBuy(sender: UIButton){
        ingridientStore=UIStoryboard(name:"Ingridients_ipad",bundle:nil).instantiateViewControllerWithIdentifier("ingridientStore") as IngridientStore
        self.navigationController?.pushViewController(ingridientStore, animated: true)
    }
    
    //点击收藏与取消收藏
    @IBAction func clickCollect (sender : UIButton){
        CurrentContainer.possess = CurrentContainer!.possess
        var error: NSError? = nil
        if !managedObjectContext.save(&error) {
            abort()
        }
        if(CurrentContainer.possess == true){
            collected.image = UIImage(named: "Heartyes.png")
        }else{
            collected.image = UIImage(named: "Heartno.png")
        }
    }
    
    func gestureRecognizer(UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            return true
    }
    
    //需要显示的Id值
    func SetDetailInfo(item:Container){
        CurrentContainer = item
        name.text = "\(CurrentContainer.name)"
        nameEng.text = "\(CurrentContainer.nameEng)"
        desc.text = CurrentContainer.des
        if(CurrentContainer.possess == true){
            collected.image = UIImage(named: "Heartyes.png")
        }else{
            collected.image = UIImage(named: "Heartno.png")
        }
        var size = CurrentContainer.name.textSizeWithFont(name.font, constrainedToSize: CGSize(width:1000, height:36))
        
        UIView.animateWithDuration(0.2,
            animations : {
                self.image.alpha = 0
                if(self.hCondition != nil){
                    self.hCondition?.constant = size.width
                    self.view.layoutIfNeeded()
                }
            },
            completion : {_ in
                self.image.image = UIImage(named: self.CurrentContainer.largePhoto)
                UIView.animateWithDuration(0.2, animations: { self.image.alpha = 1 })
        })
    }
}
