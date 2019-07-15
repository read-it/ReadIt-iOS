//
//  MypageAlarmViewController.swift
//  Readit
//
//  Created by 황유선 on 07/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class MypageAlarmViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var deviceSetLabel: UILabel!
    @IBOutlet weak var deviceSetButton: UIButton!
    
    
    @IBOutlet weak var pushAlarmSwitch: UISwitch!
    @IBOutlet weak var readitTimeSwitch: UISwitch!
    
    @IBOutlet weak var readitTimeLabel1: UILabel!
    @IBOutlet weak var readitTimeLabel2: UILabel!
    @IBOutlet weak var alarmImage: UIImageView!
    @IBOutlet weak var timeSetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topView.layer.borderWidth = 0.2
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushAlarmSwitch(_ sender: UISwitch) {
        if !sender.isOn {
            //readitTimeSwitch.is
        }
    }
    
    @IBAction func readitTimeSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            readitTimeLabel1.textColor = UIColor.basicTextColor
            readitTimeLabel2.textColor = UIColor.basicTextColor
            timeSetButton.titleLabel?.textColor = UIColor.orangeRed
            alarmImage.image = UIImage(named: "icMypageAlramRed.png")
        } else {
            readitTimeLabel1.textColor = UIColor(red: 206/256, green: 206/256, blue: 206/256, alpha: 1)
            readitTimeLabel2.textColor = UIColor(red: 206/256, green: 206/256, blue: 206/256, alpha: 1)
            timeSetButton.titleLabel?.textColor = UIColor(red: 206/256, green: 206/256, blue: 206/256, alpha: 1)
            alarmImage.image = UIImage(named: "icMypageAlarmGray.png")
        }
    }
    
}
