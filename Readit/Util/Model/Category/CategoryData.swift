//
//  CategoryData.swift
//  Readit
//
//  Created by 권서연 on 12/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation

struct CategoryData: Codable {
    let category_list: [CategoryList]
}

struct CategoryList: Codable {
    let category_idx: Int
    let category_name: String?
}
