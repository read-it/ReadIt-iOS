//
//  loginViewController.swift
//  Readit
//
//  Created by 황유선 on 03/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class loginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        self.emailField.textFieldUnderLine(line: 2.0, color: UIColor.grey)
        self.passwordField.textFieldUnderLine(line: 2.0, color: UIColor.grey)
        
        paddingRight(field: emailField)
        paddingRight(field: passwordField)
        
    }
    
    // 키보드 return 누르면 키보드 내려가게

    @IBAction func emailDidEndOnExit(_ sender: Any) {
        loginButtonChangeColor()
    }
    @IBAction func passwordDidEndOnExit(_ sender: Any) {
        loginButtonChangeColor()
    }
    @IBAction func emailEditingDidBegin(_ sender: Any) {
        //fieldColorChange(field: emailField)
        self.emailField.textFieldUnderLine(line: 2.0, color: UIColor.orangeRed)
        moveTextField(textField: emailField, moveDistance: -125, up: true)
    }
    @IBAction func passwordEditingDidBegin(_ sender: Any) {
        self.passwordField.textFieldUnderLine(line: 2.0, color: UIColor.orangeRed)
        //moveTextField(textField: passwordField, moveDistance: -55, up: true)
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
        moveTextField(textField: emailField, moveDistance: -125, up: false)
    }
    
    
    // 배경 터치하면 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        loginButtonChangeColor()
        
        let dy = self.view.frame.origin.y
        if dy != 0 {
            moveTextField(textField: emailField, moveDistance: Int(dy), up: false)
        }
    }
    
    // 키보드 return 키 누르면 다음 텍스트 필드로 넘어감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            passwordField.resignFirstResponder()
            loginButtonChangeColor()
        }
        return true
    }
    
    /////////////////////////////////////
    
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
    
    func loginButtonChangeColor() {
        if emailField.text != "" && passwordField.text != "" {
            loginButton.setBackgroundImage(UIImage(named: "btnBgOrange.png"), for: UIControl.State.normal)
        }
        else {
            loginButton.setBackgroundImage(UIImage(named: "btnBgGray.png"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        loginService()
    }

    
    func loginService() {
        
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        AuthService.shared.login(email: email, password: password) {
            data in
            
            switch data {
                
            case .success(let data):

                let token = data as! Data

                UserDefaults.standard.set(token.accesstoken, forKey: "accesstoken")
                UserDefaults.standard.set(token.refreshtoken, forKey: "refreshtoken")
                
                //print(token.accesstoken)
                //print(token.refreshtoken)
                
                let mainvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.present(mainvc, animated: true, completion: nil)
                
            case .error(let message):
                let alert = UIAlertController(title: "로그인 실패", message: message as? String, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                let alert = UIAlertController(title: "로그인 실패", message: "네트워크 에러", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
    }

}
