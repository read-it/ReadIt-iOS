//
//  CategorySelectData.swift
//  Readit
//
//  Created by 권서연 on 11/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//
import UIKit
import Foundation

struct CategorySelectData: Codable {
    let total_count: Int
    let unread_count: Int
    let current_Date: String?
    let contents_list: [CateContentsList]
}

struct CateContentsList: Codable {
    let contents_idx: Int
    let title: String?
    let thumbnail: String?
    let created_date: String
    let estimate_time: String
    let read_flag: Int
    let contents_url: String?
    let site_url: String
    let fixed_date: String?
    let delete_flag: Int
    let category_idx: Int
    let user_idx: Int
    let highlight_cnt: Int
    let scrap_flag: Int
    let category_name: String
    let after_create_date: String
}
