//
//  CoursesCoordinator.swift
//  Networking sudying
//
//  Created by DIMa on 23.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit

class CoursesCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CoursesViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showCourse(name: String, link: String) {
        let vc = WebViewController()
        vc.coordinator = self
        vc.url = link
        navigationController.pushViewController(vc, animated: true)
    }
}
