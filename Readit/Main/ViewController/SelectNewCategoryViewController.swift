//
//  SelectNewCategoryViewController.swift
//  Readit
//
//  Created by 권서연 on 08/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class SelectNewCategoryViewController: UIViewController {
    @IBOutlet var contentsTV: UITableView!
    var unclassifiedList : [UnclassifiedContentList] = []
    var selectRow = [Int]()
    var newName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentsTV.delegate = self
        self.contentsTV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func completeAction(_ sender: UIBarButtonItem) {
        
        CategoryService.shared.addCategoryView(category_name: newName, contents_idx: selectRow) {
            [weak self]
            (data) in
            
            guard let `self` = self else { return }
            
            switch data {
            case .success:
                print("카테고리 추가 성공")
                self.dismiss(animated: true, completion: nil)
                
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
    
    func registerTVC() {
        
        let nibName = UINib(nibName: "contentsTVC", bundle: nil)
        contentsTV.register(nibName, forCellReuseIdentifier: "contentsTVC")
    }
}

extension SelectNewCategoryViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(unclassifiedList)
        return unclassifiedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentsTV.dequeueReusableCell(withIdentifier: "contentsTVC") as! contentsTVC
        
        let contents = unclassifiedList[indexPath.row]
        let thumbImg = UIImage(named: "Thumbnail")
        
        cell.title.text = contents.title
        cell.address!.setTitle(contents.contents_url, for: .normal)
        
        cell.category.setTitle(contents.category_name, for: .normal)
        
        cell.date.text = contents.estimate_time
        
        cell.highlightCount.text = String(contents.highlight_cnt)
        
        if contents.thumbnail != nil {
            cell.thumbnail!.kf.setImage(with: URL(string: contents.thumbnail!), placeholder: thumbImg)
        } else {
            cell.setConstraint()
        }
        
        if contents.read_flag == 1 {
            cell.isRead()
        } else {
            cell.isUnRead()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 100, width: tableView.frame.width, height: tableView.rowHeight))
        return headerView
    }
    
}

extension SelectNewCategoryViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = contentsTV.dequeueReusableCell(withIdentifier: "contentsTVC") as! contentsTVC
       cell.selectView.isHidden = false
        selectRow.append(unclassifiedList[indexPath.row].contents_idx)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
