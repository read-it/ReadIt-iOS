//
//  categoryCVC.swift
//  readit_test
//
//  Created by 권서연 on 03/07/2019.
//  Copyright © 2019 권서연. All rights reserved.
//

import UIKit

class categoryCVC: UICollectionViewCell {
    var idx : Int = 0
    @IBOutlet public var orangeView: UIView!
    
    @IBOutlet var categoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
}
