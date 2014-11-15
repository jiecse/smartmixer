//
//  MaterialClass.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-20.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

class IngridientClassCell: UITableViewCell {
    
    var index:Int?
    
    //缩略图
    @IBOutlet var thumb: UIImageView!
    
    //名字
    
    @IBOutlet var title: UILabel!
    
    //英文名字
    
    @IBOutlet var title_eng: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
