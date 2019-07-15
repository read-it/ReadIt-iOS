//
//  MypageService.swift
//  Readit
//
//  Created by 황유선 on 11/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation
import Alamofire

struct MypageService: APIManager {
    
    static let shared = MypageService()
    let MypageURL = url("/mypage")
    
//    let header: HTTPHeaders = [
//        "Content-Type" : "application/json",
//        "accesstoken" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjE4LCJpYXQiOjE1NjI2ODAwMjYsImV4cCI6MTU2NTI3MjAyNiwiaXNzIjoiUmVhZGl0In0.UhMBC9i7hRlU4IW8FW6hyvaoysB1GfkY-4nTbp5OUxk"
//    ]
    
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "accesstoken" : "\(UserDefaults.standard.string(forKey: "accesstoken")!)"
    ]
    
    // 유저 프로필 조회
    func getProfile(completion: @escaping (NetworkResult<Any>) -> Void) {

        let URL = MypageURL

        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default, headers: header)
            .responseData { response in

                switch response.result {

                case .success:
                    if let value = response.result.value {

                        if let status = response.response?.statusCode {
                            print(status)

                            switch status {
                                
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(MypageResponse.self, from: value)

                                    switch result.success {

                                    case true:
                                        //print("성공")
                                        completion(.success(result.data!))
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
    
    
    // 스크랩 조회
    func getScrap(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = MypageURL + "/scrap/scraplist"
        
        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        
                        if let status = response.response?.statusCode {
                            print(status)
                            
                            switch status {
                                
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(MypageResponse.self, from: value)
                                    
                                    switch result.success {
                                        
                                    case true:
                                        //print("성공")
                                        completion(.success(result.data!))
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
    
    
    
    // 하이라이팅 조회
    func getHighlight() {
        
    }
    
    
    
    // 프로필 수정
    func editProfile (profile_img: UIImage, nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = "http://13.209.125.140:3000/user/setprofile"
        
        print(URL)
        
//        let headers: HTTPHeaders = [
//            "Content-Type" : "multipart/form-data",
//            "accesstoken" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHgiOjE4LCJpYXQiOjE1NjI2ODAwMjYsImV4cCI6MTU2NTI3MjAyNiwiaXNzIjoiUmVhZGl0In0.UhMBC9i7hRlU4IW8FW6hyvaoysB1GfkY-4nTbp5OUxk"
//        ]
        
        Alamofire.upload(multipartFormData: {
            (multipart) in
            
            multipart.append(profile_img.jpegData(compressionQuality: 0.5)!, withName: "profile_img", fileName: "image.jpeg", mimeType: "image/jpeg")
            multipart.append("\(nickname)".data(using: .utf8)!, withName: "nickname")
        }, to: URL, method: .put, headers: header) {
            
            encodingResult in
            switch encodingResult {
                
            case .success(let upload, _, _):
                
                upload.responseData { (response) in
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            print(status)
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(MypageResponse.self, from: value)
                                    
                                    switch result.success {
                                    case true:
                                        print("수정")
                                        completion(.success(result.message))
                                    case false:
                                        completion(.error(result.message))
                                    }
                                } catch {
                                    print("error")
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
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
                break
            }
            
        }

            
            
            
        }
    
    
    
    
    
    // 비밀번호 변경
    
    
    
    
    // 휴지통
    
    
    
    
    // 알림 설정
    
    
    
    
}
