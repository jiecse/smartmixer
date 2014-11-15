//
//  WeightView.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-3.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit
import QuartzCore

class WeightView: UIViewController {
    
    @IBOutlet var pintBall:UIView!
    
    @IBOutlet var clearButton:UIButton!
    
    @IBOutlet var showLable:UILabel!
    
    var showWeight:CGFloat!=0
    
    var realWeight:CGFloat!=0
    
    var clipWeight:CGFloat!=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pintBall.layer.anchorPoint = CGPointMake(0.5,0.5);
        /**UIView.animateWithDuration(1,
            animations : {
                self.pintBall.transform = CGAffineTransformMakeRotation((-60 * CGFloat(M_PI)) / 180.0)
            }
        )
        **/
        showWeightAnimate(1000)
    }
    
    func showWeightAnimate(weight:CGFloat){
        
        var diff = weight - self.clipWeight
        diff = diff - self.showWeight
        var timediff = Double(diff/1000.0)
        self.realWeight = weight
        UIView.animateWithDuration(timediff,
            animations : {
                self.showWeight = self.realWeight - self.clipWeight
                self.showLable.text = "\(self.showWeight)"
                self.pintBall.transform = CGAffineTransformMakeRotation(self.showWeight/1000 * CGFloat(M_PI))
            }
        )
    }
    
    @IBAction func setWeightZero(sender:UIButton){
        self.clipWeight = self.realWeight
        showWeightAnimate(self.realWeight)
    }
    
}
