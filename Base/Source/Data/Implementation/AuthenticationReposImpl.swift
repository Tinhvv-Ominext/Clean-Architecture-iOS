//
//  AuthenticationReposImpl.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class AuthenticationReposImpl: AuthenticationRepos {
    
    func login(_ userName: String, password: String) -> Observable<User> {
        return userProvider.rx.request(.login(userName, password))
            .asObservable()
            .mapResponseToObject(type: User.self)
    }
    
    func register() -> Observable<User> {
        return userProvider.rx.request(.register)
            .asObservable()
            .mapResponseToObject(type: User.self)
    }
    
    func forgotPassword(_ email: String) -> Observable<Any> {
        return userProvider.rx.request(.forgotPassword(email))
            .asObservable().mapJSON()
    }
    
}
