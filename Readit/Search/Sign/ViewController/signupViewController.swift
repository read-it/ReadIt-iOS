//
//  signupViewController.swift
//  Readit
//
//  Created by 황유선 on 03/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class signupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rePasswordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        rePasswordField.delegate = self
        
        self.emailField.textFieldUnderLine(line: 2.0, color: UIColor.grey)
        self.passwordField.textFieldUnderLine(line: 2.0, color: UIColor.grey)
        self.rePasswordField.textFieldUnderLine(line: 2.0, color: UIColor.grey)
        
        paddingRight(field: emailField)
        paddingRight(field: passwordField)
        paddingRight(field: rePasswordField)
        
        signupButton.isEnabled = false
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    // 키보드 관련
    @IBAction func emailDidEndOnExit(_ sender: Any) {
    }
    @IBAction func passwordDidEndOnExit(_ sender: Any) {
    }
    @IBAction func repasswordDidEndOnExit(_ sender: Any) {
    }
    
    @IBAction func emailEditingDidBegin(_ sender: Any) {
        self.emailField.textFieldUnderLine(line: 2.0, color: UIColor.orangeRed)
        moveTextField(textField: emailField, moveDistance: -65, up: true)
    }
    @IBAction func passwordEditingDidBegin(_ sender: Any) {
        self.passwordField.textFieldUnderLine(line: 2.0, color: UIColor.orangeRed)
    }
    @IBAction func repasswordEditingDidBegin(_ sender: Any) {
        self.rePasswordField.textFieldUnderLine(line: 2.0, color: UIColor.orangeRed)
    }
    
    @IBAction func emailEditingDidEnd(_ sender: Any) {
        //if emailField.text == "" {
            self.emailField.textFieldUnderLine(line: 2.0, color: UIColor.grey)
        //}
    }
    @IBAction func passwordEditingDidEnd(_ sender: Any) {
        //if passwordField.text == "" {
            self.passwordField.textFieldUnderLine(line: 2.0, color: UIColor.grey)
        //}
    }
    @IBAction func repasswordEditingDidEnd(_ sender: Any) {
        //if rePasswordField.text == "" {
            self.rePasswordField.textFieldUnderLine(line: 2.0, color: UIColor.grey)
        //}
        moveTextField(textField: emailField, moveDistance: -65, up: false)
    }
    

    

    // 배경 터치하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        signupButtonChangeColor()
        
        let dy = self.view.frame.origin.y
        if dy != 0 {
            moveTextField(textField: emailField, moveDistance: Int(dy), up: false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            rePasswordField.becomeFirstResponder()
        } else {
            rePasswordField.resignFirstResponder()
            signupButtonChangeColor()
        }
        return true
    }

    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement : CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func paddingRight(field: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: field.frame.height))
        field.rightView = paddingView
        field.rightViewMode = UITextField.ViewMode.always
    }
    
    func signupButtonChangeColor() {
        if emailField.text != "" && passwordField.text != "" && rePasswordField.text != "" {
            signupButton.setBackgroundImage(UIImage(named: "btnBgOrange.png"), for: UIControl.State.normal)
            signupButton.isEnabled = true
        }
        else {
            signupButton.setBackgroundImage(UIImage(named: "btnBgGray.png"), for: UIControl.State.normal)
            signupButton.isEnabled = false
        }
    }
    

    @IBAction func signupButton(_ sender: Any) {
        signupService()
    }

    
    func signupService() {
        
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let repassword = rePasswordField.text else { return }
        
        AuthService.shared.signup(email: email, password: password, repassword: repassword) {
            data in
            
            switch data {
                
                case .success(let message):
                    print("회원가입 성공")
                    self.dismiss(animated: true, completion: nil)
                
                case .error(let message):
                    let alert = UIAlertController(title: "회원가입 실패", message: message as? String, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인",style: .default)
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                
                case .pathErr:
                    print(".pathErr")
                
                case .serverErr:
                    print(".serverErr")
                
                case .networkFail:
                    let alert = UIAlertController(title: "회원가입 실패", message: "네트워크 에러", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인",style: .default)
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
            }
        }
    }
}
