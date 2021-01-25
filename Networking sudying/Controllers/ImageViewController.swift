//
//  ImageViewController.swift
//  Networking sudying
//
//  Created by DIMa on 22.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        setImageView()
    }
    
    func setActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func setImageView() {
        self.imageView.image = self.image
        self.activityIndicator.stopAnimating()
    }
}
