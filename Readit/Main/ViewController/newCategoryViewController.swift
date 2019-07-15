//
//  newCategoryViewController.swift
//  Readit
//
//  Created by 권서연 on 06/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class newCategoryViewController: UIViewController {

    @IBOutlet var popupView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var okBtn: UIButton!
    @IBOutlet var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewRounded()
        self.nameField.delegate = self
    }

    // 배경 터치하면 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "newCategory",
            let dest = segue.destination as? SelectNewCategoryViewController
        {
            dest.newName = nameField.text!
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){}
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func okAction(_ sender: Any) {
        self.performSegue(withIdentifier: "newCategory", sender: self.nameField.text)
    }
    
    func setViewRounded() {
        self.popupView.makeRounded(cornerRadius: 6.0)
        self.cancelBtn.makeRounded(cornerRadius: 5.0)
        self.okBtn.makeRounded(cornerRadius: 5.0)
    }
    
}

extension newCategoryViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.nameField.text = ""
    }
}
