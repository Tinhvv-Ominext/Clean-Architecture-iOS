//
//  User.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    
    var id: String?
    var token: String?
    var name: String?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        token <- map["token"]
        name <- map["name"]
    }

}
