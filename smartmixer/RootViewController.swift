//
//  RootViewController.swift
//  smartmixer
//
//  Created by kingzhang on 8/24/14.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

import UIKit



var exdeviceName:String = "_ipad"

var rootController:RootViewController!

var rootSideMenu:SideMenuController!

let appID:String = "3Z8C4UK6GU"

class RootViewController: UITabBarController , ChangeTableDelegate{
    
    
    var welcome:UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initControllerView()
        customTabBar()
        rootController = self
        /**/
        if(!NSUserDefaults.standardUserDefaults().boolForKey("Launched")){
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Launched")
            
            welcome = UIStoryboard(name:"Launch"+exdeviceName,bundle:nil).instantiateViewControllerWithIdentifier("welcome") as UIViewController
            self.view.addSubview(welcome.view)
        }
        /**/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var menuVC:SideMenuController!
    
    func initControllerView()
    {
        var recipes = UIStoryboard(name: "Recipes"+exdeviceName, bundle: nil).instantiateInitialViewController() as UIViewController

        rootSideMenu = SideMenuController(nibName: nil, bundle: nil)
        rootSideMenu.rootViewController = recipes
        rootSideMenu.SideView = UIStoryboard(name: "Recipes"+exdeviceName, bundle: nil).instantiateViewControllerWithIdentifier("categoryMenu") as CategoryMenu
        
        var ingridientController = UIStoryboard(name:"Ingridients"+exdeviceName,bundle:nil).instantiateInitialViewController() as UIViewController
        var containerController = UIStoryboard(name: "Containers"+exdeviceName, bundle: nil).instantiateInitialViewController() as UIViewController
        var userCenterController = UIStoryboard(name:"UserCenter"+exdeviceName,bundle:nil).instantiateInitialViewController() as UIViewController
        var tabBarViewControllers = [rootSideMenu, ingridientController,containerController,userCenterController]
        self.setViewControllers(tabBarViewControllers, animated: false)
        
    }
    
    var tabBarView:TabBarViewController!
    
    func customTabBar()
    {
        self.tabBar.hidden = true;
        var item = exdeviceName
        var array = NSBundle.mainBundle().loadNibNamed("TabBarView"+exdeviceName, owner: self, options: nil)
            as  [TabBarViewController]!
        tabBarView = array[0]
        tabBarView.changeTableDelegate = self
        tabBarView.frame = CGRect(x: 0, y: self.view.frame.size.height - 69 , width: self.view.frame.size.width, height: 70)
        self.view.addSubview(tabBarView)
        tabBarView.initSelected()
    }
    
    //显示或影藏
    func showOrhideToolbar(opt:Bool){
        if(opt){
            UIView.animateWithDuration(0.3, animations: {
                self.tabBarView.frame = CGRect(x: 0, y: self.view.frame.size.height - 69 , width: self.view.frame.size.width, height: 70)
            })
        }else{
            UIView.animateWithDuration(0.3, animations: {
                self.tabBarView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 70)
            })
        }
        
    }
    func changeIndex(index: Int) {
        
        switch(index)
            {
        case 0:
            if(self.selectedIndex == index){
                var curent = self.selectedViewController! as SideMenuController
                var item = (curent.rootViewController as UINavigationController).topViewController
                if(item.isKindOfClass(Recipes) == true){
                    (item as Recipes).scrollToTop()
                }
            }
            break
        case 4:
            var moreViewController = UIStoryboard(name: "Device"+exdeviceName, bundle: nil).instantiateInitialViewController() as UIViewController
            moreViewController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            self.view.window?.rootViewController?.presentViewController(moreViewController, animated: false, completion: nil)
        default:
            break
            
        }
        self.selectedIndex = index
    }
    
}
