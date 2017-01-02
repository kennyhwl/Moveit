//
//  ImageEditor.swift
//  Moveit
//
//  Created by Kenny Ho on 1/1/17.
//  Copyright © 2017 Kenny Ho. All rights reserved.
//

import UIKit

@IBDesignable
class ImageEditor: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
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
