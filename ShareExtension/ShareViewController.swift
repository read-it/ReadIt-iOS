//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by 권서연 on 09/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit
import Social

class ShareViewController: UIViewController {
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var whiteBox: UIView!
    @IBOutlet var redBox: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    
    var modelList: [ModelList] = []
    
    @IBAction func expandAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if !sender.isSelected {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.tableView.frame.size.height = CGFloat(self.modelList.count*42)
            })
            
            tableView.layoutIfNeeded()
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.tableView.frame.size.height = 0
            })
            tableView.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearButton.layer.borderWidth = 1
        self.clearButton.layer.borderColor = UIColor(red:244/255, green:244/255, blue:244/255, alpha: 1).cgColor
        self.whiteBox.makeRounded(cornerRadius: 3.5)
        self.clearButton.makeRounded(cornerRadius: 2.0)
    
    
        tableViewHeight.constant = CGFloat(modelList.count*42)
        
        tableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }

}

extension ShareViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModelCell") as! ModelCell
        
        let model = modelList[indexPath.row]
        
        cell.label.text = model.category_name
        cell.label.sizeToFit()
        
        return cell
    }
}

extension ShareViewController {
    func setData() {
        ModelService.shared.categoryView() {
            [weak self]
            (data) in
            guard let `self` = self else { return }
            
            switch data {
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                let modelData = res as? ModelData
                self.modelList = modelData!.category_list
                self.tableView.reloadData()
                
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



class ModelCell: UITableViewCell {
    @IBOutlet var label: UILabel!
}
