//
//  ConnectDevice.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-28.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

class ConnectDevice: UIViewController {

    //全局的提示
    @IBOutlet weak var mainTips:UILabel!
    
    //蓝牙的按钮
    @IBOutlet weak var blueButton:FilletButton!
    //蓝牙的文字提示
    @IBOutlet weak var blueTitle:UILabel!
    
    //电源的按钮
    @IBOutlet weak var powerButton:FilletButton!
    //电源的文字提示
    @IBOutlet weak var powerTitle:UILabel!
    
    //展示的图片
    @IBOutlet weak var showImage:UIImageView!
    
    //去买按钮
    @IBAction func toBuy(sender:UIButton){
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.smarthito.com/"))
    }
    
    //视图加载处理
    override func viewDidLoad() {
        
    }
}
