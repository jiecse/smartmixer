//
//  CookingStepCell.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-19.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

class CookingStepCell: UITableViewCell {
    
    //阶段信息
    @IBOutlet var stepInfo : UILabel!
    
    //阶段状态
    @IBOutlet var stepImage:UIImageView!
    
    var stepStatus:Int{
        
        get{
            return 0
        }
        
        set(newValue){
            if(newValue == 0){
                stepImage.image = UIImage()
            }else if(newValue == 1){
                stepImage.image = UIImage(named: "menu-bar-icon")
            }else if(newValue == 2){
                stepImage.image = UIImage(named: "stepok")
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
