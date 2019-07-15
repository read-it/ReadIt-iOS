//
//  CategoryViewController.swift
//  Readit
//
//  Created by 권서연 on 04/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var categoryPopupHeight: NSLayoutConstraint!
    @IBOutlet var topView: UIView!
    var categoryList : [CategoryList] = []

    @IBAction func plusButton(_ sender: Any) {
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
        self.animationDownUI()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){}
    
    @IBAction func viewExitAction(_ sender: Any) {
        self.animationUpUI()
    }
    
    func animationDownUI() {
        self.view.alpha = 0
        let center = self.topView.center
        self.topView.center = CGPoint(x: center.x, y: center.y - self.topView.frame.height)
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            //self.view.layoutIfNeeded()
            
            self.topView.center = center
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            self.view.alpha = 1
        })
    }
    
    func animationUpUI() {
        let center = self.topView.center
        self.topView.center = center
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            
            self.topView.center = CGPoint(x: center.x, y: center.y - self.topView.frame.height)
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            //self.view.layoutIfNeeded()
            self.view.alpha = 0
        })
    }
}


extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as? FooCell else {
            // log -> FooCell 로 캐스팅 실패
            return UICollectionViewCell()
        }
        
        let category = categoryList[indexPath.row]
        cell.label.text = category.category_name
        cell.label.sizeToFit()
        
        return cell
    }
    
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = categoryList[indexPath.row]

        let label = UILabel(frame: CGRect.zero)
        label.text = category.category_name
        label.sizeToFit()
        
        return CGSize(width: label.frame.width, height: 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }}


extension  CategoryViewController {
    func setData() {
        CategoryService.shared.categoryView() {
            [weak self]
            (data) in
            guard let `self` = self else { return }
            
            switch data {
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                let categoryData = res as? CategoryData
                self.categoryList = categoryData!.category_list
                self.collectionView.reloadData()
                
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

class FooCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!
    
}
