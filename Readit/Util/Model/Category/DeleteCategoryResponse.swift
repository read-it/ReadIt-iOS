//
//  DeleteCategoryResponse.swift
//  Readit
//
//  Created by 권서연 on 12/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation

struct DeleteCategoryResponse: Codable {
    var status: Int
    var success: Bool
    var message: String
}
