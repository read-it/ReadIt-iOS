//
//  EditCategoryViewController.swift
//  Readit
//
//  Created by 권서연 on 06/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class EditCategoryViewController: UIViewController {
    @IBOutlet var editCategoryTV: UITableView!
    var categoryList : [CategoryList] = []
    var defaultIdx : Int?
    var categoryIdx : Int?
    
    @IBOutlet var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryData()
        editCategoryTV.setEditing(true, animated: true)
        editCategoryTV.dataSource = self
        
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "editCategoryName", sender: self)
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextVeditCategoryName" {
            let sendData = name.text
            let dvc = segue.destination as! ChangeCategoryNameViewController
            dvc.changeNameTextField.text = sendData!
        }
    }
}

extension EditCategoryViewController: UITableViewDataSource {
    // UITalbeView 에 얼마나 많은 리스트를 담을 지 설정합니다.
    // 현재는 musicList 배열의 count 갯수 만큼 반환합니다.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryList.count - 1
    }
    
    // 각 index 에 해당하는 셀에 데이터를 주입합니다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = editCategoryTV.dequeueReusableCell(withIdentifier: "editCategoryTVC") as! editCategoryTVC
        
        let category = categoryList[indexPath.row + 1]
        
        cell.name.text = category.category_name
        return cell
    }
    
    // canMoveRowAt은 테이블뷰의 row의 위치를 이동할 수 있는지 없는지 설정합니다.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    /*
     moveRowAt은 테이블 뷰의 row 의 위치가 변화하였을 때, 원하는 작업을 해줄 수 있습니다.
     지금 이 프로젝트에서는 editing mode 에서 row 를 변화 시킴에 따라 이 함수가 실행됩니다.
     */
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        /*
         테이블 뷰 의 row 를 변화시키면 그에 따라 대응되는 모델(데이터)도 변화시켜주어야 합니다.
         sourceIndexPath와 destinationIndexPath를 통해 이동을 시작한 index와 새롭게 설정된 index를 가져올 수 있습니다.
         */
        
        let movingIndex = categoryList[sourceIndexPath.row + 1]
        
        categoryList.remove(at: sourceIndexPath.row + 1)
        categoryList.insert(movingIndex, at: destinationIndexPath.row + 1)
        /*
         commit editingStyle 은 테이블뷰가 edit 된 스타일에 따라 이벤트를 설정할 수 있습니다.
         여기서는 editing mode 에서 한개의 row 를 delete 하였을 경우에 대한 동작을 설정하였습니다.
         */
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteSelectViewController")
            as! DeleteSelectViewController
            
            vc.categoryIdx = categoryList[indexPath.row + 1].category_idx
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
            
            categoryList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
           }
        
    }
    
}

extension EditCategoryViewController {
    func setCategoryData() {
        CategoryService.shared.categoryView() {
            [weak self]
            (data) in
            guard let `self` = self else { return }
            
            switch data {
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                let categoryData = res as? CategoryData
                self.categoryList = categoryData!.category_list
                self.editCategoryTV.reloadData()
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                print("d")
            case .error(_):
                print("d")
            }
        }
    }
}

