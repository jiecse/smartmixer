//
//  FirstViewController.swift
//  smartmixer
//
//  Created by Koulin Yuan on 8/13/14.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

import UIKit
import CoreData

class Recipes: UIViewController, SearchBeginDelegate ,NumberDelegate{
    
    @IBOutlet weak var parentView: UIView?
    
    @IBOutlet weak var searchView:UIView?
    
    @IBOutlet weak var CollectionView: UIView?
    
    @IBOutlet weak var hCondition: NSLayoutConstraint?
    
    @IBOutlet var searchIco:UIBarButtonItem?
    
    @IBOutlet var navTitle:UINavigationItem!
    
    @IBOutlet var senceTipsButton:UIButton!
    
    @IBOutlet var hSenceTips: NSLayoutConstraint?
    
    var menuVC:SideMenuController?
    
    var isCategoryTableViewHidden = true;
    
    //搜索参数设置部分
    var recipesSearch:RecipesSearch?
    
    //显示的视图
    var recipesCollection:RecipesCollection? = nil
    
    var searchBar:UISearchBar?
    
    var titleView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (rootSideMenu.SideView as CategoryMenu).delegate = self
        if(navTitle != nil){
            var lable = UILabel()
            lable.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            lable.textColor = UIColor.whiteColor()
            lable.textAlignment = NSTextAlignment.Center
            lable.text = navTitle.title!
            //TODO:场景功能展示隐藏
            /**
            var doubleclick = UITapGestureRecognizer(target: self, action: "navdoubleClick:")
            //doubleclick.numberOfTapsRequired = 2
            lable.addGestureRecognizer(doubleclick)
            lable.userInteractionEnabled = true
           * */
            navTitle.titleView = lable
            
        }
        searchBar = UISearchBar()
        searchBar?.placeholder = "例如：B52"
        
        var left = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showLeft:"))
        self.navigationItem.leftBarButtonItem = left
        
        recipesSearch = self.childViewControllers[1] as? RecipesSearch
        recipesSearch?.delegate = self
        var rect  = CGRect(x: searchView!.frame.origin.x, y: searchView!.frame.origin.y, width: searchView!.frame.width, height: 0)
        searchView?.frame = rect
        searchView?.hidden = true
        
        recipesCollection = self.childViewControllers[0] as? RecipesCollection
        recipesCollection?.recipesSearch = recipesSearch
        recipesCollection?.NavigationController = self.navigationController
    }
    
    func showLeft(sender:UIButton){
        if (rootSideMenu != nil){
            rootSideMenu.showLeftViewController(true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var hasShowTips:Bool = false
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(hasShowTips == false){
            showSenceTips("更多精彩尽在标题栏哟~")
            hasShowTips = true
        }
    }
    
    func scrollToTop(){
        if(hasShowTips == true){
           recipesCollection?.icollectionView.setContentOffset(CGPoint.zeroPoint, animated: true)
        }
    }
    
    /**
    //双击导航栏
    
    var senceSearch:SenceSearch!
    
    func navdoubleClick(sender:UITapGestureRecognizer){
        senceSearch = UIStoryboard(name: "Recipes"+exdeviceName, bundle: nil).instantiateViewControllerWithIdentifier("senceSearch")as SenceSearch
        senceSearch.delegate = self
        senceSearch.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.view.window?.rootViewController?.presentViewController(senceSearch, animated: false, completion: nil)

    }
    
    func SenceSearchAction(sender:String){
        showSenceTips(sender)
    }
    
    **/
    func showSenceTips(info:String){
        senceTipsButton.setTitle(info,forState: UIControlState.Normal)
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.hSenceTips?.constant =  10
            self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animateWithDuration(0.2, delay: 1.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.hSenceTips?.constant =  -40
                    self.view.layoutIfNeeded()
                    }, completion: nil)
        })
    }
    
    func NumberAction(sender:UIViewController,num Number:Int){
        recipesCollection?.catagorySearch = Number;
        recipesCollection?.ReloadData()
    }
    
    //点击搜索按钮
    @IBAction func showSearchMore(sender:UIBarButtonItem){
        self.searchView!.hidden = false
        titleView = self.navigationItem.titleView
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancleSearch:")
        UIView.animateWithDuration(0.2, animations: {
            self.hCondition!.constant = 280
            self.parentView!.layoutIfNeeded()
        })
        
    }
    
    func cancleSearch(sender:UIBarButtonItem){
        UIView.animateWithDuration(0.2, animations: {
            self.hCondition!.constant = 0
            self.parentView!.layoutIfNeeded()
            }, completion: {_ in
                self.searchView!.hidden = true
                self.navigationItem.titleView = self.titleView
                self.navigationItem.rightBarButtonItem = self.searchIco
        })
    }
    
    
    //点击搜索回车按钮
    func SearchBeginAction(sender: RecipesSearch,hide:Bool) {
        recipesSearch!.keyWord = searchBar!.text
        recipesCollection!.ReloadData()
        if(hide){
            UIView.animateWithDuration(0.2, animations: {
                self.hCondition!.constant = 0
                self.parentView!.layoutIfNeeded()
                }, completion: {_ in
                    self.searchView!.hidden = true
                    self.navigationItem.titleView = self.titleView
                    self.navigationItem.rightBarButtonItem = self.searchIco
            })
        }
    }
    
}


