//
//  ScrapData.swift
//  Readit
//
//  Created by 황유선 on 13/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation

struct ScrapData: Codable {
    let scrap_idx: Int
    let contents_idx: Int
    let scrap_date: String
    let title: String
    let created_date: String
    let estimate_time: String
    let read_flag: Int
    let contents_url: String
    let fixed_flag: Int
    let delete_flag: Int
    let category_idx: Int
    let user_idx: Int
    let highlight_cnt: Int
    
}

