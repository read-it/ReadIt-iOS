//
//  MypageScrapViewController.swift
//  Readit
//
//  Created by 황유선 on 07/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit
import Kingfisher

class MypageScrapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var scrapButton: UIButton!
    @IBOutlet weak var highlightButton: UIButton!
    
    @IBOutlet weak var scrapView: UIView!
    @IBOutlet weak var highlightView: UIView!
    
    @IBOutlet weak var scrapLabel1: UILabel!
    @IBOutlet weak var scrapLabel2: UILabel!
    @IBOutlet weak var highlightLabel1: UILabel!
    @IBOutlet weak var highlightLabel2: UILabel!
    
    @IBOutlet weak var scrapTableView: UITableView!
    
    var contentsList : [MainContentsList] = []
    var cateContentsList : [CateContentsList] = []
    var scrapList : [ScrapArray] = []
    
    //var userProfile : [UserProfile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topView.layer.borderWidth = 0.2
        profileImage.roundedImage()
        
        scrapButton.layer.cornerRadius = 4
        highlightButton.layer.cornerRadius = 4
        
        highlightView.isHidden = true
        
        self.registerTVC()
        
        scrapTableView.delegate = self
        scrapTableView.dataSource = self
        
        scrapTableView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserProfile()
    }
    
    @IBAction func scrapButton(_ sender: UIButton) {
        scrapLabel1.textColor = UIColor.white
        scrapLabel2.textColor = UIColor.white
        highlightLabel1.textColor = UIColor.whiteOpa
        highlightLabel2.textColor = UIColor.whiteOpa
        highlightView.isHidden = true
        scrapView.isHidden = false
    }
    
    @IBAction func highlightButton(_ sender: UIButton) {
        highlightLabel1.textColor = UIColor.white
        highlightLabel2.textColor = UIColor.white
        scrapLabel1.textColor = UIColor.whiteOpa
        scrapLabel2.textColor = UIColor.whiteOpa
        scrapView.isHidden = true
        highlightView.isHidden = false
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
                
                self.nicknameLabel.text = userProfile!.nickname
                self.emailLabel.text = userProfile!.email
                
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
                let alert = UIAlertController(title: "회원가입 실패", message: "네트워크 에러", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인",style: .default)
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
            
            
            }
        }
    }
    
    func registerTVC() {
        let nibName = UINib(nibName: "contentsTVC", bundle: nil)
        scrapTableView.register(nibName, forCellReuseIdentifier: "contentsTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(cateContentsList.count)
        //return cateContentsList.count
        
       return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scrapTableView.dequeueReusableCell(withIdentifier: "contentsTVC") as! contentsTVC
        
        //let scraps = scrapList[indexPath.row]
        
//        let contents = cateContentsList[indexPath.row]
//        let thumbImg = UIImage(named: "Thumbnail")
        
        cell.title.text = "스크랩"

        return cell
        
//        let cell = scrapTableView.dequeueReusableCell(withIdentifier: "contentsTVC") as! contentsTVC
//                let contents = cateContentsList[indexPath.row]
//                let thumbImg = UIImage(named: "Thumbnail")
//
//                cell.title.text = contents.title
//                cell.address!.setTitle(contents.site_url, for: .normal)
//
//                cell.category.setTitle(contents.category_name, for: .normal)
//
//                cell.date.text = contents.after_create_date
//
//                cell.highlightCount.text = String(contents.highlight_cnt)
//
//                if contents.thumbnail != nil {
//                    cell.thumbnail!.kf.setImage(with: URL(string: contents.thumbnail!), placeholder: thumbImg)
//                } else {
//                    cell.setConstraint()
//                }
//
//                if contents.fixed_date == nil {
//                    cell.clip.alpha = 0
//                }
//
//                if contents.read_flag == 1 {
//                    cell.isRead()
//                } else {
//                    cell.isUnRead()
//                }
//
//        //        if contentsList.count == 0 {
//        //            defaultView.isHidden = false
//        //        }
//
//        //        cell.buttonPressed = {
//        //            let seeMoreDVC = ContentsMoreViewController()
//        //
//        //            seeMoreDVC.modalPresentationStyle = .overCurrentContext
//        //            seeMoreDVC.modalTransitionStyle = .coverVertical
//        //
//        //            self.present(seeMoreDVC, animated: true, completion: nil)
//        //        }
//
//                return cell
    }
    
    
    
    
    
}


//extension MypageScrapViewController : UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cateContentsList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = scrapTableView.dequeueReusableCell(withIdentifier: "contentsTVC") as! contentsTVC
//        let contents = cateContentsList[indexPath.row]
//        let thumbImg = UIImage(named: "Thumbnail")
//
//        cell.title.text = contents.title
//        cell.address!.setTitle(contents.site_url, for: .normal)
//
//        cell.category.setTitle(contents.category_name, for: .normal)
//
//        cell.date.text = contents.after_create_date
//
//        cell.highlightCount.text = String(contents.highlight_cnt)
//
//        if contents.thumbnail != nil {
//            cell.thumbnail!.kf.setImage(with: URL(string: contents.thumbnail!), placeholder: thumbImg)
//        } else {
//            cell.setConstraint()
//        }
//
//        if contents.fixed_date == nil {
//            cell.clip.alpha = 0
//        }
//
//        if contents.read_flag == 1 {
//            cell.isRead()
//        } else {
//            cell.isUnRead()
//        }
//
////        if contentsList.count == 0 {
////            defaultView.isHidden = false
////        }
//
////        cell.buttonPressed = {
////            let seeMoreDVC = ContentsMoreViewController()
////
////            seeMoreDVC.modalPresentationStyle = .overCurrentContext
////            seeMoreDVC.modalTransitionStyle = .coverVertical
////
////            self.present(seeMoreDVC, animated: true, completion: nil)
////        }
//
//        return cell
//    }
//
////    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////        let headerView = UIView(frame: CGRect(x: 0, y: 100, width: tableView.frame.width, height: tableView.rowHeight))
////        return headerView
////    }
//
//}

