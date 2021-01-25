//
//  ViewController.swift
//  Networking sudying
//
//  Created by DIMa on 22.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?

    @IBOutlet weak var button: UIButton!
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func showImageTapped(_ sender: UIButton) {
        coordinator?.goToImageVC()
    }
    
    @IBAction func getRequestTapped(_ sender: Any) {
        networkManager.getRequest()
    }
    
    @IBAction func postRequestTapped(_ sender: UIButton) {
        networkManager.postRequest()
    }
    
    @IBAction func showCoursesTapped(_ sender: UIButton) {
        coordinator?.showCourses()
    }
}

