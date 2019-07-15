//
//  ContentsService.swift
//  Readit
//
//  Created by 권서연 on 13/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//


import Foundation
import Alamofire
import UIKit

struct ContentsService: APIManager {
    static let shared = ContentsService()
    let ContentsURL = url("/contents")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "accesstoken" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjU1LCJpYXQiOjE1NjI4NzQyNTYsImV4cCI6MTU2NTQ2NjI1NiwiaXNzIjoiUmVhZGl0In0.cpGS17PF3-RLRqR2yZ74Q1sBq9ntz3QnlzAk466-XVA"]


func ReadContents(contents_idx: Int, completion: @escaping (NetworkResult<Any>)-> Void) {
    let contentsIdx: Int = contents_idx
    
    let URL = ContentsURL + "/\(contentsIdx)"
    
    Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
        .responseData { response in
            switch response.result {
                
            case .success:
                if let value = response.result.value {
                    if let status = response.response?.statusCode {
                        
                        switch status {
                        case 200:
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(CategorySelectResponse.self, from: value)
                                
                                
                                switch result.success {
                                case true:
                                    completion(.success(result.data))
                                case false:
                                    completion(.error(result.message))
                                }
                            }
                            catch {
                                completion(.pathErr)
                                print(error.localizedDescription)
                                debugPrint(error)
                            }
                            
                        case 400:
                            completion(.pathErr)
                            
                        case 500:
                            completion(.serverErr)
                            
                        default:
                            break
                        }
                    }
                }
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
                break
            }
    }
    
}
    
}
