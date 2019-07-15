//
//  AuthService.swift
//  Readit
//
//  Created by 황유선 on 08/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation
import Alamofire

struct AuthService: APIManager {
    
    //typealias NetworkData = ResponseString
    static let shared = AuthService()
    let AuthURL = url("/user")
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    
    // 회원가입
    func signup(email: String, password: String, repassword: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = AuthURL + "/signup"
        
        let body = [
            "email": email,
            "password": password,
            "repassword": repassword
        ]
        
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
                                    let result = try decoder.decode(ResponseString.self, from: value)
                                    
                                    switch result.success {
                                    case true:
                                        completion(.success(result.message))
                                    case false:
                                        completion(.error(result.message))
                                    }
                                }
                                catch {
                                    completion(.pathErr)
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
    
    
    
    // 로그인
    func login(email: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = AuthURL + "/signin"
        
        let body = [
            "email": email,
            "password": password
        ]
        
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
                                    //print(value)
                                    let result = try decoder.decode(ResponseString.self, from: value)
                                    print(result)
                                    
                                    switch result.success {
                                        
                                    case true:
                                        completion(.success(result.message))
                                    case false:
                                        completion(.error(result.message))
                                    }
                                }
                                catch {
                                    completion(.pathErr)
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
