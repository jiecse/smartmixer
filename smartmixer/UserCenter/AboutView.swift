//
//  AboutView.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-2.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

class AboutView: UIViewController {

    var items:[String] = ["关于","购买","联系","评分","反馈","条款","帮助"]
    
    @IBOutlet weak var detailContainer:UIView!
    
    
    //滚动视图的高度
    @IBOutlet var scrollHeight:NSLayoutConstraint!
    
    var appID:String = "3Z8C4UK6GU"
    
    var aboutDetail:AboutDetail!=nil
    //3Z8C4UK6GU.com.smarthito.smartmixer
    func gotoMark(){
        var link = "itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id="+appID
        UIApplication.sharedApplication().openURL(NSURL(string: link))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        aboutDetail = self.childViewControllers[0] as? AboutDetail
        aboutDetail.showTag(0)
        scrollHeight.constant = CGFloat(items.count*50)
        self.view.layoutIfNeeded();
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
        rootController.showOrhideToolbar(true)
    }
    
    //告知窗口现在有多少个item需要添加
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    //处理单个View的添加
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        
        var Cell :UITableViewCell = tableView.dequeueReusableCellWithIdentifier("aboutItem") as UITableViewCell
        Cell.textLabel?.text = items[indexPath.row]
        return Cell
    }
    
    var welcome:Welcome!
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if(indexPath.row==3){
            gotoMark()
        }else if(indexPath.row==6){
            welcome = UIStoryboard(name:"Launch_ipad",bundle:nil).instantiateViewControllerWithIdentifier("welcome") as Welcome
            welcome.firstPop=false;
            welcome.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            self.view.window?.rootViewController?.presentViewController(welcome, animated: true, completion: nil)
        }else{
            aboutDetail.showTag(indexPath.row)
        }
    }

    
}
