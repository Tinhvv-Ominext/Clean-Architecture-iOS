//
//  SwinjectXib.swift
//  Drjoy
//
//  Created by tinhvv-ominext on 8/17/17.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import Swinject
import UIKit

// MARK: xib utils
protocol HavingNib {
    static var nibName: String { get }
}

extension HavingNib where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    /// instance view from xib
    ///
    /// - Parameter translatesAutoresizingMaskIntoConstraints:
    /// - Returns: view
    static func fromNib(translatesAutoresizingMaskIntoConstraints: Bool = true) -> Self {
        guard let view = (nib.instantiate(withOwner: nil, options: nil).first { $0 is Self }) as? Self else {
            fatalError("\(Self.self) doesn't have a nib with name: \(nibName)")
        }
        view.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        return view
    }

}

extension UIViewController {

    /// Inject view controller
    ///
    /// - Parameter container: swinject container
    /// - Returns: injected view controller
    static func inject<T: UIViewController>(container: Resolver = SwinjectStoryboard.defaultContainer) -> T {
        let controller = T()
        self.injectDependency (to: controller, box: Box(container))
        return controller
    }
    /// Inject view controller from xib
    ///
    /// - Parameters:
    ///   - nibName: nib name
    ///   - nibBundleOrNil: bundle
    ///   - container: swinject container
    ///   - translatesAutoresizingMaskIntoConstraints:
    /// - Returns: injected view controller
    static func injectFromNib<T: UIViewController>(nibName: String?, bundle nibBundleOrNil: Bundle? = Bundle.main,
        container: Resolver = SwinjectStoryboard.defaultContainer,
        translatesAutoresizingMaskIntoConstraints: Bool = true) -> T {
        let controller = T(nibName: nibName, bundle: nibBundleOrNil)

        controller.view.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        self.injectDependency (to: controller, box: Box(container))

        return controller
    }

    /// dependency injection
    ///
    /// - Parameters:
    ///   - viewController: view controller to inject
    ///   - box: swinject container boxed
    static private func injectDependency(to viewController: UIViewController, box: Box<Resolver>) {
        guard !viewController.wasInjected else { return }
        defer { viewController.wasInjected = true }

        let registrationName = viewController.swinjectRegistrationName
        if let container = box.value as? _Resolver {
            let option = SwinjectXibOption(controllerType: type(of: viewController))
            typealias FactoryType = ((Resolver, Container.Controller)) -> Any
            _ = container._resolve(name: registrationName, option: option) { (factory: FactoryType) in factory((box.value, viewController)) } as Container.Controller?
        } else {
            fatalError("A type conforming Resolver protocol must conform _Resolver protocol too.")
        }
    }
}
