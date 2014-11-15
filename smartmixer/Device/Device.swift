//
//  SettingViewController.swift
//  smartmixer
//
//  Created by kingzhang on 8/24/14.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

class Device: UIViewController , UIScrollViewDelegate {
    
    @IBOutlet var closeView:UIImageView?
    
    var scrollview:UIScrollView! = nil
    
    @IBOutlet var pagecontrol:UIPageControl!
    
    var weighing:WeightView!=nil
    
    var connectDevice:ConnectDevice!=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(scrollview == nil){
            var rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-124)
            scrollview = UIScrollView(frame: rect)
            scrollview.bounces = false
            scrollview.showsHorizontalScrollIndicator = false
            scrollview.pagingEnabled = true
            scrollview.contentSize = CGSize(width: rect.width*2, height: rect.height)
            scrollview.delegate = self
            self.view.addSubview(scrollview)
            
            connectDevice = UIStoryboard(name:"Device"+exdeviceName,bundle:nil).instantiateViewControllerWithIdentifier("connectDevice") as ConnectDevice
            connectDevice.view.frame = rect
            scrollview.addSubview(connectDevice.view)
            
            weighing = UIStoryboard(name:"Device"+exdeviceName,bundle:nil).instantiateViewControllerWithIdentifier("weightContainer") as WeightView
            weighing.view.frame = CGRect(x: rect.width, y: 0, width: rect.width, height: rect.height)
            scrollview.addSubview(weighing.view)
            
            self.pagecontrol.currentPage = 0
            self.pagecontrol.numberOfPages = 2
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        var offset:CGFloat!=scrollview.contentOffset.x
        var index:Int = Int( offset+300 / scrollview.frame.width)
        self.pagecontrol.currentPage = index
    }
    
    @IBAction func pageControlChanged(sender: UIPageControl) {
        var left = scrollview.frame.width * CGFloat(self.pagecontrol.currentPage)
        var rect = CGRect(x:left, y: 0, width: scrollview.frame.width, height: scrollview.frame.height)
        self.scrollview.scrollRectToVisible(rect, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.3,
            animations : {
                self.closeView!.transform = CGAffineTransformMakeRotation((-135 * CGFloat(M_PI)) / 180.0)
                self.view.backgroundColor = UIColor(white: 0, alpha: 0.88)
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func TouchOnClose(sender: AnyObject) {
        UIView.animateWithDuration(0.3,
            animations : {
                self.closeView!.transform = CGAffineTransformMakeRotation((0 * CGFloat(M_PI)) / 180.0)
            },
            completion : {_ in
                UIView.animateWithDuration(0.3,
                    animations : {
                        self.view.alpha = 0
                    },
                    completion : {_ in
                        self.dismissViewControllerAnimated(false, completion: nil)
                    }
                )
            }
        )
    }
}
