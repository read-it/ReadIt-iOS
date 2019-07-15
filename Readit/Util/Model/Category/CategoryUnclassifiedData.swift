//
//  CategoryUnclassifiedData.swift
//  Readit
//
//  Created by 권서연 on 12/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation

struct CategoryUnclassifiedData: Codable {
    let content_list: [UnclassifiedContentList]
}

struct UnclassifiedContentList: Codable {
    let category_name: String
    let category_idx: Int
    let user_idx: Int
    let contents_idx: Int
    let title: String?
    let thumbnail: String?
    let contents_url: String?
    let site_url: String
    let estimate_time: String?
    let created_date: String?
    let read_flag: Int
    let delete_flag: Int
    let highlight_cnt: Int
}
