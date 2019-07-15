//
//  ResponseObject.swift
//  SOPT_24th_iOS_Seminar_4th
//
//  Created by wookeon on 09/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Foundation

struct MainResponse: Codable {
    
    var status: Int
    var success: Bool
    var message: String
    var data: MainData?
 }
