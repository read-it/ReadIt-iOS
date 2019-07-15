//
//  MainViewExtension.swift
//  readit_test
//
//  Created by 권서연 on 30/06/2019.
//  Copyright © 2019 권서연. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
}

