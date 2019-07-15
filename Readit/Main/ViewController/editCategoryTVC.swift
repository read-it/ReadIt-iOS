//
//  editCategoryTVC.swift
//  Readit
//
//  Created by 권서연 on 06/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class editCategoryTVC: UITableViewCell {
    var editBlock: (() -> Void)? = nil
    @IBOutlet var name: UILabel!
    @IBOutlet var editBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func editAction(_ sender: UIButton) {
         editBlock?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
