//
//  ModelService.swift
//  ShareExtension
//
//  Created by 권서연 on 12/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

struct ModelService: APIManager {
    static let shared = ModelService()
    let CategoryURL = url("/category")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "accesstoken" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjE4LCJpYXQiOjE1NjI2ODAwMjYsImV4cCI6MTU2NTI3MjAyNiwiaXNzIjoiUmVhZGl0In0.UhMBC9i7hRlU4IW8FW6hyvaoysB1GfkY-4nTbp5OUxk"]
    
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
                                    let result = try decoder.decode(ModelResponse.self, from: value)
                                    
                                    
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
}
