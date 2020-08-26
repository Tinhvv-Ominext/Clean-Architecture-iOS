//
//  LoginUC.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import RxSwift

class LoginUC {
    private let repos: AuthenticationRepos
    
    init(_ repos: AuthenticationRepos) {
        self.repos = repos
    }
    
    func execute(_ userName: String, password: String) -> Observable<User> {
        return repos.login(userName, password: password)
    }
}
