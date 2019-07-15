//
//  MypagePasswordViewController.swift
//  Readit
//
//  Created by 황유선 on 12/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class MypagePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var reNewPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topView.layer.borderWidth = 0.2
        
        self.passwordField.textFieldUnderLine(line: 1.5, color: UIColor.grey)
        self.newPasswordField.textFieldUnderLine(line: 1.5, color: UIColor.grey)
        self.reNewPasswordField.textFieldUnderLine(line: 1.5, color: UIColor.grey)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
