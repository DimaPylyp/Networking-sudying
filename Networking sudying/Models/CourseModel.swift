//
//  CourseModel.swift
//  Networking sudying
//
//  Created by DIMa on 24.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import Foundation

struct Course: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
