//
//  MainCollectionViewController.swift
//  Networking sudying
//
//  Created by DIMa on 25.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

enum Actions: String, CaseIterable {
    case showImage = "Show Image"
    case get = "Get"
    case post = "Post"
    case showCourses = "Show Courses"
    case uploadImage = "Upload Image"
    case uploadFile = "Upload File"
}

class MainCollectionViewController: UICollectionViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    let networkManager = NetworkManager()
    let dataProvider = DataProvider()
    var alert: UIAlertController!
    var filePath: String?
    
    let actions = Actions.allCases
    
    var image: UIImage? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func showAlert() {
        self.alert = UIAlertController(title: "Downloading...", message: "0%", preferredStyle: .alert)
        
        present(alert, animated: false) {
            let action = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.dataProvider.stopDownloading()
            }
            self.alert.addAction(action)
            
            self.alert.view.snp.makeConstraints { make in
                make.height.equalTo(170)
            }
            
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.startAnimating()
            let progressView = UIProgressView()
            progressView.progressTintColor = .blue
            
            self.alert.view.addSubview(activityIndicator)
            self.alert.view.addSubview(progressView)
            
            activityIndicator.snp.makeConstraints { make in
                make.center.equalTo(self.alert.view.snp.center)
            }
            
            progressView.snp.makeConstraints { make in
                make.height.equalTo(2)
                make.width.equalTo(self.alert.view.snp.width)
                make.bottom.equalTo(-44)
            }
            
            self.dataProvider.onProgress = { progress in
                self.alert.message = String(Int(progress * 100)) + "%"
                progressView.progress = Float(progress)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotification()
        
        dataProvider.fileLocation = { location in
            print(location.absoluteString)
            self.filePath = location.absoluteString
            self.postNotification()
            self.alert.dismiss(animated: false, completion: nil)
        }
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
        case .uploadFile:
            dataProvider.startDownload()
            showAlert()
        }
    }
    
}

extension MainCollectionViewController {
    private func registerForNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _,_ in
            
        }
    }
    
    private func postNotification() {
        let content = UNMutableNotificationContent()
        content.body = "Your background transer has been completed. File path: \(filePath!)"
        content.title = "Download complete!"
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "TransferComplete", content: content, trigger: triger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
