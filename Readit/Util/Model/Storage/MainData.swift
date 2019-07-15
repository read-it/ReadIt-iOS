//
//  Main.swift
//  Readit
//
//  Created by 권서연 on 10/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//
import UIKit
import Foundation

struct MainData: Codable {
    let nickname: String
    let profile_img: String
    let category_list: [MainCategoryList]
    let total_count: Int
    let unread_count: Int
    let current_date: String
    let contents_list: [MainContentsList]
}


struct MainCategoryList: Codable {
    let category_idx: Int
    let category_name: String
}

struct MainContentsList: Codable {
    
    let contents_idx: Int
    let title: String?
    let thumbnail: String?
    let created_date: String
    let estimate_time: String
    let read_flag: Int
    let contents_url: String?
    let site_url: String?
    let fixed_date: String?
    let delete_flag: Int
    let category_idx: Int
    let user_idx: Int
    let highlight_cnt: Int
    let scrap_flag: Int
    let category_name: String
    let after_create_date: String
}
