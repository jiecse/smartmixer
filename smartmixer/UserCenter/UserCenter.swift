//
//  UserCenter.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-19.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

class UserCenter: UIViewController , UIGestureRecognizerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate {
    
    @IBOutlet var segment : UISegmentedControl!
    
    @IBOutlet var userimage : UIImageView!
    
    @IBOutlet var bgImage : UIImageView!
    
    @IBOutlet var container:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.selectedSegmentIndex=0
        //注销掉修改用户的头像
        /*
        userimage.userInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action:Selector("TouchUserImage:"))
        recognizer.delegate = self
        userimage.addGestureRecognizer(recognizer)
        */
        segmentedControlAction(UISegmentedControl())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //点击用户头像，开始修改用户的头像信息
    func TouchUserImage(recognizer: UITapGestureRecognizer) {
        var alertView = UIAlertView(title: nil, message: "您希望如何设置头像？", delegate: self, cancelButtonTitle: "取消")
        alertView.addButtonWithTitle("拍摄新照片")
        alertView.addButtonWithTitle("从照片库选取")
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == 0) {
            println("clicked ok")
        } else if (buttonIndex == 1) {
            var imagePicker = UIImagePickerController();
            imagePicker.delegate = self;
            imagePicker.sourceType = .PhotoLibrary;
            imagePicker.modalTransitionStyle = .CoverVertical;
            imagePicker.allowsEditing = false;
            self.presentViewController(imagePicker, animated: true , completion: nil)
        }
    }
    
    //头像操作的反馈调用
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        var image = info["UIImagePickerControllerOriginalImage"] as UIImage
        if (picker.sourceType == .Camera)
        {
            //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        userimage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func ShowSetting(sender:UIButton){
        var  item = UIStoryboard(name: "UserCenter"+exdeviceName, bundle: nil).instantiateViewControllerWithIdentifier("aboutView")as UIViewController
        self.navigationController?.pushViewController(item, animated: true)
        rootController.showOrhideToolbar(false)
    }
    
    var ingridientCollection:IngridientCollection!=nil
    
    var recipesCollection:RecipesCollection!=nil
    
    var recipesHistory:RecipesCollection!=nil
    //segment的点击发生了变化
    @IBAction func segmentedControlAction(sender : UISegmentedControl){
        if(segment.selectedSegmentIndex==0){//我的收藏
            if(recipesCollection == nil){
                recipesCollection = UIStoryboard(name: "Recipes"+exdeviceName, bundle: nil).instantiateViewControllerWithIdentifier("recipesCollection")as RecipesCollection
                recipesCollection.NavigationController = self.navigationController
                recipesCollection.nodataTip = "您还没有添加收藏哟！"
                recipesCollection.view.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: container.frame.height)
                recipesCollection.view.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 235/255, alpha: 1)
                container.addSubview(recipesCollection.view)
            }else{
                recipesCollection.ReloadData()
            }
            container.bringSubviewToFront(recipesCollection.view)
            
        }else if(segment.selectedSegmentIndex==1){//我的材料
            if(ingridientCollection==nil){
                ingridientCollection = UIStoryboard(name: "Ingridients"+exdeviceName, bundle: nil).instantiateViewControllerWithIdentifier("ingridientCollection")as IngridientCollection
                ingridientCollection.NavigationController = self.navigationController
                ingridientCollection.view.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 235/255, alpha: 1)
                ingridientCollection.view.frame = CGRect(x: -10, y: 0, width: container.frame.width+20, height: container.frame.height)
                container.addSubview(ingridientCollection.view)
            }else{
                ingridientCollection.reloadData()
            }
            container.bringSubviewToFront(ingridientCollection.view)
            
        }else if(segment.selectedSegmentIndex==2){//制作历史
            if(recipesHistory == nil){
                recipesHistory = UIStoryboard(name: "Recipes"+exdeviceName, bundle: nil).instantiateViewControllerWithIdentifier("recipesCollection")as RecipesCollection
                recipesHistory.nodataTip = "您的制作历史将会出现在这里哟！"
                recipesHistory.NavigationController = self.navigationController
                recipesHistory.view.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 235/255, alpha: 1)
                recipesHistory.view.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: container.frame.height)
                recipesHistory.catagorySearch = 1
                container.addSubview(recipesHistory.view)
            }else{
                recipesHistory.ReloadData()
            }
            container.bringSubviewToFront(recipesHistory.view)
        }
    }
    
}
