//
//  MypageProfileViewController.swift
//  Readit
//
//  Created by 황유선 on 10/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class MypageProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate

        self.profileImage.roundedImage()
        self.nicknameField.textFieldUnderLine(line: 1.0, color: UIColor.grey)
        nicknameField.becomeFirstResponder()
        
        completeButton.layer.cornerRadius = 4
        
        
        picker.delegate = self
        self.cameraButton.addTarget(self, action: #selector(self.pickImage), for: .touchUpInside)
        
        self.picker.sourceType = .photoLibrary // 방식 선택. 앨범에서 가져오는걸로 선택.
        self.picker.allowsEditing = false // 수정가능하게 할지 선택. 하지만 false
         // picker delegate
    }
    @objc func pickImage() {
        self.present(self.picker, animated: true) // Controller이기 때문에 present 메서드를 이용해서 컨트롤러 뷰를 띄워준다!
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerEditedImage"] as? UIImage{
            
            profileImage.image = image
            
            print(info)
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
//
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        picker.dismiss(animated: true)
//
//        self.profileImage.image =  info["UIImagePickerControllerOriginalImage"] as? UIImage
//    }
//
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        var newImage: UIImage? = nil
//
//        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage { // 수정된 이미지가 있을 경우
//            newImage = possibleImage
//        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage { // 오리지널 이미지가 있을 경우
//            newImage = possibleImage
//        }
//
//        profileImage.image = newImage // 받아온 이미지를 이미지 뷰에 넣어준다.
//
//        picker.dismiss(animated: true) // 그리고 picker를 닫아준다.
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserProfile()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        //self.openCamera()
    }

    
    
    
    
    @IBAction func completeButton(_ sender: UIButton) {
        editProfile()
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    func getUserProfile() {
        
        MypageService.shared.getProfile() {
            [weak self]
            (data) in
            
            guard let `self` = self else { return }
            
            switch data {
            case .success(let res):
                let userProfile = res as? UserProfile
                let image = UIImage(named: "Placeholder")
                
                self.profileImage.kf.setImage(with: URL(string: userProfile!.profile_img), placeholder: image)
                
                
            case .error(let message):
                let alert = UIAlertController(title: "실패", message: message as? String, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인",style: .default)
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
            case .pathErr:
                print(".pathError")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                let alert = UIAlertController(title: "실패", message: "네트워크 에러", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인",style: .default)
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
            }
        }
    }
    
    func editProfile() {
        
        guard let profile_img = profileImage.image else { return }
        guard let nickname = nicknameField.text else { return }

//        guard let password = passwordField.text else { return }
//        guard let repassword = rePasswordField.text else { return }

        MypageService.shared.editProfile(profile_img: profile_img, nickname: nickname) {
            data in

            switch data {

            case .success(let message):
                print("프로필 변경 성공")
                self.dismiss(animated: true, completion: nil)

            case .error(let message):
                let alert = UIAlertController(title: "프로필 변경 실패", message: message as? String, preferredStyle: .alert)
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



