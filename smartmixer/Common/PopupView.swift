//
//  PopupView.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-4.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

//箭头的方向
enum ArrorDirection{
   case left//向左
   case right//向右
}

class PopupView: UIView {
    
    //指向的方向 0为left 1为右
    var arrorDirection:ArrorDirection = ArrorDirection.left
    
    //父View
    @IBOutlet var parentView:UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.alpha = 0.8
    }
    
    var closeButton:UIButton! = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        if(closeButton == nil){
            closeButton=UIButton(frame: CGRect(x: self.frame.width-22,y: 2,width: 20,height: 20))
            closeButton.setBackgroundImage(UIImage(named: "close-gray"), forState: UIControlState.Normal)
            self.addSubview(closeButton)
            closeButton.addTarget(self, action: Selector("closeView:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
    }
    
    //呼叫隐藏视图
    func closeView(sender:UIButton){
        showOrHideView(false)
    }
    
    //显示或隐藏
    func showOrHideView(options:Bool){
        if(options){
            self.alpha = 0
            self.hidden = false
            UIView.animateWithDuration(0.3, animations: { self.alpha = 0.9 }, completion: { _ in
                self.lockAnimation = false
            })
        }else{
            UIView.animateWithDuration(0.3, animations: {
                self.alpha = 0
                }, completion: { _ in
                    self.hidden = true
                    self.lockAnimation = false
                })
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawInContext(UIGraphicsGetCurrentContext())
        //设置阴影颜色，透明度，偏移量
        self.layer.shadowColor = UIColor.grayColor().CGColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.55;
        self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    }
    
    //箭头距顶端的距离
    var arrorPosY:CGFloat = 60
    
    //箭头的宽度，高度为宽度*2
    let arrorWidth:CGFloat = 20
    
    //圆弧的角度
    let radius:CGFloat = 10
    
    //改变Arrow的计时器
    var changeArrorPosTimer:NSTimer!
    
    //当前显示的View
    var currentView:UIView?=nil
    
    var arrowInternal:CGFloat = 5
    
    func animateArrorPos(){
        if(arrorPosY < newArrorPosY){
            arrorPosY += arrowInternal
            if(arrorPosY > newArrorPosY){
                arrorPosY = newArrorPosY
            }
        } else if(arrorPosY > newArrorPosY){
            arrorPosY -= arrowInternal
            
            if(arrorPosY < newArrorPosY){
                arrorPosY = newArrorPosY
            }
        }else{
            self.changeArrorPosTimer.invalidate()
            self.changeArrorPosTimer = nil
        }
        self.setNeedsDisplay()
    }
    
    var newArrorPosY:CGFloat=0
    
    //新的需要显示的View
    var inewView:UIView? = nil
    
    var lockAnimation:Bool = false
    
    //新建新的View
    func showNewView(newView:UIView,pointToItem item:UIView){
        if(lockAnimation){ return }
        lockAnimation=true
        if(self.hidden){
            showOrHideView(true)
        }
        if(self.currentView != newView){
            //首先计算出目标的位置
            var rect:CGRect = item.bounds
            rect = item.convertRect(rect, toView: parentView)
            var pointPos:CGFloat = 0
            if(rect.height<40){
                pointPos = rect.midY
            }else{
                pointPos = rect.minY + 20
            }
            
            var newContainerY = pointPos - 60
            
            //如果需要显示的东西太height
            if((newContainerY + newView.frame.height) > 680){
                newContainerY = 680 - newView.frame.height
                //这就是箭头的偏移值
            }
            
            newArrorPosY = pointPos - newContainerY
            
            
            //新窗口的大小
            var newRect = CGRect(x: self.frame.origin.x, y: newContainerY, width: newView.frame.width+40, height: newView.frame.height+20)
            
            
            //新填充视图的位置
            newView.frame = CGRect(x: 30, y: 10, width: newView.frame.width, height: newView.frame.height)
            
            if(arrorDirection == ArrorDirection.right){
                newRect = CGRect(x: rect.origin.x - newView.frame.width - 40 , y: newContainerY, width: newView.frame.width+40, height: newView.frame.height+20)
                newView.frame = CGRect(x: 10, y: 10, width: newView.frame.width, height: newView.frame.height)
            }
            
            
            arrowInternal = (self.newArrorPosY - self.arrorPosY)/19
            if(arrowInternal<0){
                arrowInternal = -arrowInternal
            }
            //self.arrorPosY = self.newArrorPosY
            self.changeArrorPosTimer = NSTimer.scheduledTimerWithTimeInterval(0.025, target: self, selector: "animateArrorPos", userInfo: nil, repeats: true)
            UIView.animateWithDuration(0.5, animations: {
                self.frame = newRect
                self.addSubview(newView)
                newView.alpha = 1
                if(self.currentView != nil){
                    self.currentView?.alpha = 0
                }
                if(self.arrorDirection == ArrorDirection.right){
                    self.closeButton.frame=CGRect(x: 2,y: 2,width: 20,height: 20)
                } else if(self.arrorDirection == ArrorDirection.left){
                    self.closeButton.frame=CGRect(x: newRect.width-22,y: 2,width: 20,height: 20)
                }
                
                }, completion: { _ in
                    self.bringSubviewToFront(self.closeButton)
                    if(self.currentView != nil){
                        self.currentView?.removeFromSuperview()
                    }
                    self.currentView = newView
                    self.setNeedsDisplay()
                    self.lockAnimation = false
            })
        }
    }
    
    func drawInContext(context:CGContext!){
        
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        CGContextSetLineWidth(context, 1.0)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        var rrect = self.bounds;
        var minx = CGRectGetMinX(rrect)
        var maxx = CGRectGetMaxX(rrect)
        var miny = CGRectGetMinY(rrect)
        var maxy = CGRectGetMaxY(rrect)
        if(self.arrorDirection == ArrorDirection.left){//向左
            minx = minx + arrorWidth
            CGContextMoveToPoint(context, minx,arrorWidth+arrorPosY)
            CGContextAddLineToPoint(context,minx-arrorWidth, arrorPosY)
            CGContextAddLineToPoint(context,minx, arrorPosY-arrorWidth)
            
            CGContextAddArcToPoint(context, minx, miny, maxx, miny, radius)
            CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, radius)
            CGContextAddArcToPoint(context, maxx, maxy, minx, maxy, radius)
            CGContextAddArcToPoint(context, minx, maxy, minx, arrorWidth+arrorPosY, radius)
            
            
        }else if(self.arrorDirection == ArrorDirection.right){//向右
            
            maxx = maxx - arrorWidth
            CGContextMoveToPoint(context, maxx,arrorWidth+arrorPosY)
            CGContextAddLineToPoint(context,maxx+arrorWidth, arrorPosY)
            CGContextAddLineToPoint(context,maxx, arrorPosY-arrorWidth)
            
            CGContextAddArcToPoint(context, maxx, miny, minx, miny, radius)
            CGContextAddArcToPoint(context, minx, miny, minx, maxy, radius)
            CGContextAddArcToPoint(context, minx, maxy, maxx, maxy, radius)
            CGContextAddArcToPoint(context, maxx, maxy, maxx, arrorWidth+arrorPosY, radius)
            
        }
        
        CGContextClosePath(context)
        CGContextDrawPath(context, kCGPathFillStroke)
    }
    
}
