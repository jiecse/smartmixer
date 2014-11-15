//
//  extension.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-2.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//

import UIKit

extension String {
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if CGSizeEqualToSize(size, CGSizeZero) {
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            textSize = self.sizeWithAttributes(attributes)
        } else {
            let option = NSStringDrawingOptions.UsesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            let stringRect = self.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}