//
//  DIContainer.swift
//  Base
//
//  Created by tinhvv-ominext on 8/26/20.
//  Copyright © 2020 Ominext JSC. All rights reserved.
//

import Foundation
import Swinject

class DIContainer {
    
    static let instance = DIContainer()
    
    let main: Container = SwinjectStoryboard.defaultContainer
    let test: Container = Container()

    private init() {
        setupMain()

        Container.loggingFunction = nil
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service?
    {
        if Thread.isMainThread
        {
            return self.main.resolve(serviceType)
        }
        else
        {
            var service:Service?
            
            DispatchQueue.main.sync {[weak self] in
                service = self?.main.resolve(serviceType)
            }
            
            return service
        }
    }
    
    private func setupMain() {
        
        main.register(AuthenticationRepos.self) { _ in
            AuthenticationReposImpl()
        }
        
        main.register(LoginUC.self) { r in
            LoginUC(r.resolve(AuthenticationRepos.self)!)
        }
    }
}
