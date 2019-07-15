//
//  RecentSearchViewController.swift
//  Readit
//
//  Created by 황유선 on 05/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import UIKit

class RecentSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var recentSearchTableView: UITableView!
    @IBOutlet weak var recentSearchView: UIView!
    
    
    
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var searchResultView: UIView!
    
    var dbPath : String = ""
    let dbName : String = "search.db"
    var searchWords : [String]?
    
    let sqlCreate : String = "CREATE TABLE IF NOT EXISTS SEARCH ( "
        + " IDX         INTEGER PRIMARY KEY AUTOINCREMENT , "
        + " SEARCH_WORD  TEXT "
        + ")"
    
    //let sqlSelect : String = "SELECT search_word FROM search"
    var arrayData : [String] = []
    
    var rowIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        
        recentSearchTableView.delegate = self
        recentSearchTableView.dataSource = self
        
        self.recentSearchTableView.separatorColor = UIColor.white
        self.searchField.textFieldUnderLine(line: 2.5, color: UIColor.black)
        
        paddingLeft(field: searchField)
        
        searchResultView.isHidden = true
        
        
        // 내부 DB에 최근 검색어 저장
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docPath = dirPath[0]
        
        dbPath = docPath + "/" + dbName
        print(dbPath)
        
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath as String) {
            //DB 객체 생성
            let database : FMDatabase? = FMDatabase(path: dbPath as String)
            
            if let db = database {
                //DB 열기
                db.open()
                //TABLE 생성
                db.executeStatements(sqlCreate)
                //DB 닫기
                db.close()
                
                NSLog("TABLE 생성 성공")
            } else {
                NSLog("DB 객체 생성 실패")
            }
        }
        
        
        //var select : [String] = []
        
        let database : FMDatabase? = FMDatabase(path: dbPath as String)
        
        if let db = database {
            //DB 열기
            db.open()
            
            let selectSql = "SELECT search_word FROM search ORDER BY idx DESC LIMIT 8"
            
            let results : FMResultSet? = db.executeQuery(selectSql, withArgumentsIn: [])
            
            while results?.next() == true
            {
                if let resultString = results?.string(forColumn: "search_word")
                {
                    arrayData.append(resultString)
                }
            }
            
            print(arrayData)
            db.close()
        }
        
  
        //recentSearchTableView.reloadData()
        
    }

        
    @IBAction func searchDidEndOnExit(_ sender: Any) {
    }
    @IBAction func searchEditingDidBegin(_ sender: Any) {
        searchButton.setImage(UIImage(named: "icCancelBlack.png"), for: UIControl.State.normal)
        self.searchField.textFieldUnderLine(line: 2.5, color: UIColor.grey)
        recentSearchView.isHidden = true

    }
    @IBAction func searchEditingDidEnd(_ sender: Any) {
        searchButton.setImage(UIImage(named: "icSearch.png"), for: UIControl.State.normal)
        self.searchField.textFieldUnderLine(line: 2.5, color: UIColor.black)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        
        if searchField.text != "" {
            recentSearchView.isHidden = true

        } else {
            recentSearchView.isHidden = false

        }
        
        //recentSearchTableView.reloadData()
        
//        let dy = self.view.frame.origin.y
//        if dy != 0 {
//            moveTextField(textField: emailField, moveDistance: Int(dy), up: false)
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //DB 객체 생성
        let database : FMDatabase? = FMDatabase(path: dbPath as String)
        //데이터 입력
        let sqlInsert : String = "INSERT INTO SEARCH (SEARCH_WORD) VALUES ('\(searchField.text!)')"
        
        if let db = database {
            //DB 열기
            db.open()
            //INSERT
            db.executeUpdate(sqlInsert, withArgumentsIn: [])
            
            if !db.hadError() {
                db.commit()
                //searchField.text = ""
            }
            
            //DB 닫기
            db.close()
            
        } else {
            NSLog("DB 객체 생성 실패")
        }
        recentSearchTableView.reloadData()
        
        return true
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        searchField.text = ""
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentSearchTableView.dequeueReusableCell(withIdentifier: "RecentSearchTableViewCell", for: indexPath) as! RecentSearchTableViewCell

        cell.recentSearchLabel.text = arrayData[indexPath.row]
        //cell.recentSearchLabel.text = "나는 최근 검색어다"
        
        //cell.

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowIndex = indexPath.row

    }
    
    //func tableView
    
    @IBAction func deleteButton(_ sender: UIButton) {
        print(rowIndex)
        self.arrayData.remove(at: rowIndex)
        recentSearchTableView.reloadData()
        //delete()
    }
    
//    func delete () {
//
//        //DB 객체 생성
//        let database : FMDatabase? = FMDatabase(path: dbPath as String)
//
////        let deleteSql : String = "DELETE FROM SEARCH WHERE search_word = '\(recentSearchLabel.text)'"
//
//        if let db = database {
//            //DB 열기
//            db.open()
//            //INSERT
//            db.executeUpdate(deleteSql, withArgumentsIn: [])
//
//            if !db.hadError() {
//                db.commit()
//                //searchField.text = ""
//            }
//
//            //DB 닫기
//            db.close()
//
//        } else {
//            NSLog("DB 객체 생성 실패")
//        }
//        recentSearchTableView.reloadData()
//
////        return true
//
//    }
    
    
    func paddingLeft(field: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = UITextField.ViewMode.always
    }
    
}
