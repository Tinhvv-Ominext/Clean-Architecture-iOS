//
//  SwinjectXibOption.swift
//  Drjoy
//
//  Created by tinhvv-ominext on 8/17/17.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import Swinject
internal struct SwinjectXibOption: ServiceKeyOption {
    internal let controllerType: String

    internal init(controllerType: Container.Controller.Type) {
        self.controllerType = String(reflecting: controllerType)
    }

    internal func isEqualTo(_ another: ServiceKeyOption) -> Bool {
        guard let another = another as? SwinjectXibOption else {
            return false
        }

        return self.controllerType == another.controllerType
    }

    internal var hashValue: Int {
        return controllerType.hashValue
    }

    internal var description: String {
        return "Xib: \(controllerType)"
    }
}
