//
//  CategoryCell.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/21.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet var cellname:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
