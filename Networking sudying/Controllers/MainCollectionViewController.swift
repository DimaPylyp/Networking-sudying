//
//  MainCollectionViewController.swift
//  Networking sudying
//
//  Created by DIMa on 25.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

enum Actions: String, CaseIterable {
    case showImage = "Show Image"
    case get = "Get"
    case post = "Post"
    case showCourses = "Show Courses"
    case uploadImage = "Upload Image"
}

class MainCollectionViewController: UICollectionViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    let networkManager = NetworkManager()
    
    let actions = Actions.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCollectionViewCell
        cell.label.text = actions[indexPath.row].rawValue
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.row]
        
        switch action {
        case .showImage:
            coordinator?.goToImageVC()
        case .get:
            networkManager.getRequest()
        case .post:
            networkManager.postRequest()
        case .showCourses:
            coordinator?.showCourses()
        case .uploadImage:
            print("Upload Image")
        }
    }

}
