//
//  NetworkResult.swift
//  Readit
//
//  Created by 황유선 on 08/07/2019.
//  Copyright © 2019 황유선. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case error(T)
    case pathErr
    case serverErr
    case networkFail
}
