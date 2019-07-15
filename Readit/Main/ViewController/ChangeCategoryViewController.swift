//
//  ChangeCategoryViewController.swift
//  Readit
//
//  Created by 권서연 on 08/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class ChangeCategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 배경 터치하면 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
