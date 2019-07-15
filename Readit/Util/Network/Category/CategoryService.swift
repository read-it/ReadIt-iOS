//
//  CategoryService.swift
//  Readit
//
//  Created by 권서연 on 12/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

struct CategoryService: APIManager {
    static let shared = CategoryService()
    let CategoryURL = url("/category")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "accesstoken" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjU1LCJpYXQiOjE1NjI4NzQyNTYsImV4cCI6MTU2NTQ2NjI1NiwiaXNzIjoiUmVhZGl0In0.cpGS17PF3-RLRqR2yZ74Q1sBq9ntz3QnlzAk466-XVA"]
    
    func categoryView(completion: @escaping (NetworkResult<Any>)-> Void) {
        
        let URL = self.CategoryURL
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
                                    let result = try decoder.decode(CategoryResponse.self, from: value)
                                    
                                    
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

    func addCategoryView(category_name: String, contents_idx: [Int], completion: @escaping (NetworkResult<Any>)-> Void) {
        
        let URL = self.CategoryURL
        let body = [
            "category_name": category_name,
            "contents_idx": contents_idx,
            ] as [String : Any]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(CategoryResponse.self, from: value)
                                    
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result.message))
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
    
    
    func deleteCategoryView(default_idx: Int, categoryIdx: Int, deleteFlag: Int, completion: @escaping (NetworkResult<Any>)-> Void) {
        let URL = self.CategoryURL + "/delete" + "/\(categoryIdx)" + "/\(deleteFlag)"
        let body = ["default_idx": default_idx]
        
        
        Alamofire.request(URL, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(CategoryResponse.self, from: value)
                                    
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result.message))
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

