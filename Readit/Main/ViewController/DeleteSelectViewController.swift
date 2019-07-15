//
//  DeleteSelectViewController.swift
//  Readit
//
//  Created by 권서연 on 08/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class DeleteSelectViewController: UIViewController {
    @IBOutlet var whiteBox: UIView!
    @IBOutlet var flagZeroBtn: UIButton!
    @IBOutlet var flagOneBtn: UIButton!
    var categoryIdx: Int?
    var defaultIdx: Int?
    var deleteFlag = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewRounded()
        
    }
    
    func setViewRounded() {
        whiteBox.makeRounded(cornerRadius: 5.0)
    }
    
    @IBAction func flagZero(_ sender: Any) {
        flagZeroBtn.setImage(UIImage(named: "icCheckSmall"), for: .normal)
        flagOneBtn.setImage(UIImage(named: "icCheckBlankSmall"), for: .normal)
        deleteFlag = 0
    }
    
    @IBAction func flagOne(_ sender: Any) {
        flagZeroBtn.setImage(UIImage(named: "icCheckBlankSmall"), for: .normal)
        flagOneBtn.setImage(UIImage(named: "icCheckSmall"), for:.normal)
        deleteFlag = 1
    }
    
    @IBAction func okBtn(_ sender: UIButton) {
        CategoryService.shared.deleteCategoryView(default_idx: defaultIdx!, categoryIdx: categoryIdx!, deleteFlag: deleteFlag) {
            [weak self]
            (data) in
            guard let `self` = self else { return }
            switch data {
            // 매개변수에 어떤 값을 가져올 것인지
            case .success:
                print("카테고리 삭제 성공")
                self.dismiss(animated: true, completion: nil)
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                print("네트워크 오류")
            case .error(_):
                print("에러")
            }
        }
    }
}

