//
//  CoordinatorProtocol.swift
//  Networking sudying
//
//  Created by DIMa on 22.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
