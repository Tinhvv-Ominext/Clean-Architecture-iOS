//
//  LoginVC.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import UIKit

class LoginVC: BaseVC, LoginView {
    
    var presenter: LoginPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.logging()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        presenter.detachView()
        super.viewDidDisappear(animated)
    }
    
    func onLoginSuccess() {
        
    }

}
