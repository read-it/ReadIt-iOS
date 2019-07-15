//
//  MainService.swift
//  Readit
//
//  Created by 권서연 on 10/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//


import Foundation
import Alamofire
import UIKit

struct StorageService: APIManager {
    
    
    static let shared = StorageService()
    let StorageURL = url("/storage")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "accesstoken" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjU1LCJpYXQiOjE1NjI4NzQyNTYsImV4cCI6MTU2NTQ2NjI1NiwiaXNzIjoiUmVhZGl0In0.cpGS17PF3-RLRqR2yZ74Q1sBq9ntz3QnlzAk466-XVA"]
    
    
    func mainView(completion: @escaping (NetworkResult<Any>)-> Void) {
        
        let URL = self.StorageURL + "/main"
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
                                    let result = try decoder.decode(MainResponse.self, from: value)
                                    
                                    
                                    switch result.success {
                                        case true:
                                            completion(.success(result.data!))
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
    
    func categorySelectView(category_idx: Int, sort: Int, completion: @escaping (NetworkResult<Any>)-> Void) {
        let categoryIdx: String = String(category_idx)
        let sortIdx: String = String(sort)
        
        let URL = self.StorageURL + "/\(categoryIdx)" + "/\(sortIdx)"

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
    

