//
//  CircleWithBorderImage.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-19.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

@IBDesignable class RadiusImage: UIImageView , UIGestureRecognizerDelegate {
    
    @IBInspectable var borderColor:UIColor = UIColor.grayColor(){
        didSet{
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 2 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var cornerRadius:CGFloat = 20 {
        didSet{
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    
    //是否处理点击全屏的方法
    @IBInspectable var acceptFullscreen:Bool = false {
        didSet{
            if(acceptFullscreen){
                self.userInteractionEnabled = true
                clickGesture = UITapGestureRecognizer(target: self, action: Selector("Fullscreen:"));
                clickGesture?.delegate = self
                self.addGestureRecognizer(clickGesture!)
            }else{
                if clickGesture != nil {
                    self.userInteractionEnabled = false
                    self.removeGestureRecognizer(clickGesture!)
                    clickGesture = nil
                }
            }
        }
    }
    
    //定义的手势
    var clickGesture:UITapGestureRecognizer? = nil
    
    //原来的位置
    var oldframe:CGRect = CGRect()
    
    var backgroundView:UIView!
    
    func Fullscreen(sender:UITapGestureRecognizer){
        var image=self.image
        var window = UIApplication.sharedApplication().keyWindow
        backgroundView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
        
        oldframe=self.convertRect(self.bounds, toView: window)
        backgroundView.userInteractionEnabled = true
        backgroundView.backgroundColor=UIColor.blackColor()
        backgroundView.alpha=0
        var imageView = UIImageView(frame: oldframe)
        imageView.image=image;
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.tag=1;
        imageView.userInteractionEnabled = true
        backgroundView.addSubview(imageView)
        window.addSubview(backgroundView)
        
        var tap = UITapGestureRecognizer(target: self, action: Selector("hideFullscreen:"))
        tap.delegate = self
        
        backgroundView.addGestureRecognizer(tap)
        
        UIView.animateWithDuration(0.3, animations: {
            imageView.frame=CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height)
            self.backgroundView.alpha=1
            }, completion: { _ in
                
        })
        
    }
    
    //从全屏中退出
    func hideFullscreen(sender:UITapGestureRecognizer){
        var backgroundView = sender.view
        
        var imageView = sender.view?.viewWithTag(1)
        /**/
        UIView.animateWithDuration(0.3, animations: {
                //self.imageView.frame = self.oldframe
                self.backgroundView.alpha = 0
            },
            completion: { _ in
                self.backgroundView.removeFromSuperview()
        })
        /**/
    }
    
}
