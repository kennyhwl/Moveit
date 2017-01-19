//
//  ProgressCustom.swift
//  Moveit
//
//  Created by Kenny Ho on 15/1/17.
//  Copyright © 2017 Kenny Ho. All rights reserved.
//

import UIKit

@IBDesignable

class ProgressCustom: UIProgressView {

    @IBInspectable var progressLabelColor: UIColor = UIColor.black
    
    @IBInspectable var barHeight: CGFloat = 0.0
    
    @IBInspectable var strokeColor: UIColor = UIColor.black {
        
        didSet {
            progressLayer.strokeColor = strokeColor.CGColor
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
