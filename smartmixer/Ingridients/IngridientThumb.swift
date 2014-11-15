//
//  FilletCell.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-20.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

@IBDesignable class IngridientThumb: UICollectionViewCell {
    
    @IBOutlet var image:UIImageView!
    
    @IBOutlet var name:UILabel!
    
    @IBOutlet var nameEng:UILabel!
    
    @IBOutlet var alcohol:UILabel!
    
    @IBOutlet var collect:UIImageView!
    
    var collection:UICollectionViewController!=nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var selfIngridient:Ingridient?
    
    //设置窗口的样式
    func SetContentData(ingridient : Ingridient){
        selfIngridient = ingridient
        name.text = ingridient.name//"龙舌兰 Tequila"
        nameEng.text = ingridient.nameEng
        image.image = UIImage(named: ingridient.largePhoto)
        alcohol.text = "29°" //ingridient
        if(ingridient.iHave == true){
            collect!.image = UIImage(named: "Heartyes.png")
        }else{
            collect!.image = UIImage(named: "Heartno.png")
        }
    }
    
    //点击收藏与取消收藏
    @IBAction func clickCollect (sender : UIButton)
    {
        selfIngridient!.iHave = selfIngridient!.iHave
        if(selfIngridient!.iHave == true){
            collect!.image = UIImage(named: "Heartyes.png")
        }else{
            collect!.image = UIImage(named: "Heartno.png")
        }
        var error: NSError? = nil
        if !managedObjectContext.save(&error) {
            abort()
        }
        
        if(collection != nil && selfIngridient!.iHave == false){//这里判断本项是否可以删除从视图
            UIView.animateWithDuration(0.3,
                animations: {
                    self.alpha = 0
                }, completion: { _ in
                    self.removeFromSuperview()
            })
        }
    }
    
}