//
//  ViewController.swift
//  readit_test
//
//  Created by 권서연 on 21/06/2019.
//  Copyright © 2019 권서연. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import MenuItemKit

class WebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet var menuView: UIView!
    @IBOutlet var uiWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = URL(string: "https://www.instagram.com/p/BzslOETJ5Nn/?igshid=3zptw8fcksfx")
//        let request = URLRequest(url: url!)
//        uiWebView.loadRequest(request)
//
        let menuController: UIMenuController = UIMenuController.shared
        menuController.setMenuVisible(true, animated: true)
        menuController.arrowDirection = UIMenuController.ArrowDirection.default
        menuController.setTargetRect(CGRect.zero, in: view)
        
        let copyImage = UIImage(named: "icCopyWhite")
        let copyItem = UIMenuItem(title: "dd   d", image: copyImage, action : copy(sender:))
        
        let firstColorImage = UIImage(named: "imgHighlightOrange")
        let firstColorItem = UIMenuItem(title: "dd  d", image: firstColorImage, action: firstColor(sender:))
        
        let secondColorImage = UIImage(named: "icHighlightBlue")
        let secondColorItem = UIMenuItem(title: "ddd   ", image: secondColorImage, action: secondColor(sender:))
        
        let eraserImage = UIImage(named: "icEraserWhite")
        let eraserItem = UIMenuItem(title: "ddd  ", image: eraserImage, action: eraser(sender:))
        
        // Store MenuItem in array.
        let myMenuItems: [UIMenuItem] = [copyItem, firstColorItem, secondColorItem, eraserItem]
        
        // Added MenuItem to MenuController.
        menuController.menuItems = myMenuItems
    }
    
    @objc func copy(sender: UIMenuItem) {
        coping(webView: uiWebView)
    }
    
    @objc func firstColor(sender: UIMenuItem) {
        firsthighlighting(into: uiWebView)
    }
    
    @objc func secondColor(sender: UIMenuItem) {
        secondhighlighting(into: uiWebView)
    }
    
    @objc func eraser(sender: UIMenuItem) {
        erasing(into: uiWebView)
    }
}

func firsthighlighting(into webView: UIWebView) {
    let js = "var sel = window.getSelection(); " +
        "var range = sel.getRangeAt(0); " +
        "var selectedText = range.extractContents();" +
        "var newNode = document.createElement('span'); " +
        "newNode.setAttribute('style','background-color:#FBE6CF'); " +
        "newNode.appendChild(selectedText);" +
        "range.insertNode(newNode);"
    webView.stringByEvaluatingJavaScript(from: js as Any as! String)
}


func secondhighlighting(into webView: UIWebView) {
    let js = "var sel = window.getSelection(); " +
        "var range = sel.getRangeAt(0); " +
        "var selectedText = range.extractContents();" +
        "var newNode = document.createElement('span'); " +
        "newNode.setAttribute('style','background-color:#DBF0ED'); " +
        "newNode.appendChild(selectedText);" +
    "range.insertNode(newNode);"
    webView.stringByEvaluatingJavaScript(from: js as Any as! String)
}

func coping(webView: UIWebView) {
    let js = "function getText() { var sel = window.getSelection().toString(); return sel } getText();"
    UIPasteboard.general.string = webView.stringByEvaluatingJavaScript(from: js) as Any as? String
}

func erasing(into webView: UIWebView) {
    let js = "var sel = window.getSelection(); " +
        "var range = sel.getRangeAt(0); " +
        "var selectedText = range.extractContents();" +
        "var newNode = document.createElement('span'); " +
        "newNode.setAttribute('style','background-color:#ffffff'); " +
        "newNode.appendChild(selectedText);" +
    "range.insertNode(newNode);"
    webView.stringByEvaluatingJavaScript(from: js as Any as! String)
}

class WebView : UIWebView {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
      return false
    }
}
