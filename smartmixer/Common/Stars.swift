//
//  Stars.swift
//  smartmixer
//
//  Created by Koulin Yuan on 8/17/14.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

import UIKit

@IBDesignable class Stars : UIView {
    
    @IBOutlet weak var star1: UIImageView!
    
    @IBOutlet weak var star2: UIImageView!
    
    @IBOutlet weak var star3: UIImageView!
    
    @IBOutlet weak var star4: UIImageView!
    
    @IBOutlet weak var star5: UIImageView!
    
    @IBInspectable var value: Int = 3 {
        didSet {
            refreshTo(value)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if let touch: UITouch = touches.anyObject() as? UITouch {
            for index in 1...5 {
                let tview = self.valueForKey("star\(index)") as UIView!
                if tview.pointInside(touch.locationInView(tview), withEvent: event) {
                    refreshTo(index)
                    break
                }
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        dealWith(touches, withEvent: event) {
            index in
            self.refreshTo(index)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        dealWith(touches, withEvent: event) {
            index in
            self.value = index
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        dealWith(touches, withEvent: event) {
            index in
            self.refreshTo(index)
        }
    }
    
    func refreshTo(value: Int) {
        if value < 0 || value > 5 {
            return
        }
        for index in 0...value {
            (self.valueForKey("star\((index+1))") as UIImageView!)?.image = UIImage(named: "star_on.png")
        }
        for index in (value + 1)..<5 {
            (self.valueForKey("star\((index+1))") as UIImageView!)?.image = UIImage(named: "star.png")
        }
    }
    
    func dealWith(touches: NSSet!, withEvent event: UIEvent!, callback: (index: Int) -> ()) {
        if let touch: UITouch = touches?.anyObject() as? UITouch {
            for index in 1...5 {
                let tview = self.valueForKey("star\(index)") as UIView!
                if tview.pointInside(touch.locationInView(tview), withEvent: event) {
                    callback(index: index)
                    break
                }
            }
        }
    }
}
