//
//  CoursesViewController.swift
//  Networking sudying
//
//  Created by DIMa on 23.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class CoursesViewController: UIViewController {
    
    weak var coordinator: CoursesCoordinator?
    let networkManager = NetworkManager()
    
    var courses: [Course]?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CourseTableViewCell.self, forCellReuseIdentifier: "cell")
        
        setupConstraints()
        networkManager.fetchCourses { (courses) in
            self.courses = courses
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureCell(cell: CourseTableViewCell, at indexPath: IndexPath) {
        guard let course = courses?[indexPath.row] else { return }
        cell.nameLabel.text = course.name
        if let numberOfLessons = course.numberOfLessons {
            cell.numberOfLessonsLabel.text = ("Number of lessons: \(numberOfLessons)")
        }
        if let numberOfTests = course.numberOfTests {
            cell.numberOfTestsLabel.text = ("Number of tests: \(numberOfTests)")
        }
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: course.imageUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                cell.courseImageView.image = UIImage(data: imageData)
            }
        }
    }
}

extension CoursesViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseTableViewCell
        configureCell(cell: cell, at: indexPath)
        return cell
    }
}

extension CoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let course = courses?[indexPath.row] else { return }
        coordinator?.showCourse(name: course.name, link: course.link)
    }
}
