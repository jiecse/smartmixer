//
//  RecipeThumbail.swift
//  smartmixer
//
//  Created by Koulin Yuan on 8/17/14.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

import UIKit

@IBDesignable class RecipeThumbail : UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var cookTimes: UILabel!
    
    @IBOutlet weak var favButton: UIImageView!
    
    @IBOutlet weak var alcohol:UILabel!
    
    @IBOutlet weak var nameEng:UILabel!
    
    var collection:UICollectionView!=nil
    
    @IBInspectable var borderColor:UIColor = UIColor.grayColor(){
        didSet{
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 1 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var cornerRadius:CGFloat = 10 {
        didSet{
            clipsToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBAction func favClick(sender: UIButton) {
        CurrentRecipe.isFav = CurrentRecipe!.isFav
        var error: NSError? = nil
        if !managedObjectContext.save(&error) {
            abort()
        }
        if(CurrentRecipe.isFav == true){
            favButton.image = UIImage(named: "Heartyes.png")
        }else{
            favButton.image = UIImage(named: "Heartno.png")
        }
        
        if(collection != nil && CurrentRecipe.isFav == false){//这里判断本项是否可以删除从视图
            UIView.animateWithDuration(0.3,
                animations: {
                    self.alpha = 0
                }, completion: { _ in
                    self.removeFromSuperview()
            })
        }
    }
    
    var CurrentRecipe:Recipe!
    
    func SetDataContent(item:Recipe){
        CurrentRecipe = item
        self.tag = Int(item.id)
        self.nameLabel.text = item.name
        self.nameEng.text = item.nameEng
        self.descriptionLabel.text = item.des
        self.cookTimes.text = "\(item.cooktimes)"
        self.alcohol.text = "\(item.alcohol) °"
        self.thumbnailImage.image = UIImage(named: item.largePhoto)
        if(item.isFav == true){
            favButton.image = UIImage(named: "Heartyes.png")
        }else{
            favButton.image = UIImage(named: "Heartno.png")
        }
    }
}
