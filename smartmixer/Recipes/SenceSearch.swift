//
//  SenceSearch.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-10.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit

//自定义一个搜索设置完毕开始搜索的消息
protocol SenceSearchDelegate:NSObjectProtocol{
    func SenceSearchAction(sender:String)
}

class SenceSearch: UIViewController {
    
    @IBOutlet var itemContent:UIScrollView!
    
    var buttons:[UIButton] = []
    
    //自定义的消息对象
    var delegate:SenceSearchDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*UIGraphicsBeginImageContext(UIApplication.sharedApplication().keyWindow.bounds.size)
        UIApplication.sharedApplication().keyWindow.layer.renderInContext(UIGraphicsGetCurrentContext())
        var img : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        blurimage.image = img.stackBlur(5.0,color: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.8))
        */
        var exlef = 50
        if(exdeviceName != ""){
            exlef = 400
        }
        
        for( var index = 0 ; index != self.sences.count ; index++){
            var button = UIButton(frame: CGRect(x: exlef + 120 * (index%2) , y: 130+30*index, width: 100, height: 30))
            button.setTitle(self.sences[index], forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.itemContent.addSubview(button)
            button.alpha = 0
            button.addTarget(self,action:"selectOneSence:",forControlEvents:.TouchUpInside)
            self.buttons.append(button)
        }
        self.itemContent.contentSize = CGSize(width: self.view.frame.width, height: CGFloat(200 + 30 * self.sences.count))
    }
    
    func selectOneSence(sender:UIButton){
        if(self.delegate != nil){
            self.delegate.SenceSearchAction(sender.currentTitle!)
        }
        closeView(sender)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var exlef = 50
        if(exdeviceName != ""){
            exlef = 400
        }
        UIView.animateWithDuration(0.3, animations: {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.88)
            for( var index = 0 ; index != self.sences.count ; index++){
                var button = self.buttons[index]
                button.frame = CGRect(x: exlef + 120 * (index%2) , y: 80+30*index, width: 100, height: 30)
                button.alpha = 1
            }
        })
    }
    
    @IBAction func closeView(sender:UIButton){
        var exlef = 50
        if(exdeviceName != ""){
            exlef = 400
        }
        UIView.animateWithDuration(0.3,
            animations : {
                for( var index = 0 ; index != self.sences.count ; index++){
                    var button = self.buttons[index]
                    button.frame = CGRect(x: exlef + 120 * (index%2) , y: 130+30*index, width: 100, height: 30)
                    //button.alpha = 0.2
                }
                self.view.alpha = 0
            },
            completion : {_ in
                self.dismissViewControllerAnimated(false, completion: nil)
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var sences:[String] = ["我是女生","当季最热","不胜酒力","千杯不醉","减肥特饮","护肤美颜","色彩绚丽","甜蜜温馨","一杯倒","绅士风度","大爱甜食","获奖作品","好友拼酒","激情四射","古怪奇葩","心情不好","焦虑过度"]
    
}
