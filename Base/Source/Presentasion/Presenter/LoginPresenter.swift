//
//  LoginPresenter.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import RxSwift

class LoginPresenter: Presenter {
    
    typealias T = LoginView

    var view: LoginView?
    
    private let loginUC: LoginUC
    
    private let disposeBag = DisposeBag()
    
    init(_ loginUC: LoginUC) {
        self.loginUC = loginUC
    }
    
    func attachView(_ view: LoginView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }
    
    func logging() {
        Logger.log(.action, "Test presenter inject...")
    }
    
    /// Login with username and password
    /// - Parameter userName: -
    /// - Parameter password: -
    func login(_ userName: String, password: String) {
        
        view?.onShowLoading()
        
        loginUC.execute(userName, password: password)
            .subscribe(onNext: { [weak self] (user) in
                self?.view?.onHideLoading()
                // TODO: Store user to cache or global
                self?.view?.onLoginSuccess()
            }, onError: { (error) in
                self.view?.onHideLoading()
                self.view?.handleError(error)
            }).disposed(by: disposeBag)
    }
}
