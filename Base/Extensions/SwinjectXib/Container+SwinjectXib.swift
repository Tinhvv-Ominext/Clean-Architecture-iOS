//
//  Container+SwinjectXib.swift
//  Drjoy
//
//  Created by tinhvv-ominext on 8/17/17.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import Swinject
extension Container {
    /// Adds a registration of the specified view or window controller that is configured in a xib.
    ///
    /// - Note: Do NOT explicitly resolve the controller registered by this method.
    ///         The controller is intended to be resolved by `SwinjectStoryboard` implicitly.
    ///
    /// - Parameters:
    ///   - controllerType: The controller type to register as a service type.
    ///                     The type is `UIViewController`
    ///   - name:           A registration name, which is used to differenciate from other registrations
    ///                     that have the same view controller type.
    ///   - initCompleted:  A closure to specifiy how the dependencies of the view controller are injected.
    ///                     It is invoked by the `Container` when the view controller is instantiated by `SwinjectXib`.
    public func xibInitCompleted<C: Controller>(_ controllerType: C.Type, name: String? = nil, initCompleted: @escaping (Resolver, C) -> Void) {
        let factory = { (_: Resolver, controller: Controller) in controller }
        let wrappingClosure: (Resolver, Controller) -> Void = { r, c in initCompleted(r, c as! C) }
        let option = SwinjectXibOption(controllerType: controllerType)
        _register(Controller.self, factory: factory, name: name, option: option)
            .initCompleted(wrappingClosure)

    }
}
