//
//  AuthenticationRepos.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthenticationRepos {
    func login(_ userName: String, password: String) -> Observable<User>
    func register() -> Observable<User>
    func forgotPassword(_ email: String) -> Observable<Any>
}
