//
//  AboutDetail.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-3.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

class AboutDetail: UIViewController {
    
    @IBOutlet var about:UIView!
    @IBOutlet var buy:UIView!
    @IBOutlet var contact:UIView!
    @IBOutlet var response:UIView!
    @IBOutlet var terms:UIView!
    
    @IBOutlet var help:UIView!
    
    @IBOutlet var navTitle:UINavigationItem!
    
    @IBOutlet var webPage:UIWebView!
    
    var currentTag:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if(exdeviceName == ""){
            //添加向右滑动返回
            var slideback = UISwipeGestureRecognizer(target: self, action: "SwipeToBack:")
            slideback.direction = UISwipeGestureRecognizerDirection.Right
            self.view.addGestureRecognizer(slideback)
            self.view.userInteractionEnabled = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        showTag(currentTag)
    }
    
    func SwipeToBack(sender:UISwipeGestureRecognizer){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showTag(tag:Int){
        currentTag = tag
        switch tag{
        case 0:
            self.view.bringSubviewToFront(about)
        case 1:
            self.view.bringSubviewToFront(buy)
        case 2:
            self.view.bringSubviewToFront(contact)
        case 4:
            var request = NSURLRequest(URL: NSURL(string: "http://www.smarthito.com/feedback"))
            webPage.loadRequest(request)
            self.view.bringSubviewToFront(response)
        case 5:
            self.view.bringSubviewToFront(terms)

        default:
            break
        }
    }
    
    
    //新浪微博
    @IBAction func openWeibo(sender:UIButton){
        //
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.smarthito.com/snscontacts?to=sinaweibo"))
    }
    //微信 weixin://qr/%@
    @IBAction func openWeixin(sender:UIButton){
        //
        UIApplication.sharedApplication().openURL(NSURL(string:"http://www.smarthito.com/snscontacts?to=weixin"))
    }
    
    //陌陌 weixin://qr/%@
    @IBAction func openMomo(sender:UIButton){
        //
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.smarthito.com/snscontacts?to=momo"))
    }
    
    //淘宝 weixin://qr/%@
    @IBAction func openTaobao(sender:UIButton){
        //
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.smarthito.com/store?to=taobao"))
    }
    
    //微店 weixin://qr/%@
    @IBAction func openWeidian(sender:UIButton){
        //
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.smarthito.com/store?to=weidian"))
    }
}
