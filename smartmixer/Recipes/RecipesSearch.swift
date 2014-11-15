//
//  RecipesSearch.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-31.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

//自定义一个搜索设置完毕开始搜索的消息
protocol SearchBeginDelegate:NSObjectProtocol{
    func SearchBeginAction(sender:RecipesSearch,hide:Bool)
}

class RecipesSearch: UIViewController , UIGestureRecognizerDelegate{
    
    @IBOutlet var achole:UILabel!
    @IBOutlet var star1:UIImageView!
    @IBOutlet var star2:UIImageView!
    @IBOutlet var star3:UIImageView!
    @IBOutlet var star4:UIImageView!
    @IBOutlet var star5:UIImageView!
    
    //关键字
    var keyWord:String = ""
    
    //口感选项
    var keyTaste:[Bool] = [false,false,false]
    
    //技巧选项
    var keySkill:[Bool] = [false,false,false,false,false]
    
    //适合引用时间
    var keyDrinkTime:[Bool] = [false,false,false]
    
    //酒精度
    var keyAlcohol:Int = 100
    
    //调制难度
    var keyDifficulty = 4
    
    //自定义的消息对象
    var delegate:SearchBeginDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var  gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("clickDifficulty:"))
        gestureRecognizer.delegate = self
        self.star1.userInteractionEnabled = true
        self.star1.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("clickDifficulty:"))
        gestureRecognizer.delegate = self
        self.star2.userInteractionEnabled = true
        self.star2.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("clickDifficulty:"))
        gestureRecognizer.delegate = self
        self.star3.userInteractionEnabled = true
        self.star3.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("clickDifficulty:"))
        gestureRecognizer.delegate = self
        self.star4.userInteractionEnabled = true
        self.star4.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("clickDifficulty:"))
        gestureRecognizer.delegate = self
        self.star5.userInteractionEnabled = true
        self.star5.addGestureRecognizer(gestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func callSearch(sender:UIButton){
        if(self.delegate != nil){
            self.delegate.SearchBeginAction(self,hide: true)
        }
    }
    
    func callStartSearch(){
        if(self.delegate != nil){
            self.delegate.SearchBeginAction(self,hide: false)
        }
    }
    
    //点击口感
    @IBAction func clickTaste(sender:UIButton){
        sender.selected = !sender.selected
        keyTaste[sender.tag] = sender.selected
        callStartSearch()
    }
    
    //点击技巧
    @IBAction func clickSkill(sender:UIButton){
        sender.selected = !sender.selected
        keySkill[sender.tag] = sender.selected
        callStartSearch()
    }
    
    //点击引用时间
    @IBAction func clickDrinkTime(sender:UIButton){
        sender.selected = !sender.selected
        keyDrinkTime[sender.tag] = sender.selected
        callStartSearch()
    }
    
    //点击酒精度
    @IBAction func clickAchole(sender:UISlider){
        achole.text = "\(Int(sender.value))°"
        keyAlcohol = Int(sender.value)
        callStartSearch()
    }
    
    //点击难度
    func clickDifficulty(sender:UITapGestureRecognizer){
        var tag = sender.view?.tag
        if(tag<1){
            star2.image = UIImage(named: "star.png")
        }else{
            star2.image = UIImage(named: "star_on.png")
        }
        
        if(tag<2){
            star3.image = UIImage(named: "star.png")
        }else{
            star3.image = UIImage(named: "star_on.png")
        }
        
        if(tag<3){
            star4.image = UIImage(named: "star.png")
        }else{
            star4.image = UIImage(named: "star_on.png")
        }
        
        if(tag<4){
            star5.image = UIImage(named: "star.png")
        }else{
            star5.image = UIImage(named: "star_on.png")
        }
        keyDifficulty = tag! + 1
        
        callStartSearch()
    }
    
}
