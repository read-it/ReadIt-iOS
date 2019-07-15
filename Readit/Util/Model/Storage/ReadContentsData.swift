//
//  ReadContentsData.swift
//  Readit
//
//  Created by 권서연 on 13/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation
import UIKit

struct ReadContentsData: Codable {
    let highlight_idx: Int
    let contents_idx: Int
    let highlight_date: String
    let highlight_rect: String
}
