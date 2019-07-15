//
//  ContentsSortViewController.swift
//  Readit
//
//  Created by 권서연 on 06/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class ContentsSortViewController: UIViewController {
    @IBOutlet var sortingBox: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewRounded()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.animationUpUI()
    }
    
    @IBAction func backgroundView(_ sender: Any) {
        self.animationDownUI()
    }
    
    func setViewRounded() {
        self.sortingBox.makeRounded(cornerRadius: 10.0)
    }
    
    func animationUpUI() {
        self.view.alpha = 0
        let center = self.sortingBox.center
        self.sortingBox.center = CGPoint(x: center.x, y: center.y + self.sortingBox.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
    
            self.sortingBox.center = center
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            self.view.alpha = 1
        })
    }
    
    func animationDownUI() {
        let center = self.sortingBox.center
        self.sortingBox.center = center
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            
            self.sortingBox.center = CGPoint(x: center.x, y: center.y + self.sortingBox.frame.height)
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            //self.view.layoutIfNeeded()
            self.view.alpha = 0
        })
    }
}
