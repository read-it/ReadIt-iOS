//
//  MainViewController.swift
//  readit_test
//
//  Created by 권서연 on 01/07/2019.
//  Copyright © 2019 권서연. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    @IBOutlet var contentsTV: UITableView!
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var orangeCircle: UIView!
    @IBOutlet var whiteBox: UIView!
    @IBOutlet var categoryCV: UICollectionView!
    @IBOutlet var name: UILabel!
    @IBOutlet var countingView: UIView!
    @IBOutlet var profileBox: UIView!
    @IBOutlet var clearView: UIView!
    @IBOutlet var totalContents: UILabel!
    @IBOutlet var nonRead: UILabel!
    @IBOutlet var toastImg: UIImageView!
    @IBOutlet var plusImg: UIImageView!
    @IBOutlet var toastLabel1: UILabel!
    @IBOutlet var toastLabel2: UILabel!
    @IBOutlet var defaultView: UIView!
    
    var categoryIdx: Int?
    var sortIdx: Int?
    var categoryList : [MainCategoryList] = []
    var mainContentsList : [MainContentsList] = []
    var cateContentsList : [CateContentsList] = []
    var profile : [MainData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setImgRounded()
        self.setViewRounded()
       
        self.registerCVC()
        self.registerTVC()
        
        self.contentsTV.dataSource = self
        self.contentsTV.delegate = self
        
        self.categoryCV.delegate = self
        self.categoryCV.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global().sync {
            setMainData()
        }
        setMainContents()
        
        self.contentsTV.dataSource = self
        self.contentsTV.delegate = self
        
        self.categoryCV.delegate = self
        self.categoryCV.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){}
    
    func setImgRounded() {
        self.profileImg.roundedImage()
    }
    
    func setViewRounded() {
        
        self.orangeCircle.makeRounded(cornerRadius: 3.5)
        self.whiteBox.makeRounded(cornerRadius: 12.0)
    }
    
    func registerTVC() {

        let nibName = UINib(nibName: "contentsTVC", bundle: nil)
        contentsTV.register(nibName, forCellReuseIdentifier: "contentsTVC")
    }

    func registerCVC() {

        let cvcNibName = UINib(nibName: "categoryCVC", bundle: nil)
        categoryCV.register(cvcNibName, forCellWithReuseIdentifier: "categoryCVC")
    }
}

extension MainViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateContentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentsTV.dequeueReusableCell(withIdentifier: "contentsTVC") as! contentsTVC
        let contents = cateContentsList[indexPath.row]
        let thumbImg = UIImage(named: "Thumbnail")
        
        cell.title.text = contents.title
        cell.address!.setTitle(contents.site_url, for: .normal)
        cell.category.setTitle(contents.category_name, for: .normal)
        cell.date.text = contents.after_create_date
        cell.highlightCount.text = String(contents.highlight_cnt)
        
        if contents.thumbnail != nil {
            cell.thumbnail!.kf.setImage(with: URL(string: contents.thumbnail!), placeholder: thumbImg)
        } else {
            cell.setConstraint()
        }
        
        if contents.fixed_date == nil {
            cell.clip.alpha = 0
        }
        
        if contents.read_flag == 1 {
            cell.isRead()
        } else {
            cell.isUnRead()
        }
        
        if cateContentsList.count == 0 {
            defaultView.isHidden = false
        }

        cell.buttonPressed = {
            let seeMoreDVC = ContentsMoreViewController()
            
            seeMoreDVC.modalPresentationStyle = .overCurrentContext
            seeMoreDVC.modalTransitionStyle = .coverVertical

            self.present(seeMoreDVC, animated: true, completion: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 100, width: tableView.frame.width, height: tableView.rowHeight))
        return headerView
    }
    
}

extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 웹 뷰 seque
        let storyboard = UIStoryboard(name: "WebStoryboard", bundle: nil)
        let webDVC = storyboard.instantiateViewController(withIdentifier: "WebStoryboard") as! WebViewController
        present(webDVC, animated: true, completion: nil)
        
        let url = URL(string: cateContentsList[indexPath.row].contents_url!)
        let request = URLRequest(url: url!)
        webDVC.uiWebView.loadRequest(request)

        let contentsIdx = cateContentsList[indexPath.row].contents_idx

        ContentsService.shared.ReadContents(contents_idx: contentsIdx) {
            [weak self]
            (data) in
            guard let `self` = self else { return }

            switch data {
            // 매개변수에 어떤 값을 가져올 것인지
            case .success:
                print("읽음 처리 성공")

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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
}




extension MainViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if(offset > 10) {
            
            self.countingView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 0)
        } else {
            
            self.countingView.frame = CGRect(x: 0, y: 119, width: self.view.bounds.size.width, height: 34 - offset)
        }
    }
}


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categoryList.count == 1 {
            toastImg.isHidden = false
            plusImg.isHidden = false
            toastLabel1.isHidden = false
            toastLabel2.isHidden = false
        }
        
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //auto selected 1st item
        categoryCV.allowsSelection = true
        let indexPathForFirstRow = IndexPath(row: 0, section: 0)
        self.categoryCV?.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: [])
        
        let cell = categoryCV.dequeueReusableCell(withReuseIdentifier: "categoryCVC", for: indexPath) as! categoryCVC
        let category = categoryList[indexPath.row]

        cell.categoryName.text  = category.category_name
        cell.categoryName.sizeToFit()
        cell.orangeView.tag = categoryList[indexPath.row].category_idx
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var idx: Int = 0
        
        let cell = categoryCV.dequeueReusableCell(withReuseIdentifier: "categoryCVC", for: indexPath) as! categoryCVC

        let category_idx = categoryList[indexPath.row].category_idx
        
//        cell.orangeView.viewWithTag(idx)!.isHidden = true
        
        
        cell.orangeView.isHidden = false
        idx = indexPath.row
        
        let sort = 1
        StorageService.shared.categorySelectView(category_idx: category_idx, sort: sort) {
            [weak self]
            (data) in
            guard let `self` = self else { return }

            switch data {
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                let categorySelectData = res as? CategorySelectData
                self.totalContents.text = "\(categorySelectData!.total_count)개"
                self.nonRead.text = "\(categorySelectData!.unread_count)개"

                self.cateContentsList = categorySelectData!.contents_list
                self.contentsTV.reloadData()

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


extension MainViewController: UICollectionViewDelegateFlowLayout {

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
        
        return 22
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
}



extension MainViewController {
    func setMainData() {
        print("first")
        StorageService.shared.mainView() {
            [weak self]
            (data) in
            
            guard let `self` = self else { return }
            
            switch data {
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                let mainData = res as? MainData
                let image = UIImage(named: "Placeholder")
                
                self.name.text = mainData?.nickname
                //print(mainData as Any)
                self.profileImg.kf.setImage(with: URL(string: mainData!.profile_img), placeholder: image)
                
                self.totalContents.text = "\(mainData!.total_count)개"
                self.nonRead.text = "\(mainData!.unread_count)개"
                
                self.categoryList = mainData!.category_list
                self.categoryCV.reloadData()
                
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
    
    func setMainContents() {
        let sort = 1
        
        StorageService.shared.categorySelectView(category_idx: 168, sort: sort) {
            [weak self]
            (data) in
            
            guard let `self` = self else { return }
            
            switch data {
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                let mainContents = res as? CategorySelectData
             
                self.cateContentsList = mainContents!.contents_list
                self.contentsTV.reloadData()
                
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
