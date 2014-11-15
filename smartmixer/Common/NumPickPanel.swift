//
//  NumPickPanel.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-12.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit

//自定义一个搜索设置完毕开始搜索的消息
protocol NumberDelegate:NSObjectProtocol{
    func NumberAction(sender:UIViewController,num Number:Int)
}

class NumPickPanel: UIViewController {

    //数字1
    @IBOutlet var number1:NSLayoutConstraint!
    //数字2
    @IBOutlet var number2:NSLayoutConstraint!
    //数字3
    @IBOutlet var number3:NSLayoutConstraint!
    //数字4
    @IBOutlet var number4:NSLayoutConstraint!
    
    //数字1
    @IBOutlet var number1bt:UIButton!
    //数字2
    @IBOutlet var number2bt:UIButton!
    //数字3
    @IBOutlet var number3bt:UIButton!
    //数字4
    @IBOutlet var number4bt:UIButton!
    
    
    var delegate:NumberDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        number1.constant = -20
        number2.constant = -20
        number3.constant = -20
        number4.constant = -20
        number1bt.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180.0)
        number2bt.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180.0)
        number3bt.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180.0)
        number4bt.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180.0)
        
    }
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.2, animations: {
            self.number1.constant = 50
            self.number2.constant = 50
            self.number3.constant = 50
            self.number4.constant = 50
            self.number1bt.transform = CGAffineTransformMakeRotation((0 * CGFloat(M_PI)) / 180.0)
            self.number2bt.transform = CGAffineTransformMakeRotation((0 * CGFloat(M_PI)) / 180.0)
            self.number3bt.transform = CGAffineTransformMakeRotation((0 * CGFloat(M_PI)) / 180.0)
            self.number4bt.transform = CGAffineTransformMakeRotation((0 * CGFloat(M_PI)) / 180.0)
            self.view.layoutIfNeeded()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickNum(sender:UIButton){
        if(self.delegate != nil){
            self.delegate.NumberAction(self, num: sender.tag)
        }
        closeDial(sender)
    }
    
    
    @IBAction func closeDial(sender:UIButton){
        UIView.animateWithDuration(0.2, animations: {
            self.number1.constant = -20
            self.number2.constant = -20
            self.number3.constant = -20
            self.number4.constant = -20
            self.number1bt.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180.0)
            self.number2bt.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180.0)
            self.number3bt.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180.0)
            self.number4bt.transform = CGAffineTransformMakeRotation((180 * CGFloat(M_PI)) / 180.0)
            self.view.alpha = 0
            self.view.layoutIfNeeded()
            },completion: { _ in
                self.dismissViewControllerAnimated(false, completion: nil)
            })
    }
    
    override func drawLayer(layer: CALayer!, inContext ctx: CGContext!) {
        //设置阴影颜色，透明度，偏移量
        layer.shadowColor = UIColor.grayColor().CGColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.55
        layer.shadowOffset = CGSizeMake(0.0, 0.0)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
