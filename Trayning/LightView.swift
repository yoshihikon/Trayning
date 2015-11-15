//
//  LightView.swift
//  Trayning
//
//  Created by yoshihiko on 2015/11/15.
//  Copyright © 2015年 goodmix. All rights reserved.
//

import UIKit

class LightView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let duration = 0.5
    
    func hide(){
        self.alpha = 0.0
    }
    
    func fadeIn(){
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut,
            animations: { () -> Void in
                self.alpha = 1.0
            },
            completion: { (Bool) -> Void in
                
            }
        )
    }
    
    func fadeOut(){
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut,
            animations: { () -> Void in
                self.alpha = 0.0
            },
            completion: { (Bool) -> Void in
                
            }
        )
    }
}
