//
//  ContainerItem.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-8-16.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

class ContainerItem: UITableViewCell {
    
    //绑定缩略图
    @IBOutlet var thumb : RadiusImage!
    
    @IBOutlet var name : UILabel!
    
    @IBOutlet var nameEng:UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
