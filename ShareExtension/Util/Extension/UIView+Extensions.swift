//
//  UIView+Extensions.swift
//  ShareExtension
//
//  Created by 권서연 on 10/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

// UIView Extension
extension UIView {
    
    // Set Rounded View
    func makeRounded(cornerRadius : CGFloat?){
        
        // UIView 의 모서리가 둥근 정도를 설정
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            // cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
}
