//
//  APIManager.swift
//  Readit
//
//  Created by 황유선 on 08/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation

protocol APIManager {}

extension APIManager {
    static func url(_ path: String) -> String {
        return "http://13.209.125.140:3000" + path
    }
}
