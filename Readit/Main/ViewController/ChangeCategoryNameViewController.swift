//
//  ChangeCategoryNameViewController.swift
//  Readit
//
//  Created by 권서연 on 07/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class ChangeCategoryNameViewController: UIViewController {
    @IBOutlet var changePopupView: UIView!
    @IBOutlet var changeNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewRounded()
    }
    
    // 배경 터치하면 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func cancelBtn(_ sender: Any) {
         self.dismiss(animated: true)
    }
    
    @IBAction func okBtn(_ sender: Any) {
         self.dismiss(animated: true)
    }
    func setViewRounded() {
        self.changePopupView.makeRounded(cornerRadius: 5.0)
    }
}
