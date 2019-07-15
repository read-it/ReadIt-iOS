//
//  ResponseString.swift
//  Readit
//
//  Created by 황유선 on 08/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation

struct ResponseString: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Data?
}

struct Data: Codable {
    let accesstoken: String
    let refreshtoken: String
}

