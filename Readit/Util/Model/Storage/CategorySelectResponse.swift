//
//  CategorySelectResponse.swift
//  Readit
//
//  Created by 권서연 on 11/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation

struct CategorySelectResponse: Codable {
    
    var status: Int
    var success: Bool
    var message: String
    var data: CategorySelectData?
}
