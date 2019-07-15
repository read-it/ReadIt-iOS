//
//  MypageResponse.swift
//  Readit
//
//  Created by 황유선 on 11/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation

struct MypageResponse: Codable {
    
    var status: Int
    var success: Bool
    var message: String
    var data: UserProfile?
}


