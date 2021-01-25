//
//  CourseTableViewCell.swift
//  Networking sudying
//
//  Created by DIMa on 24.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit
import SnapKit

class CourseTableViewCell: UITableViewCell {
    
    let courseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let numberOfLessonsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let numberOfTestsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(courseImageView)
        addSubview(nameLabel)
        addSubview(numberOfLessonsLabel)
        addSubview(numberOfTestsLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        courseImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(courseImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(courseImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(10)
            make.top.equalTo(courseImageView.snp.top)
        }
        
        numberOfTestsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(courseImageView.snp.bottom)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        numberOfLessonsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(numberOfTestsLabel)
            make.bottom.equalTo(numberOfTestsLabel.snp.top).inset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
