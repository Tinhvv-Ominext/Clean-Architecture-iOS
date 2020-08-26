//
//  AuthenticationAPI.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import Moya

enum UserAPI {
    case login(String, String) // email + pass
    case register
    case forgotPassword(String) // email
    case changePass(String, String) // oldpass + newpass
}

extension UserAPI {
    
    static func httpHeaders(_ type: HeaderType = .token) -> [String: String] {

        if type == .none {
            return ["Content-Type": "application/json"]
        }

        let token = Global.shared.token ?? ""

        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }
}

extension UserAPI: TargetType {

    var headers: [String : String]? {
        switch self {
        case .login, .register, .forgotPassword:
                return UserAPI.httpHeaders(.none)
            default:
            return UserAPI.httpHeaders()
        }
    }

    var baseURL: URL {
        return baseUrl!
    }

    var path: String {
        switch self {
            case .login:
                return "v1/authentication/jwt/login"
        default:
            return ""
            
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
                return .post
            default:
                return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
            case .login(let email, let password):
                return .requestParameters(parameters: ["username": email,
                                                       "password": password], encoding: JSONEncoding.default)
            default:
                return .requestPlain
        }
    }
}
