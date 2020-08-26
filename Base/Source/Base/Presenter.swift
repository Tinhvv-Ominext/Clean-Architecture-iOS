//
//  Presenter.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation

protocol Presenter {
    associatedtype T

    func attachView(_ view: T)
    func detachView()

}
