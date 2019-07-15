//
//  contentsTVCTableViewCell.swift
//  readit_test
//
//  Created by 권서연 on 02/07/2019.
//  Copyright © 2019 권서연. All rights reserved.
//

import UIKit

class contentsTVC: UITableViewCell {
    @IBOutlet var orangeCircle: UIView?
    @IBOutlet var thumbnail: UIImageView?
    @IBOutlet var address: UIButton?
    @IBOutlet var category: UIButton!
    @IBOutlet var whiteCell: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var clip: UIImageView!
    @IBOutlet var highlightCount: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var imgWidth: NSLayoutConstraint!
    @IBOutlet var indentView: UIView!
    @IBOutlet var selectView: UIView!
    
    var buttonPressed : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setViewRounded()
        
    }
    @IBAction func seeMore(_ sender: UIButton) {
        buttonPressed()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setConstraint() {
        imgWidth.constant = 0
    }
    
    func setViewRounded() {
        self.orangeCircle?.makeRounded(cornerRadius: 3.5)
        self.address?.makeRounded(cornerRadius: 4.0)
        self.thumbnail?.makeRounded(cornerRadius: 10.0)
        self.category?.makeRounded(cornerRadius: 4.0)
        self.whiteCell?.makeRounded(cornerRadius: 2.2)
    }
    
    func isClip() {
        self.clip.alpha = 1 ;
    }
    
    func isRead() {
        self.orangeCircle!.isHidden = true
        self.indentView.isHidden = false
    }
    
    func isUnRead() {
        self.orangeCircle!.isHidden = false
        self.indentView.isHidden = true
    }
}
