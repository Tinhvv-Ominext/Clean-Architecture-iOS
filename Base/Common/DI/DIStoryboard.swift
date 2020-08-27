//
//  SwinjectStoryboard.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation

extension SwinjectStoryboard {
    public class func setup() {
        let container = DIContainer.instance.main

        container.storyboardInitCompleted(LoginVC.self) { r, c in
            c.basePresenter = BasePresenter()
            c.presenter = LoginPresenter(r.resolve(LoginUC.self)!)
        }
    }
}
