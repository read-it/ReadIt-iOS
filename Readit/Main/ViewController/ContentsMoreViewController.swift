//
//  ContentsMoreViewController.swift
//  Readit
//
//  Created by 권서연 on 06/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class ContentsMoreViewController: UIViewController {
    @IBOutlet var morePopupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setViewRounded()
        
    }
    
    func setViewRounded() {
        
    self.morePopupView.makeRounded(cornerRadius: 10.0)
    }
    
}
