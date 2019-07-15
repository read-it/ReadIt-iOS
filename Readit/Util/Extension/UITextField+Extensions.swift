//
//  UITextField+Extensions.swift
//  Readit
//
//  Created by 황유선 on 07/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func textFieldUnderLine(line : CGFloat?, color: UIColor?) {
        let border = CALayer()
        
        let width = CGFloat(line!)
        
        border.borderColor = color?.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    
}
