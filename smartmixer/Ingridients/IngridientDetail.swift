//
//  MaterialDetail.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-24.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

class IngridientDetail: UIViewController {
    
    @IBOutlet var image:UIImageView!
    
    @IBOutlet var myscrollView:UIScrollView!
    
    @IBOutlet var navtitle:UINavigationItem!
    
    @IBOutlet var name:UILabel!
    
    @IBOutlet var nameEng:UILabel!
    
    @IBOutlet var iHave:UIImageView!
    
    @IBOutlet var desc:UITextView!
    
    @IBOutlet var alcohol:UILabel!
    
    @IBOutlet var showBt:UIButton!
    
    //描述的高度
    @IBOutlet var hDesc: NSLayoutConstraint!
    
    //主框架的高度
    @IBOutlet var hMainboard: NSLayoutConstraint!
    
    //当前的材料
    var ingridient:Ingridient!
    
    override func viewDidLoad() {
        //self
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        if(ingridient != nil){
            navtitle.title = ingridient.name
            name.text = ingridient.name
            nameEng.text  = ingridient.nameEng
            if(ingridient.iHave == true){
                iHave.image = UIImage(named: "Heartyes.png")
            }else{
                iHave.image = UIImage(named: "Heartno.png")
            }
            desc.text = ingridient.desc
            var size = ingridient.desc.textSizeWithFont(self.desc!.font!, constrainedToSize: CGSize(width:300, height:1000))
            if(size.height<100){
                showBt.hidden = true
            }
            image.image = UIImage(named: ingridient.largePhoto)
        }
        if(exdeviceName == ""){
            //添加向右滑动返回
            var slideback = UISwipeGestureRecognizer(target:self, action: "SwipeToBack:")
            slideback.direction = UISwipeGestureRecognizerDirection.Right
            self.view.addGestureRecognizer(slideback)
            self.view.userInteractionEnabled = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(myscrollView != nil){
            myscrollView.contentSize = CGSize(width: 320, height: 700)
            self.view.layoutIfNeeded()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SwipeToBack(sender:UISwipeGestureRecognizer){
        self.navigationController?.popViewControllerAnimated(true)
        if(exdeviceName != ""){//ipad
            rootController.showOrhideToolbar(true)
        }
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        if(exdeviceName != ""){//ipad
            rootController.showOrhideToolbar(true)
        }
    }
    
    
    var ingridientStore:IngridientStore!
    
    @IBAction func tuBuy(sender: UIButton){
        ingridientStore=UIStoryboard(name:"Ingridients_ipad",bundle:nil).instantiateViewControllerWithIdentifier("ingridientStore") as IngridientStore
        self.navigationController?.pushViewController(ingridientStore, animated: true)
    }
    
    //我有按钮发生了点击
    @IBAction func haveClick(sender:UIButton){
        ingridient.iHave = ingridient!.iHave
        if(ingridient.iHave == true){
            iHave.image = UIImage(named: "Heartyes.png")
        }else{
            iHave.image = UIImage(named: "Heartno.png")
        }
        var error: NSError? = nil
        if !managedObjectContext.save(&error) {
            abort()
        }
    }
    
    //显示所有的文字
    @IBAction func showAllText(sender:UIButton){
        if(hMainboard.constant == 250){
            var str:String = desc.text!
            var size = str.textSizeWithFont(desc!.font!, constrainedToSize: CGSize(width:300, height:1000))
            if(size.height > (hDesc!.constant-20)){
                /**/
                UIView.animateWithDuration(0.4, animations: {
                    self.hMainboard.constant = 150 + size.height;
                    self.hDesc.constant = size.height + 20;
                    self.view.layoutIfNeeded();
                    }, completion: { _ in
                        sender.titleLabel!.text = "《收起";
                })
                /**/
            }
        }else{
            /**/
            UIView.animateWithDuration(0.4, animations: {
                self.hMainboard.constant = 250
                self.hDesc.constant = 125
                self.view.layoutIfNeeded()
                }, completion: { _ in
                    sender.titleLabel!.text = "全部》"
            })
            /**/
        }
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        //let sectionInfo = self.fetchedResultsController.sections[section] as NSFetchedResultsSectionInfo
        //return sectionInfo.numberOfObjects
        return 0
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var row = indexPath.row
        var session = indexPath.section
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("aboutRecipe", forIndexPath: indexPath) as UICollectionViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as IngridientThumb
        var materials = UIStoryboard(name:"Ingridients"+exdeviceName,bundle:nil).instantiateViewControllerWithIdentifier("ingridientDetail") as IngridientDetail
        //self.navigationController.pushViewController(materials, animated: true)
    }
    
}
