//
//  APIFactory.swift
//  Knafeh
//
//  Created by Tinh Vu on 4/9/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import Moya

let baseUrl = URL(string: "https://your-server-url/api/")

enum HeaderType {
    case none
    case token
}

let userProvider = MoyaProvider<UserAPI>()
