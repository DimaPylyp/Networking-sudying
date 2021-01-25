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
    
    var image: UIImage? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchImage() {
        networkManager.fetchImage { data in
            self.image = UIImage(data: data)
            guard let image = self.image else { return }
            DispatchQueue.main.async {
                self.coordinator?.goToImageVC(with: image)
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCollectionViewCell
        
        let action = actions[indexPath.row]
        cell.label.text = action.rawValue
        
        if action == .uploadImage && image == nil{
            cell.isUserInteractionEnabled = false
            cell.contentView.backgroundColor = .blue
        } else {
            cell.contentView.backgroundColor = .lightGray
            cell.isUserInteractionEnabled = true
        }
        print(indexPath.row)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.row]
        
        switch action {
        case .showImage:
            fetchImage()
        case .get:
            networkManager.getRequest()
        case .post:
            networkManager.postRequest()
        case .showCourses:
            coordinator?.showCourses()
        case .uploadImage:
            guard let image = image else { return }
            networkManager.uploadImage(image)
            print("uploading")
        }
    }
    
}
