//
//  BasePresenter.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation

class BasePresenter: Presenter {
    
    typealias T = BaseView

    var view: BaseView?
    
    func attachView(_ view: BaseView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }
    
}
