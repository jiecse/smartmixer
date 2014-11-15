//
//  AboutViewPhone.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-9.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

class AboutViewPhone: UITableViewController {

    var aboutDetail:AboutDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationItem.backBarButtonItem?.title = ""
        aboutDetail = UIStoryboard(name: "UserCenter", bundle: nil).instantiateViewControllerWithIdentifier("aboutDetail") as AboutDetail
        if(exdeviceName == ""){
            //添加向右滑动返回
            var slideback = UISwipeGestureRecognizer(target: self, action: "SwipeToBack:")
            slideback.direction = UISwipeGestureRecognizerDirection.Right
            self.view.addGestureRecognizer(slideback)
            self.view.userInteractionEnabled = true
        }
        
    }
    
    //3Z8C4UK6GU.com.smarthito.smartmixer
    func gotoMark(){
        var link = "itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id="+appID
        UIApplication.sharedApplication().openURL(NSURL(string: link))
    }

    func SwipeToBack(sender:UISwipeGestureRecognizer){
        self.navigationController?.popViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    var welcome:Welcome!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row==3){
            gotoMark()
        }else if(indexPath.row==6){
            welcome = UIStoryboard(name:"Launch",bundle:nil).instantiateViewControllerWithIdentifier("welcome") as Welcome
            welcome.firstPop=false;
            welcome.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            self.view.window?.rootViewController?.presentViewController(welcome, animated: true, completion: nil)
        }else{
            aboutDetail.showTag(indexPath.row)
            self.navigationController?.pushViewController(aboutDetail, animated: true)
        }
    }

}
